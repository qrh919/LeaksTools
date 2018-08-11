#import "UINavigationController+Leaks.h"
#import "NSObject+Leaks.h"
#import <objc/runtime.h>

@implementation UINavigationController (Leaks)

+ (void)load{
    [self swizzleMethod:@selector(popViewControllerAnimated:) withMethod:@selector(sw_popViewControllerAnimated:)];
}

//出栈进行置为yes
-(UIViewController *)sw_popViewControllerAnimated:(BOOL)animated{
    UIViewController *popedVC = [self sw_popViewControllerAnimated:animated];
    extern const void * const kPopedKey;
    objc_setAssociatedObject(popedVC, kPopedKey, @(YES), OBJC_ASSOCIATION_RETAIN);
    return popedVC;
}

@end
