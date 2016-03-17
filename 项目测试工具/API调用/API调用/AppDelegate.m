#import "AppDelegate.h"
#import "webViewController.h"
#import "TableViewController.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window=[[UIWindow alloc]init];
    self.window.rootViewController=[[UINavigationController alloc]initWithRootViewController:[[TableViewController alloc]init]];
    [self.window makeKeyAndVisible];
    
    
    
    
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    // Override point for customization after application launch.
//    self.window.backgroundColor = [UIColor whiteColor];
//    webViewController *web = [[webViewController alloc]init];
//    self.window.rootViewController = web;
//    [self.window makeKeyAndVisible];
    return YES;
}
@end