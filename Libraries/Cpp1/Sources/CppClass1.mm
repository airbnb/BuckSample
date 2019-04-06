#import "CppClass1.h"
#import "util.hpp"

@implementation Cpp1
- (NSInteger)add:(NSInteger)a with:(NSInteger)b {
    Num a_cpp = Num(a);
    Num b_cpp = Num(b);
    
    return a_cpp.getNum() + b_cpp.getNum();
}
@end
