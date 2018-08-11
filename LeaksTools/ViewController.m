//
//  ViewController.m
//  LeaksTools
//
//  Created by qrh on 2018/8/10.
//  Copyright © 2018年 qrh. All rights reserved.
//

#import "ViewController.h"
#import "BViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.edgesForExtendedLayout = UIRectEdgeTop;
    UIButton *pushBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [pushBtn setTitle:@"push" forState:(UIControlStateNormal)];
    [pushBtn setFrame:CGRectMake(0, 100, 100, 100)];
    [pushBtn addTarget:self action:@selector(pushAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:pushBtn];
    
    
}

-(void)pushAction:(UIButton *)sender{
    [self.navigationController pushViewController:[[BViewController alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
