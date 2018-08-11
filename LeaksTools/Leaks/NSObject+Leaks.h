//
//  NSObject+Leaks.h
//  LeaksTools
//
//  Created by qrh on 2018/8/10.
//  Copyright © 2018年 qrh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Leaks)

+(void)swizzleMethod:(SEL)originalMethod withMethod:(SEL)swizzledMethod;

-(void)willDealloc;

@end
