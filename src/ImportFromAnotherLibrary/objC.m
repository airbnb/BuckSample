#import "objC.h"

#import <ImportObjC/ImportObjC-Swift.h>

@implementation objC
+ (void)callSwiftByName:(NSString *)name {
  [Hello sayWithName:name];
}
@end
