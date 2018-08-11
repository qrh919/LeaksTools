//
//  UIViewController+Leaks.m
//  LeaksTools
//
//  Created by qrh on 2018/8/10.
//  Copyright © 2018年 qrh. All rights reserved.
//

#import "UIViewController+Leaks.h"
#import "NSObject+Leaks.h"
#import <objc/runtime.h>

const void *const kPopedKey = @"kPopedKey";

@implementation UIViewController (Leaks)

+ (void)load{
    [self swizzleMethod:@selector(viewWillAppear:) withMethod:@selector(sw_viewWillAppear:)];
    [self swizzleMethod:@selector(viewDidDisappear:) withMethod:@selector(sw_viewDidDisappear:)];
}
//即将显示
-(void)sw_viewWillAppear:(BOOL)animated{
    [self sw_viewWillAppear:animated];
    objc_setAssociatedObject(self, kPopedKey, @(NO), OBJC_ASSOCIATION_RETAIN);
}
//消失
-(void)sw_viewDidDisappear:(BOOL)animated{
    [self sw_viewDidDisappear:animated];
    if([objc_getAssociatedObject(self, kPopedKey) boolValue]){
        [self willDealloc];
    }
}

@end
