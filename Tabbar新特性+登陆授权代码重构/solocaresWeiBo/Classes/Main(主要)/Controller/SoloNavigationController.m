//
//  SoloNavigationController.m
//  solocaresWeiBo
//
//  Created by solocares on 15/11/3.
//  Copyright © 2015年 solocares. All rights reserved.
//

#import "SoloNavigationController.h"

@interface SoloNavigationController ()

@end

@implementation SoloNavigationController
/**
 *  第一次使用这个类的时候会调用（一个类只会调用一次）
 */
+ (void)initialize
{
    //1.设置导航栏主题
    //取出appearance对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    //设置背景
}

//重写push方法，以后随便push都不会出现下面的tabbar了
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
}

@end
