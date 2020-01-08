//
//  HomeViewController.m
//  WebJavaBridge
//
//  Created by scj on 2019/12/30.
//  Copyright © 2019 scj. All rights reserved.
//

#import "HomeViewController.h"
#import "ViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    UIButton *navBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navBtn.layer.cornerRadius = 25;
    navBtn.backgroundColor = [UIColor greenColor];
    [navBtn setTitle:@"跳转" forState:UIControlStateNormal];
    navBtn.frame = CGRectMake(150, 200, 100, 50);
    [navBtn addTarget:self action:@selector(navBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navBtn];
}

- (void)navBtnClick {
    [ViewController openViewController];
}

@end
