//
//  ViewController.m
//  TianG
//
//  Created by Xinle on 2017/1/20.
//  Copyright © 2017年 TaoXinle. All rights reserved.
//

#import "ViewController.h"
NSString * const url_string =  @"http://139.196.21.231:8886/";
@interface ViewController ()<UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView * bgt = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 20)];
    [self.view addSubview:bgt];
    
    bgt.backgroundColor = [UIColor colorWithRed:38.0f/255.0f green:37.0f/255.0f blue:44.0f/255.0f alpha:1];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.frame),
                                                                     CGRectGetHeight(self.view.frame)-20)];
    webView.allowsInlineMediaPlayback = YES;
    webView.scalesPageToFit = YES;
    webView.scrollView.bounces = NO;
    webView.delegate = self;
    [webView setOpaque:NO];
    [webView setBackgroundColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1]];
    [self.view addSubview:webView];
    
    
//    NSString * lastUrlStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastUrl"];
//    if (lastUrlStr) {
//        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:lastUrlStr]]];
//    }
//    else
       [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url_string]]];

    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView;
{
    //[self.navigationController showSGProgress];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //[self.navigationController finishSGProgress];
    NSString * string = webView.request.URL.absoluteString;
    
    [[NSUserDefaults standardUserDefaults] setObject:string forKey:@"lastUrl"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
