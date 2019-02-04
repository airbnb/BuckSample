//
//  KSZombie.h
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

/* Poor man's zombie tracking.
 *
 * Benefits:
 * - Very low CPU overhead.
 * - Low memory overhead.
 *
 * Limitations:
 * - Not guaranteed to catch all zombies.
 * - Can generate false positives or incorrect class names.
 * - KSZombie itself must be compiled with ARC disabled. You can enable ARC in
 *   your app, but KSZombie must be compiled in a separate library if you do.
 */

#ifndef HDR_BSG_KSZombie_h
#define HDR_BSG_KSZombie_h

#ifdef __cplusplus
extern "C" {
#endif

#include <stdbool.h>
#include <sys/types.h>

/** Enable/disable the zombie tracker.
 *
 * @param isEnabled If true, track zombies (default false)
 */
void bsg_kszombie_setEnabled(bool isEnabled);

/** Get the class of a deallocated object pointer, if it was tracked.
 *
 * @param object A pointer to a deallocated object.
 *
 * @return The object's class name, or NULL if it wasn't found.
 */
const char *bsg_kszombie_className(const void *object);

/** Get the address of the last exception to be deallocated.
 *
 * @return The address, or NULL if no exception has been deallocated yet.
 */
const void *bsg_kszombie_lastDeallocedNSExceptionAddress(void);

/** Get the name of the last exception to be deallocated.
 *
 * @return The name.
 */
const char *bsg_kszombie_lastDeallocedNSExceptionName(void);

/** Get the reason of the last exception to be deallocated.
 *
 * @return The reason.
 */
const char *bsg_kszombie_lastDeallocedNSExceptionReason(void);

#ifdef __cplusplus
}
#endif

#endif // HDR_KSZombie_h
