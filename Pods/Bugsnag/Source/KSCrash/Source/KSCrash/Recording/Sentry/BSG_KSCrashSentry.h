//
//  BSG_KSCrashSentry.h
//
//  Created by Karl Stenerud on 2012-02-12.
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

/** Keeps watch for crashes and informs via callback when on occurs.
 */

#ifndef HDR_BSG_KSCrashSentry_h
#define HDR_BSG_KSCrashSentry_h

#ifdef __cplusplus
extern "C" {
#endif

#include "BSG_KSArchSpecific.h"
#include "BSG_KSCrashType.h"

#include <mach/mach_types.h>
#include <signal.h>
#include <stdbool.h>

typedef enum {
    BSG_KSCrashReservedThreadTypeMachPrimary,
    BSG_KSCrashReservedThreadTypeMachSecondary,
    BSG_KSCrashReservedThreadTypeCount
} BSG_KSCrashReservedTheadType;

typedef struct BSG_KSCrash_SentryContext {
    // Caller defined values. Caller must fill these out prior to installation.

    /** Called by the crash handler when a crash is detected. */
    void (*onCrash)(void);

    /** If true, will suspend threads for user reported exceptions. */
    bool suspendThreadsForUserReported;

    /** If true, will send reports even if debugger is attached. */
    bool reportWhenDebuggerIsAttached;

    /** If true, will trace threads and report binary images. */
    bool threadTracingEnabled;

    /** If true, will record binary images. */
    bool writeBinaryImagesForUserReported;

    // Implementation defined values. Caller does not initialize these.

    /** Threads reserved by the crash handlers, which must not be suspended. */
    thread_t reservedThreads[BSG_KSCrashReservedThreadTypeCount];

    /** If true, the crash handling system is currently handling a crash.
     * When false, all values below this field are considered invalid.
     */
    bool handlingCrash;

    /** If true, a second crash occurred while handling a crash. */
    bool crashedDuringCrashHandling;

    /** If true, the registers contain valid information about the crash. */
    bool registersAreValid;

    /** True if the crash system has detected a stack overflow. */
    bool isStackOverflow;

    /** The thread that caused the problem. */
    thread_t offendingThread;

    /** Address that caused the fault. */
    uintptr_t faultAddress;

    /** The type of crash that occurred.
     * This determines which other fields are valid. */
    BSG_KSCrashType crashType;

    /** Short description of why the crash occurred. */
    const char *crashReason;

    /** The stack trace. */
    uintptr_t *stackTrace;

    /** Length of the stack trace. */
    int stackTraceLength;

    struct {
        /** The mach exception type. */
        int type;

        /** The mach exception code. */
        int64_t code;

        /** The mach exception subcode. */
        int64_t subcode;
    } mach;

    struct {
        /** The exception name. */
        const char *name;

    } NSException;

    struct {
        /** The exception name. */
        const char *name;

    } CPPException;

    struct {
        /** User context information. */
        const void *userContext;

        /** Signal information. */
        const siginfo_t *signalInfo;
    } signal;

    struct {
        /** The exception name. */
        const char *name;

        /** Handled exception report info: */
        const char *overrides; // info set in callbacks
        const char *handledState;
        const char *metadata;
        const char *state; // breadcrumbs, other shared app state
        const char *config; // config options which affect report delivery
        int discardDepth; // number of frames from the top to remove
    } userException;

} BSG_KSCrash_SentryContext;

/** Install crash sentry.
 *
 * @param context Contextual information for the crash handlers.
 *
 * @param crashTypes The crash types to install handlers for.
 *
 * @param onCrash Function to call when a crash occurs.
 *
 * @return which crash handlers were installed successfully.
 */
BSG_KSCrashType
bsg_kscrashsentry_installWithContext(BSG_KSCrash_SentryContext *context,
                                     BSG_KSCrashType crashTypes,
                                     void (*onCrash)(void));

/** Uninstall crash sentry.
 *
 * @param crashTypes The crash types to install handlers for.
 */
void bsg_kscrashsentry_uninstall(BSG_KSCrashType crashTypes);

#ifdef __cplusplus
}
#endif

#endif // HDR_KSCrashSentry_h
