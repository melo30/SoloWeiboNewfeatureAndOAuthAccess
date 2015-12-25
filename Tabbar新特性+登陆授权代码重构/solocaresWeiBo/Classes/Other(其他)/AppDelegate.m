//
//  AppDelegate.m
//  solocaresWeiBo
//
//  Created by solocares on 15/10/31.
//  Copyright © 2015年 solocares. All rights reserved.
//

#import "AppDelegate.h"
#import "SoloTabBarViewController.h"
#import "SoloOAuthViewController.h"
#import "SoloAccount.h"
#import "NewfeatureViewController.h"
#import "SoloAccountTool.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
     [self.window makeKeyAndVisible];
    SoloAccount *account = [SoloAccountTool account];
    
    if (account) {//之前登陆成功
        NSString *key = @"CFBundleVersion";
        //取出沙盒上次使用的软件版本号
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *lastVersion = [defaults stringForKey:key];
        //获得当前的软件版本号
        
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
        if (![currentVersion isEqualToString:lastVersion]) {//有新版本
            self.window.rootViewController = [[NewfeatureViewController alloc]init];
            //存储新版本
            [defaults setObject:currentVersion forKey:key];
            [defaults synchronize];
        }else
        {//无新版本
            //显示状态栏
            [UIApplication sharedApplication].statusBarHidden = NO;
            self.window.rootViewController = [[SoloTabBarViewController alloc]init];
        }
    }else {//之前没有登录成功
        self.window.rootViewController = [[SoloOAuthViewController alloc]init];
    }
    self.window.backgroundColor = [UIColor whiteColor];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
