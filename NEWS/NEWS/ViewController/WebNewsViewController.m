//
//  WebNewsViewController.m
//  NEWS
//
//  Created by tarena006 on 16/3/17.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "WebNewsViewController.h"

/*--------------新闻详情界面--------------*/

@interface WebNewsViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, copy) NSString *contentUrl;

//按钮1事件（剩下4个按钮实现）
- (IBAction)goBack:(UIBarButtonItem *)sender;

@end

@implementation WebNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contentUrl=self.url;
    self.webView.scalesPageToFit=YES;
    self.webView.dataDetectorTypes=UIDataDetectorTypeAll;
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.contentUrl]]];
}

//隐藏NavigationBar，状态栏出现黑条，所以才配置状态栏样式
-(UIStatusBarStyle)preferredStatusBarStyle
{
    //状态栏亮色
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

//左下角返回按键
- (IBAction)goBack:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
