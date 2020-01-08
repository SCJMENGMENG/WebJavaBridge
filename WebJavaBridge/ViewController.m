//
//  ViewController.m
//  WebJavaBridge
//
//  Created by scj on 2019/12/24.
//  Copyright © 2019 scj. All rights reserved.
//

#import "ViewController.h"
#import <Lottie/Lottie.h>
#import <WebKit/WebKit.h>
#import <WebViewJavascriptBridge.h>
#import "UIViewController+TopMost.h"
#import "RTRootNavigationController.h"

@interface ViewController ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, weak) LOTAnimationView *lottieImgHome;
@property (nonatomic, weak) LOTAnimationView *lottieImgPerson;

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) WebViewJavascriptBridge *bridge;

@property (nonatomic, weak) UIButton *btn;

@end

@implementation ViewController

+ (void)openViewController {
    ViewController *vc = [[ViewController alloc] init];
    
    [UIViewController.topMost.rt_navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 150, self.view.bounds.size.width, self.view.bounds.size.height - 150)];
    self.webView.UIDelegate = self;
    [self.view addSubview:self.webView];
    [WebViewJavascriptBridge enableLogging];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"aa.html" ofType:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    [self.webView loadRequest:request];
    
    //给webview建立JS于OC的沟通桥梁
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    //设置代理
    [self.bridge setWebViewDelegate:self];
    
    //JS主动调用OC方法
    // 这是JS会调用getUserIdFromObjC方法，这是OC注册给JS调用的
    // JS需要回调，当然JS也可以传参数过来。data就是JS所传的参数，不一定需要传
    // OC端通过responseCallback回调JS端，JS就可以得到所需要的数据
    [self.bridge registerHandler:@"getUserIdFromObjC" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"---%@",data);
        if (responseCallback) {
            responseCallback(@{@"userId":@"1234567"});
        }
    }];
    
    [self.bridge registerHandler:@"getBlogNameFromObjC" handler:^(id data, WVJBResponseCallback responseCallback) {
        if (responseCallback) {
            responseCallback(@{@"blogName":@"cjcjcj"});
        }
    }];
    
    UIButton *backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame = CGRectMake(0, 50, self.view.bounds.size.width, 50);
    backbtn.backgroundColor = [UIColor redColor];
    [backbtn setTitle:@"返回" forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(backbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backbtn];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 100, self.view.bounds.size.width, 50);
    btn.backgroundColor = [UIColor cyanColor];
    [btn setTitle:@"给h5传值，并且拿到h5处理值之后的回调" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.btn = btn;
}

- (void)playBtnClick {
    [self.lottieImgHome play];
    [self.lottieImgPerson play];
}

- (void)stopBtnClick {
    [self.lottieImgHome stop];
    [self.lottieImgPerson stop];
}

- (void)btnClick {
    //iOS端注册与前端JS中对应的方法，获得回调，然后我们就可以在回调中做我们q需要做的操作
    //直接调用JS端注册的HandleName
    __weak __typeof(&*self)weakSelf = self;
    [self.bridge callHandler:@"getUserInfos" data:@{@"name":@"哈哈"} responseCallback:^(id responseData) {
        NSLog(@"---from js:%@",responseData);
        [weakSelf.btn setTitle:responseData[@"blog"] forState:UIControlStateNormal];
    }];
}

- (void)backbtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    //清除WKwebView缓存
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLCache *cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
    
    WKWebsiteDataStore *dateSore = [WKWebsiteDataStore defaultDataStore];
    [dateSore fetchDataRecordsOfTypes:[WKWebsiteDataStore allWebsiteDataTypes] completionHandler:^(NSArray<WKWebsiteDataRecord *> * _Nonnull records) {
        for (WKWebsiteDataRecord *record in records) {
            [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:record.dataTypes forDataRecords:@[record] completionHandler:^{
                NSLog(@"wkwebview 清楚缓存 ---cookies for %@ deleted success",record.displayName);
            }];
        }
    }];
}

@end
