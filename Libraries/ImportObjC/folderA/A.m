#import "A.h"

@implementation A
+ (void)sayHello:(NSString *)name {
  printf([[self helloString:name] cStringUsingEncoding:NSUTF8StringEncoding]);
}
+ (NSString *)helloString:(NSString *)name {
  return [NSString stringWithFormat:@"Hello %@\n", name];
}

@end
