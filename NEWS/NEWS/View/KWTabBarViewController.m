//
//  KWTabBarViewController.m
//  NEWS
//
//  Created by tarena006 on 16/3/25.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "KWTabBarViewController.h"

@interface KWTabBarViewController ()

@end

@implementation KWTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.tintColor=[UIColor colorWithRed:189.0/255 green:11.0/255 blue:26.0/255 alpha:1];
    
    [self setTabBarItem:[self.tabBar.items objectAtIndex:0]
                  title:@"资讯"
            normalImage:@"MainTabBar_news_normal"
            selectImage:@"MainTabBar_news_active"];
    
    [self setTabBarItem:[self.tabBar.items objectAtIndex:1]
                  title:@"IT圈"
            normalImage:@"MainTabBar_forum_normal"
            selectImage:@"MainTabBar_forum_active"];
    
    [self setTabBarItem:[self.tabBar.items objectAtIndex:2]
                  title:@"发现"
            normalImage:@"MainTabBar_found_normal"
            selectImage:@"MainTabBar_found_active"];
    
    [self setTabBarItem:[self.tabBar.items objectAtIndex:3]
                  title:@"我"
            normalImage:@"MainTabBar_user_normal"
            selectImage:@"MainTabBar_user_active"];
    
    // Do any additional setup after loading the view.
}

//解决tabBar无法改变选中图片
//只能在代码中同时设置正常状态跟选中状态的图片,在sb里面不能设置正常或者选中图片,否则代码设置的不起作用
-(void)setTabBarItem:(UITabBarItem *)tabBarItem title:(NSString*)title normalImage:(NSString*)normal selectImage:(NSString*)select{
    UIImage * homenormalImage = [[UIImage imageNamed:normal]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * homeselectImage = [[UIImage imageNamed:select]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [tabBarItem initWithTitle:title image:homenormalImage selectedImage:homeselectImage];
    tabBarItem.titlePositionAdjustment=UIOffsetMake(0, -3);
    tabBarItem.imageInsets=UIEdgeInsetsMake(6, 0, -6, 0);
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

@end
