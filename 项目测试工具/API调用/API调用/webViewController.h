//
//  webTableViewController.h
//  API调用
//
//  Created by tarena05 on 16/3/17.
//  Copyright © 2016年 tarena05. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface webViewController : UIViewController

{
    IBOutlet UIWebView *webView;
    
    UIActivityIndicatorView *activityIndicatorView;
    UIView *opaqueView;
}
@property(nonatomic,strong)NSURL *newsUrl;

@end
