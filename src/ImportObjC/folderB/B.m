#import "B.h"

@implementation B
+ (void)sayHi:(NSString *)name {
  printf("Hi %s\n", [name cStringUsingEncoding:NSUTF8StringEncoding]);
}
@end
