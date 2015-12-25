//
//  SoloTabBar.h
//  solocaresWeiBo
//
//  Created by solocares on 15/11/2.
//  Copyright © 2015年 solocares. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SoloTabBar;
@protocol SoloTabBarDelegate <NSObject>
@optional
- (void)tabBar:(SoloTabBar *)tabBar didSelectedButtonFrom: (int)from to:(int)to;
@end
@interface SoloTabBar : UIView

- (void)addTabBarButtonWithItem:(UITabBarItem *)item;
@property (nonatomic,weak) id<SoloTabBarDelegate>delegate;
@end
