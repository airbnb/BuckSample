#import <Foundation/Foundation.h>

/**
 This class wraps c++ methods in ObjC
 */
@interface Cpp1 : NSObject
- (NSInteger)add:(NSInteger)a with:(NSInteger)b
NS_SWIFT_NAME(add(_:_:));

+ (NSInteger)add:(NSInteger)a with:(NSInteger)b
NS_SWIFT_NAME(add(_:_:));
@end
