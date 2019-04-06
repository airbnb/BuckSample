#import <Foundation/Foundation.h>


/**
 This class wraps c++ methods in ObjC
 */
@interface Cpp1 : NSObject
- (NSInteger)add:(NSInteger)a with:(NSInteger)b;
+ (NSInteger)add:(NSInteger)a with:(NSInteger)b;
@end
