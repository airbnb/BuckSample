//
//  BSG_KSCrashReportFilter.h
//
//  Created by Karl Stenerud on 2012-02-18.
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

#import "BSG_KSCrashReportFilterCompletion.h"

/**
 * A filter receives a set of reports, possibly transforms them, and then
 * calls a completion method.
 */
@protocol BSG_KSCrashReportFilter <NSObject>

/** Filter the specified reports.
 *
 * @param reports The reports to process.
 * @param onCompletion Block to call when processing is complete.
 */
- (void)filterReports:(NSArray *)reports
         onCompletion:(BSG_KSCrashReportFilterCompletion)onCompletion;

@end

/**
 * Very basic filter that passes through reports untouched.
 *
 * Input: Anything.
 * Output: Same as input (passthrough).
 */
@interface BSG_KSCrashReportFilterPassthrough
    : NSObject <BSG_KSCrashReportFilter>

+ (BSG_KSCrashReportFilterPassthrough *)filter;

@end

/**
 * Passes reports to a series of subfilters, then stores the results of those
 * operations as keyed values in final master reports.
 *
 * Input: Anything
 * Output: NSDictionary
 */
@interface BSG_KSCrashReportFilterCombine : NSObject <BSG_KSCrashReportFilter>

/** Constructor.
 *
 * @param firstFilter The first filter, followed by key, filter, key, ...
 *                    Each "filter" can be id<BSG_KSCrashReportFilter> or an
 * NSArray of filters (which gets wrapped in a pipeline filter).
 */
+ (BSG_KSCrashReportFilterCombine *)filterWithFiltersAndKeys:
    (id)firstFilter, ... NS_REQUIRES_NIL_TERMINATION;

/** Initializer.
 *
 * @param firstFilter The first filter, followed by key, filter, key, ...
 *                    Each "filter" can be id<BSG_KSCrashReportFilter> or an
 * NSArray of filters (which gets wrapped in a pipeline filter).
 */
- (id)initWithFiltersAndKeys:(id)firstFilter, ... NS_REQUIRES_NIL_TERMINATION;

@end

/**
 * A pipeline of filters. Reports get passed through each subfilter in order.
 *
 * Input: Depends on what's in the pipeline.
 * Output: Depends on what's in the pipeline.
 */
@interface BSG_KSCrashReportFilterPipeline : NSObject <BSG_KSCrashReportFilter>

/** The filters in this pipeline. */
@property(nonatomic, readonly, retain) NSArray *filters;

/** Constructor.
 *
 * @param firstFilter The first filter, followed by filter, filter, ...
 */
+ (BSG_KSCrashReportFilterPipeline *)filterWithFilters:
    (id)firstFilter, ... NS_REQUIRES_NIL_TERMINATION;

/** Initializer.
 *
 * @param firstFilter The first filter, followed by filter, filter, ...
 */
- (id)initWithFilters:(id)firstFilter, ... NS_REQUIRES_NIL_TERMINATION;

- (void)addFilter:(id<BSG_KSCrashReportFilter>)filter;

@end

/**
 * Extracts data associated with a key from each report.
 */
@interface BSG_KSCrashReportFilterObjectForKey
    : NSObject <BSG_KSCrashReportFilter>

/** Constructor.
 *
 * @param key The key to search for in each report. If the key is a string,
 *            it will be interpreted as a key path.
 * @param allowNotFound If NO, filtering will stop with an error if the key
 *                      was not found in a report.
 */
+ (BSG_KSCrashReportFilterObjectForKey *)filterWithKey:(id)key
                                         allowNotFound:(BOOL)allowNotFound;

/** Initializer.
 *
 * @param key The key to search for in each report. If the key is a string,
 *            it will be interpreted as a key path.
 * @param allowNotFound If NO, filtering will stop with an error if the key
 *                      was not found in a report.
 */
- (id)initWithKey:(id)key allowNotFound:(BOOL)allowNotFound;

@end

/**
 * Takes values by key from the report and concatenates their string
 * representations.
 *
 * Input: NSDictionary
 * Output: NSString
 */
@interface BSG_KSCrashReportFilterConcatenate
    : NSObject <BSG_KSCrashReportFilter>

/** Constructor.
 *
 * @param separatorFmt Formatting text to use when separating the values. You
 * may include
 *                     %@ in the formatting text to include the key name as
 * well.
 * @param firstKey Series of keys to extract from the source report.
 */
+ (BSG_KSCrashReportFilterConcatenate *)
filterWithSeparatorFmt:(NSString *)separatorFmt
                  keys:(id)firstKey, ... NS_REQUIRES_NIL_TERMINATION;

/** Constructor.
 *
 * @param separatorFmt Formatting text to use when separating the values. You
 * may include
 *                     %@ in the formatting text to include the key name as
 * well.
 * @param firstKey Series of keys to extract from the source report.
 */
- (id)initWithSeparatorFmt:(NSString *)separatorFmt
                      keys:(id)firstKey, ... NS_REQUIRES_NIL_TERMINATION;

@end

/**
 * Fetches subsets of data from the source reports. All other data is discarded.
 *
 * Input: NSDictionary
 * Output: NSDictionary
 */
@interface BSG_KSCrashReportFilterSubset : NSObject <BSG_KSCrashReportFilter>

/** Constructor.
 *
 * @param firstKeyPath Series of key paths to search in the source reports.
 */
+ (BSG_KSCrashReportFilterSubset *)filterWithKeys:
    (id)firstKeyPath, ... NS_REQUIRES_NIL_TERMINATION;

/** Initializer.
 *
 * @param firstKeyPath Series of key paths to search in the source reports.
 */
- (id)initWithKeys:(id)firstKeyPath, ... NS_REQUIRES_NIL_TERMINATION;

@end
