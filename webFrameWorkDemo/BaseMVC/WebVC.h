//
//  WebVC.h
//  webFrameWorkDemo
//
//  Created by Macx on 2018/3/7.
//  Copyright © 2018年 Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WebVC : UIViewController <WKScriptMessageHandler>

- (void)reloadRequest;

@property(nonatomic,strong)NSString  *urlStr;

@property(nonatomic,strong)WKWebView *webView;

@property(nonatomic,strong)WKWebViewConfiguration *configure;

@end
