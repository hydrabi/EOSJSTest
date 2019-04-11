//
//  ViewController.m
//  EOSTest
//
//  Created by iMac on 2019/2/28.
//  Copyright © 2019年 iMac. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h>

@interface ViewController ()<WKUIDelegate>
@property (strong, nonatomic)  WKWebView *webView;
@property(nonatomic, strong) WebViewJavascriptBridge * bridge;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self webViewConfig];
    [self bridgePrepare];
}


-(void)webViewConfig{
    WKPreferences *pre = [[WKPreferences alloc] init];
    pre.javaScriptEnabled = YES;
    WKWebViewConfiguration *con = [[WKWebViewConfiguration alloc] init];
    con.preferences = pre;
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,
                                                               self.view.frame.size.height) configuration:con];
    
    [self.view addSubview:self.webView];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"EOSWeb" ofType:@"html" inDirectory:@"/EOSWeb"];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    self.webView.UIDelegate = self;
    [self.webView loadHTMLString:content
                         baseURL:[NSURL fileURLWithPath:
                                  [NSString stringWithFormat:@"%@/EOSWeb/",
                                   [[NSBundle mainBundle] bundlePath]]]];
}

-(void)bridgePrepare{
    [WebViewJavascriptBridge enableLogging];
    self.bridge = [WebViewJavascriptBridge bridge:self.webView];
    [self.bridge setWebViewDelegate:self];

    //交易的方法 from 替换使用自己有eos币的账户，pk使用自己有eos币的私钥，ep使用自己的结点
    [self.bridge callHandler:@"transact" data:@{@"from": @"testnetdd111",
                                                @"to":@"hydrabizz555",
                                                @"quantity":@"0.0001 EOS",
                                                @"memo":@"oc使用eosjs的测试7",
                                                @"pk":@"5KEnxN7ZnJV1NiKeQX1xfkL2qu6RYMH3btKGjYvwnSJ4fRYP12d",
                                                @"ep":@"http://jungle2.cryptolions.io:80"
                                                }
            responseCallback:^(id responseData) {
                NSLog(@"交易返回的结果是: %@", responseData);
            }];

    
    //创建账户的方法
//    [self.bridge callHandler:@"createAccount" data:@{@"creator": @"testnetdd111",
//                                                     @"private_key":@"5KEnxN7ZnJV1NiKeQX1xfkL2qu6RYMH3btKGjYvwnSJ4fRYP12d",
//                                                     @"account":@"hydrabizz133",
//                                                     @"buy_ram_bytes":@(4300),
//                                                     @"stake_net_quantity":@"0.2500 EOS",
//                                                     @"stake_cpu_quantity":@"0.0400 EOS",
//                                                     @"active_pubkey":@"EOS5W1b4odnXA24ktoytaXmpKbx1xHqMVNgL3XA5TnfuUMXjnNCEM",
//                                                     @"owner_pubkey":@"EOS5W1b4odnXA24ktoytaXmpKbx1xHqMVNgL3XA5TnfuUMXjnNCEM",
//                                                     @"ep":@"http://jungle2.cryptolions.io:80"
//                                                     }
//            responseCallback:^(id responseData) {
//                NSLog(@"交易返回的结果是: %@", responseData);
//            }];

}


- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
    
}


@end
