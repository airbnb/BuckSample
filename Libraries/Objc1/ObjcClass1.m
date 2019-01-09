#import "ObjcClass1.h"

@implementation Objc1
+ (void)sayHello:(NSString *)name {
  printf("Hi %s\n", [name UTF8String]);
}
@end
