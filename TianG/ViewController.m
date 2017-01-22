//
//  ViewController.m
//  TianG
//
//  Created by Xinle on 2017/1/20.
//  Copyright © 2017年 TaoXinle. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
NSString * const url_string =  @"http://139.196.21.231:8886/";
@interface ViewController ()<UIWebViewDelegate,UIAlertViewDelegate>
{
    UIWebView * webViewP;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView * bgt = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 20)];
    [self.view addSubview:bgt];
    
    bgt.backgroundColor = [UIColor colorWithRed:38.0f/255.0f green:37.0f/255.0f blue:44.0f/255.0f alpha:1];
    
    webViewP = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.frame),
                                                                     CGRectGetHeight(self.view.frame)-20)];
    webViewP.allowsInlineMediaPlayback = YES;
    webViewP.scalesPageToFit = YES;
    webViewP.scrollView.bounces = NO;
    webViewP.delegate = self;
    [webViewP setOpaque:NO];
    [webViewP setBackgroundColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1]];
    [self.view addSubview:webViewP];
    
    
//    NSString * lastUrlStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastUrl"];
//    if (lastUrlStr) {
//        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:lastUrlStr]]];
//    }
//    else
//       [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url_string]]];
    
    [self requestWithParameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

    // Do any additional setup after loading the view, typically from a nib.
}

-(void)requestWithParameters:(NSDictionary *)parameters  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
    {
        __weak __typeof(&*self)weakSelf = self;
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        
        NSString * reqUrlStr = [url_string stringByAppendingString:@"Customer/FlndPwd"];
    
        AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:reqUrlStr]];
        [httpClient setParameterEncoding:AFJSONParameterEncoding];
        [httpClient getPath:@"" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //       NSData *filData = [responseObject newAESDecryptWithPassphrase:CHONGWUSHUONETPASSWORD];
            if (responseObject) {
                NSString *resText = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                if (resText && [resText isEqualToString:@"view"]) {
                    [webViewP loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url_string]]];
                }
                else
                {
                    [weakSelf showError];
                }
            }
            else
                [weakSelf showError];
            
           
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error){
            
            [weakSelf showError];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        }];
        
        
    

}

-(void)showError
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"软件暂时不可用" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    exit(0);
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
