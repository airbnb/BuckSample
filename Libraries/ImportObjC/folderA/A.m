#import "A.h"

@implementation A
+ (void)sayHello:(NSString *)name {
  printf("Hello %s\n", [name cStringUsingEncoding:NSUTF8StringEncoding]);
}
@end
