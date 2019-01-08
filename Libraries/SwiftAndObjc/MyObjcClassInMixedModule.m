#import "MyObjcClassInMixedModule.h"

@implementation MyObjcClassInMixedModule
- (void)sayHello:(NSString *)name {
  printf("Hi %s\n", [name UTF8String]);
}
@end
