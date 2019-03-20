#import <CoreLocation/CLLocationManagerDelegate.h>
#import "CLLocationManager+AnyPromise.h"
#import <CoreLocation/CLError.h>

#if !(TARGET_OS_TV && (TARGET_OS_EMBEDDED || TARGET_OS_SIMULATOR))

@interface PMKLocationManager : CLLocationManager <CLLocationManagerDelegate> {
@public
    PMKResolver resolve;
    id retainCycle;
    BOOL (^block)(CLLocation *);
}
@end

@implementation PMKLocationManager

#define PMKLocationManagerCleanup() \
    [manager stopUpdatingLocation]; \
    retainCycle = self.delegate = nil;

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSMutableArray *okd = [NSMutableArray new];
    for (id location in locations)
        if (block(location))
            [okd addObject:location];
    
    if (okd.count) {
        resolve(PMKManifold(okd.lastObject, okd));
        PMKLocationManagerCleanup();
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    // Apple docs say to ignore this error
    if (error.code != kCLErrorLocationUnknown) {
        resolve(error);
        PMKLocationManagerCleanup();
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    [manager startUpdatingLocation];
}

@end



@implementation CLLocationManager (PromiseKit)

+ (AnyPromise *)promise {
    return [self until:^BOOL(CLLocation *location){
        return location.horizontalAccuracy <= 500 && location.verticalAccuracy <= 500;
    }];
}

+ (AnyPromise *)until:(BOOL(^)(CLLocation *))block {
    PMKLocationManager *manager = [PMKLocationManager new];
    manager.delegate = manager;
    manager->block = block;
    manager->retainCycle = manager;
#if TARGET_OS_IPHONE
    if ([manager respondsToSelector:@selector(requestWhenInUseAuthorization)])
        [manager requestWhenInUseAuthorization];
#endif
    [manager startUpdatingLocation];
    return [[AnyPromise alloc] initWithResolver:&manager->resolve];
}

@end

#endif
