#import "MyObjcClassInMixedModule.h"

#import <SwiftAndObjc/SwiftAndObjc-Swift.h>

@implementation MyObjcClassInMixedModule
- (void)sayHello:(NSString *)name {
  NSLog(@"Hi %s. I can see %@\n", [name UTF8String], [MyBridgedSwiftClassInMixedModule new]);
}
@end
