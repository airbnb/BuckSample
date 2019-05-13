#import "CppClass1.h"
#import "util.hpp"

@implementation Cpp1
- (NSInteger)add:(NSInteger)a with:(NSInteger)b {
    CppObject cpp = CppObject();

    return cpp.add(a, b);
}

+ (NSInteger)add:(NSInteger)a with:(NSInteger)b {
    return CppObject::static_add(a, b);
}
@end
