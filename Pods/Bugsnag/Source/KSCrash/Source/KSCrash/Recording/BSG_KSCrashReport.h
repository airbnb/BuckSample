//
//  BSG_KSCrashReport.h
//
//  Created by Karl Stenerud on 2012-01-28.
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

/* Writes a crash report to disk.
 */

#ifndef HDR_BSG_KSCrashReport_h
#define HDR_BSG_KSCrashReport_h

#ifdef __cplusplus
extern "C" {
#endif

#include "BSG_KSCrashContext.h"

/** Write a standard crash report to a file.
 *
 * @param crashContext Contextual information about the crash and environment.
 *                     The caller must fill this out before passing it in.
 *
 * @param path The file to write to.
 */
void bsg_kscrashreport_writeStandardReport(BSG_KSCrash_Context *crashContext,
                                           const char *path);

/** Write a minimal crash report to a file.
 *
 * @param crashContext Contextual information about the crash and environment.
 *                     The caller must fill this out before passing it in.
 *
 * @param path The file to write to.
 */
void bsg_kscrashreport_writeMinimalReport(
    BSG_KSCrash_Context *const crashContext, const char *path);

/** Write minimal information about the crash to the log.
 *
 * @param crashContext Contextual information about the crash and environment.
 *                     The caller must fill this out before passing it in.
 */
void bsg_kscrashreport_logCrash(const BSG_KSCrash_Context *const crashContext);

#ifdef __cplusplus
}
#endif

#endif // HDR_KSCrashReport_h
