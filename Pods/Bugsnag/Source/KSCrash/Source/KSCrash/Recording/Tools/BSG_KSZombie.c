//
//  KSZombie.m
//
//  Created by Karl Stenerud on 2012-09-15.
//
//  Copyright (c) 2012 Karl Stenerud. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall remain in place
// in this source code.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#include "BSG_KSZombie.h"
#include "BSG_KSLogger.h"
#include "BSG_KSObjC.h"

#include <objc/runtime.h>

#define CACHE_SIZE 0x8000

// Compiler hints for "if" statements
#define likely_if(x) if (__builtin_expect(x, 1))
#define unlikely_if(x) if (__builtin_expect(x, 0))

typedef struct {
    const void *object;
    const char *className;
} BSG_Zombie;

static volatile BSG_Zombie *bsg_g_zombieCache;
static size_t bsg_g_zombieHashMask;

static struct {
    Class class;
    const void *address;
    char name[100];
    char reason[900];
} bsg_g_lastDeallocedException;

static inline size_t hashIndex(const void *object) {
    uintptr_t objPtr = (uintptr_t)object;
    objPtr >>= (sizeof(object) - 1);
    return objPtr & bsg_g_zombieHashMask;
}

static bool copyStringIvar(const void *self, const char *ivarName, char *buffer,
                           size_t bufferLength) {
    Class class = object_getClass((id)self);
    BSG_KSObjCIvar ivar = {0};
    likely_if(bsg_ksobjc_ivarNamed(class, ivarName, &ivar)) {
        void *pointer;
        likely_if(bsg_ksobjc_ivarValue(self, ivar.index, &pointer)) {
            likely_if(bsg_ksobjc_isValidObject(pointer)) {
                likely_if(bsg_ksobjc_copyStringContents(pointer, buffer,
                                                        bufferLength) > 0) {
                    return true;
                }
                else {
                    BSG_KSLOG_DEBUG("ksobjc_copyStringContents %s failed",
                                    ivarName);
                }
            }
            else {
                BSG_KSLOG_DEBUG("ksobjc_isValidObject %s failed", ivarName);
            }
        }
        else {
            BSG_KSLOG_DEBUG("ksobjc_ivarValue %s failed", ivarName);
        }
    }
    else {
        BSG_KSLOG_DEBUG("ksobjc_ivarNamed %s failed", ivarName);
    }
    return false;
}

static void storeException(const void *exception) {
    bsg_g_lastDeallocedException.address = exception;
    copyStringIvar(exception, "name", bsg_g_lastDeallocedException.name,
                   sizeof(bsg_g_lastDeallocedException.name));
    copyStringIvar(exception, "reason", bsg_g_lastDeallocedException.reason,
                   sizeof(bsg_g_lastDeallocedException.reason));
}

static inline void handleDealloc(const void *self) {
    volatile BSG_Zombie *cache = bsg_g_zombieCache;
    likely_if(cache != NULL) {
        BSG_Zombie *zombie = (BSG_Zombie *)cache + hashIndex(self);
        zombie->object = self;
        Class class = object_getClass((id)self);
        zombie->className = class_getName(class);
        for (; class != nil; class = class_getSuperclass(class)) {
            unlikely_if(class == bsg_g_lastDeallocedException.class) {
                storeException(self);
            }
        }
    }
}

#define BSG_CREATE_ZOMBIE_HANDLER_INSTALLER(CLASS)                             \
    static IMP bsg_g_originalDealloc_##CLASS;                                  \
    static void handleDealloc_##CLASS(id self, SEL _cmd) {                     \
        handleDealloc(self);                                                   \
        typedef void (*fn)(id, SEL);                                           \
        fn f = (fn)bsg_g_originalDealloc_##CLASS;                              \
        f(self, _cmd);                                                         \
    }                                                                          \
    static void installDealloc_##CLASS() {                                     \
        Method method = class_getInstanceMethod(objc_getClass(#CLASS),         \
                                                sel_registerName("dealloc"));  \
        bsg_g_originalDealloc_##CLASS = method_getImplementation(method);      \
        method_setImplementation(method, (IMP)handleDealloc_##CLASS);          \
    }                                                                          \
    static void uninstallDealloc_##CLASS() {                                   \
        method_setImplementation(                                              \
            class_getInstanceMethod(objc_getClass(#CLASS),                     \
                                    sel_registerName("dealloc")),              \
            bsg_g_originalDealloc_##CLASS);                                    \
    }

BSG_CREATE_ZOMBIE_HANDLER_INSTALLER(NSObject)
BSG_CREATE_ZOMBIE_HANDLER_INSTALLER(NSProxy)

static void install() {
    size_t cacheSize = CACHE_SIZE;
    bsg_g_zombieHashMask = cacheSize - 1;
    bsg_g_zombieCache = calloc(cacheSize, sizeof(*bsg_g_zombieCache));
    if (bsg_g_zombieCache == NULL) {
        BSG_KSLOG_ERROR("Error: Could not allocate %ld bytes of memory. "
                        "KSZombie NOT installed!",
                        cacheSize * sizeof(*bsg_g_zombieCache));
        return;
    }

    bsg_g_lastDeallocedException.class = objc_getClass("NSException");
    bsg_g_lastDeallocedException.address = NULL;
    bsg_g_lastDeallocedException.name[0] = 0;
    bsg_g_lastDeallocedException.reason[0] = 0;

    installDealloc_NSObject();
    installDealloc_NSProxy();
}

static void uninstall(void) {
    uninstallDealloc_NSObject();
    uninstallDealloc_NSProxy();

    void *ptr = (void *)bsg_g_zombieCache;
    bsg_g_zombieCache = NULL;
    dispatch_time_t tenSeconds =
        dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC));
    dispatch_after(tenSeconds, dispatch_get_main_queue(), ^{
      free(ptr);
    });
}

void bsg_kszombie_setEnabled(bool shouldEnable) {
    bool isCurrentlyEnabled = bsg_g_zombieCache != NULL;
    if (shouldEnable && !isCurrentlyEnabled) {
        install();
    } else if (!shouldEnable && isCurrentlyEnabled) {
        uninstall();
    }
}

const char *bsg_kszombie_className(const void *object) {
    volatile BSG_Zombie *cache = bsg_g_zombieCache;
    if (cache == NULL || object == NULL) {
        return NULL;
    }

    BSG_Zombie *zombie = (BSG_Zombie *)cache + hashIndex(object);
    if (zombie->object == object) {
        return zombie->className;
    }
    return NULL;
}

const void *bsg_kszombie_lastDeallocedNSExceptionAddress(void) {
    return bsg_g_lastDeallocedException.address;
}

const char *bsg_kszombie_lastDeallocedNSExceptionName(void) {
    return bsg_g_lastDeallocedException.name;
}

const char *bsg_kszombie_lastDeallocedNSExceptionReason(void) {
    return bsg_g_lastDeallocedException.reason;
}
