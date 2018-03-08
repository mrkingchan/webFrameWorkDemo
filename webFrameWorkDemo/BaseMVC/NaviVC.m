//
//  NaviVC.m
//  webFrameWorkDemo
//
//  Created by Macx on 2018/3/7.
//  Copyright © 2018年 Chan. All rights reserved.
//

#import "NaviVC.h"
#import "WebVC.h"

@interface NaviVC ()

@end

@implementation NaviVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    WebVC *VC = [self.viewControllers firstObject];
    if ([VC.urlStr rangeOfString:@"Home"].length) {
        [self setNavigationBarHidden:YES animated:YES];
    }
}

@end
