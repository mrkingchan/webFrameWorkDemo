//
//  TabbarVC.m
//  webFrameWorkDemo
//
//  Created by Macx on 2018/3/7.
//  Copyright © 2018年 Chan. All rights reserved.
//

#import "TabbarVC.h"
#import "WebVC.h"
#import "NaviVC.h"


@interface TabbarVC ()<UITabBarControllerDelegate>

@end

@implementation TabbarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *navis = [NSMutableArray new];
    NSArray *titles = @[@"首页",@"理财",@"发现",@"账户"];
    self.delegate = self;
    NSString *rootStr = @"http://m.qianft.com:8099/";
    NSArray *urls = @[@"Home/Index",@"FinanceCenter/Index",@"Find/Index"];
    for (int i = 0; i < 4; i ++) {
        WebVC *VC = [self viewControllerWithTitle:titles[i] normalImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d",i + 1]] selectedImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d",i + 1]]];
        if (i < 3) {
            VC.urlStr = [NSString stringWithFormat:@"%@%@",rootStr,urls[i]];
        }
        NaviVC *navi = [[NaviVC alloc] initWithRootViewController:VC];
        VC.navigationItem.title = titles[i];
        [navis addObject:navi];
    }
    self.viewControllers = navis;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSInteger index = [self.tabBar.items indexOfObject:item];
    [self setSelectedIndex:index];
    if (index != 3) {
        NSArray *urls = @[@"http://m.qianft.com:8099/Home/Index",@"http://m.qianft.com:8099/FinanceCenter/Index",@"http://m.qianft.com:8099/Find/Index"];
        WebVC *webVC = ((NaviVC *) self.viewControllers[index]).viewControllers[0];
        webVC.urlStr = urls[index];
    }
    
    if ([item isEqual:self.tabBar.items[3]]) {
        //跳转登录
        NaviVC *naviVC = self.viewControllers[3];
        WebVC *VC = [naviVC viewControllers][0];
        VC.urlStr = @"http://m.qianft.com:8099/UserLogin?backurl=%2FMember%2FRecommend";
        
        /*NaviVC *naviVC = self.viewControllers[3];
        WebVC *VC = [naviVC viewControllers][0];
        VC.urlStr = @"http://www.cocoachina.com/bbs/read.php?tid-1677989.html";
        BOOL isLogin;
        if (isLogin) {
            //个人中心
            NaviVC *naviVC = self.viewControllers[3];
            WebVC *VC = [naviVC viewControllers][0];
            VC.urlStr = @"http://www.cocoachina.com/bbs/read.php?tid-1677989.html";
        } else {*/
        /*LoginVC *VC = [LoginVC new];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:VC];
        [self  presentViewController:navi animated:YES completion:nil];*/
    }
}


- (WebVC*)viewControllerWithTitle:(NSString *)titleStr
                                normalImage:(UIImage *)normalImage
                              selectedImage:(UIImage *)selectedImage {
    WebVC *VC = [WebVC new];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:titleStr image:normalImage selectedImage:selectedImage];
    VC.tabBarItem = item;
    return VC;
}
@end
