//
//  WebVC.m
//  webFrameWorkDemo
//
//  Created by Macx on 2018/3/7.
//  Copyright © 2018年 Chan. All rights reserved.
//

#import "WebVC.h"
#import <MJRefresh/MJRefresh.h>
#import <LCProgressHUD.h>

#define IToastLoading     [LCProgressHUD showLoading:@""]
#define iToastHide    [LCProgressHUD hide]

@interface WebVC () <WKUIDelegate,WKNavigationDelegate>

@end

@implementation WebVC

-(void)setUrlStr:(NSString *)urlStr {
    _urlStr = urlStr;
    if (urlStr) {
        [self reloadRequest];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _configure = [[WKWebViewConfiguration  alloc] init];
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) configuration: _configure];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [self.view  addSubview:_webView];
    [self reloadRequest];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"LoginSuccess"
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
                                                           self.urlStr = @"http://m.qianft.com:8099/Member/Recommend";

                                                       }];
    
    if (@available(iOS 11.0, *)){
        _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [_webView.scrollView  addLegendHeaderWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_webView.scrollView.header endRefreshing];
        });
        [_webView loadRequest:[NSURLRequest requestWithURL:self.webView.URL]];
    }];
    
    [_configure.userContentController  addScriptMessageHandler:self name:@"functionName"];
}

- (void)reloadRequest {
    if (self.urlStr) {
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]]];
    }
}

#pragma mark  -- WKWebViewDelegate
///开始加载
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    IToastLoading;
}

///加载完毕
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    iToastHide;
}

////加载策略
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSDictionary *headers = navigationAction.request.allHTTPHeaderFields;
    //传token和udid给后台
    decisionHandler(WKNavigationActionPolicyAllow);
}

///响应策略
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSString *messageName = message.name;
    id body = message.body;
    if ([messageName isEqualToString:@"functionName"]) {
         //JS吊起我
    }
}
@end
