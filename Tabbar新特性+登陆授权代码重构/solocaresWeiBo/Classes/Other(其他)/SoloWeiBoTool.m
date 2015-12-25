//
//  SoloWeiBoTool.m
//  solocaresWeiBo
//
//  Created by 陈诚 on 15/12/23.
//  Copyright © 2015年 solocares. All rights reserved.
//

#import "SoloWeiBoTool.h"
#import "NewfeatureViewController.h"
#import "SoloTabBarViewController.h"
@implementation SoloWeiBoTool

+ (void)chooseRootViewCtl;
{
    
    NSString *key = @"CFBundleVersion";
    //取出沙盒上次使用的软件版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:key];
    //获得当前的软件版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if (![currentVersion isEqualToString:lastVersion]) {//有新版本
         [UIApplication sharedApplication].keyWindow.rootViewController = [[NewfeatureViewController alloc]init];
        //存储新版本
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
        
    }else
    {//无新版本
        
       [UIApplication sharedApplication].keyWindow.rootViewController = [[SoloTabBarViewController alloc]init];
        
    }

}
@end
