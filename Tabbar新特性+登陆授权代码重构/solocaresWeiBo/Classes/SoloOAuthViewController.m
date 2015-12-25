//
//  SoloOAuthViewController.m
//  solocaresWeiBo
//
//  Created by 陈诚 on 15/12/21.
//  Copyright © 2015年 solocares. All rights reserved.
//

#import "SoloOAuthViewController.h"
#import "AFNetworking.h"
#import "SoloAccount.h"
#import "SoloWeiBoTool.h"
#import "SoloAccountTool.h"
#import "MBProgressHUD+MJ.h"
@interface SoloOAuthViewController ()<UIWebViewDelegate>

@end

@implementation SoloOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.添加webView
    UIWebView *webView = [[UIWebView alloc]init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    //2.加载授权界面(新浪提供的登录界面)//或者api.weibo.com改成open.weibo.cn也行
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=2540833631&redirect_uri=http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}
#pragma mark - webViewdelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //显示提醒框
    [MBProgressHUD showMessage:@"哥正在帮你加载中..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //隐藏提醒框
    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //隐藏提醒框
    [MBProgressHUD hideHUD];
}
/**
 *  当webView发送一个请求之前都会先调用此方法,询问代理能不能加载这个页面(请求)
 *  @return YES:可以加载页面 , NO:不可以加载页面
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%@",request.URL);
    //1.请求的URL路径
    NSString *urlStr = request.URL.absoluteString;
    
    //2.查找code=在urlStr中的范围
    NSRange range = [urlStr rangeOfString:@"code="];
    
    //3.如果urlStr中包含了code=
    if (range.length) {//能找到code=
        NSLog(@"找到了 ---%@",urlStr);
        
    //4.截取code=后面的请求标记(经过用户授权成功的)
        long loc = range.location + range.length;
        NSString *code = [urlStr substringFromIndex:loc];
        NSLog(@"url -%@, code -%@",urlStr,code);
        
    //5.***发送POST请求给新浪 通过code换取一个accessToken*****(很关键)
        [self accessTokenWithCode:code];
   }
    return YES;
}
- (void)accessTokenWithCode:(NSString *)code
{
    //AFN
    //1.创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //1.1.设置让新浪返回的数据是一个json数据(默认是二进制的普通文本)
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"2540833631";
    params[@"client_secret"] = @"5524c9e21da448d6f0da9ba392f8c013";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"http://www.baidu.com";
    
    //3.发送请求//或者api.weibo.com改成open.weibo.cn也行
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation,id responseObject) {
        NSLog(@"请求成功:%@",responseObject);
        
        //4.先将accessToken字典转为模型
        SoloAccount *account = [SoloAccount accountWithDict:responseObject];
        
        //5.存储模型数据(归档)
        [SoloAccountTool saveAccount:account];
        
        //6.新特性/去首页
        [SoloWeiBoTool chooseRootViewCtl];//*****重构代码，封装工具类********
        
        //7.隐藏提醒框
        [MBProgressHUD hideHUD];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //隐藏提醒框
        [MBProgressHUD hideHUD];
        NSLog(@"请求失败");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
