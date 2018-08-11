//
//  BViewController.m
//  LeaksTools
//
//  Created by qrh on 2018/8/10.
//  Copyright © 2018年 qrh. All rights reserved.
//

#import "BViewController.h"

@interface BViewController ()
@property (nonatomic, copy) void (^testBlock)(void);
@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation BViewController

-(void)dealloc{
    NSLog(@"------------");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _array = [[NSMutableArray alloc] init];
    //构造block循环引用
    self.testBlock = ^{
        [self.array addObject:@"1"];
    };
    self.testBlock();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
