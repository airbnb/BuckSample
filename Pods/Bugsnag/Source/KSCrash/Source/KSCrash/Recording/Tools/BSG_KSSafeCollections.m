//
//  KSSafeCollections.m
//
//  Created by Karl Stenerud on 2012-08-21.
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

#import "BSG_KSSafeCollections.h"

static inline id safeValue(id value) {
    return value == nil ? [NSNull null] : value;
}

@implementation NSMutableArray (BSG_KSSafeCollections)

- (void)bsg_ksc_addObjectIfNotNil:(id)object {
    if (object != nil) {
        [self addObject:object];
    }
}

- (void)bsg_ksc_safeAddObject:(id)object {
    [self addObject:safeValue(object)];
}

- (void)bsg_ksc_insertObjectIfNotNil:(id)object atIndex:(NSUInteger)index {
    if (object != nil) {
        [self insertObject:object atIndex:index];
    }
}

- (void)bsg_ksc_safeInsertObject:(id)object atIndex:(NSUInteger)index {
    [self insertObject:safeValue(object) atIndex:index];
}

@end

@implementation NSMutableDictionary (BSG_KSSafeCollections)

- (void)bsg_ksc_setObjectIfNotNil:(id)object forKey:(id)key {
    if (object != nil && key != nil) {
        self[key] = object;
    }
}

- (void)bsg_ksc_safeSetObject:(id)object forKey:(id)key {
    self[key] = safeValue(object);
}

- (void)bsg_ksc_setValueIfNotNil:(id)value forKey:(NSString *)key {
    if (value != nil && key != nil) {
        [self setValue:value forKey:key];
    }
}

- (void)bsg_ksc_safeSetValue:(id)value forKey:(NSString *)key {
    [self setValue:safeValue(value) forKey:key];
}

@end
