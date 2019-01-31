//
//  BSG_KSCrashSentry_User.h
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

#ifndef HDR_BSG_KSCrashSentry_User_h
#define HDR_BSG_KSCrashSentry_User_h

#ifdef __cplusplus
extern "C" {
#endif

#include "BSG_KSCrashSentry.h"

#include <signal.h>
#include <stdbool.h>

/** Install the user exception handler.
 *
 * @param context Contextual information for the crash handler.
 *
 * @return true if installation was succesful.
 */
bool bsg_kscrashsentry_installUserExceptionHandler(
    BSG_KSCrash_SentryContext *context);

/** Uninstall the user exception handler.
 */
void bsg_kscrashsentry_uninstallUserExceptionHandler(void);

/** Report a custom, user defined exception.
 * If terminateProgram is true, all sentries will be uninstalled and the
 * application will terminate with an abort().
 *
 * @param name The exception name (for namespacing exception types).
 *
 * @param reason A description of why the exception occurred.
 *
 * @param handledState The severity, reason, and handled-ness of the report
 * @param appState breadcrumbs and other app environmental info
 * @param overrides Report fields overridden by callbacks, collated in the
 *                  final report
 * @param metadata additional information to attach to the report
 * @param discardDepth The number of frames to discard from the top of the
 *                     stacktrace
 *
 * @param terminateProgram If true, do not return from this function call.
 * Terminate the program instead.
 */
    void bsg_kscrashsentry_reportUserException(const char *name, const char *reason,
                                               const char *handledState,
                                               const char *overrides,
                                               const char *metadata,
                                               const char *appState,
                                               const char *config,
                                               int discardDepth,
                                               bool terminateProgram);

#ifdef __cplusplus
}
#endif

#endif // HDR_KSCrashSentry_User_h
