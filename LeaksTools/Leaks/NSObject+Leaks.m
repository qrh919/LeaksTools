#import "NSObject+Leaks.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

@implementation NSObject (Leaks)

-(void)willDealloc{
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf showLeaksAlert];
    });
}

-(void)showLeaksAlert{
    NSString *className = NSStringFromClass([self class]);
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"内存泄漏 %@",className] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertC addAction:action];
    
    [[self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]] presentViewController:alertC animated:YES completion:nil];
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

//方法交换
+(void)swizzleMethod:(SEL)originalMethod withMethod:(SEL)swizzledMethod{
    Class class = [self class];
    Method originalM = class_getInstanceMethod(class, originalMethod);
    Method swizzledM = class_getInstanceMethod(class, swizzledMethod);
    
    BOOL didAddMethod = class_addMethod(class, originalMethod, method_getImplementation(swizzledM), method_getTypeEncoding(swizzledM));
    if(didAddMethod){
        class_replaceMethod(class, swizzledMethod, method_getImplementation(swizzledM), method_getTypeEncoding(swizzledM));
    }else{
        method_exchangeImplementations(originalM, swizzledM);
    }
}

@end






