//
//  SoloTabBar.m
//  solocaresWeiBo
//
//  Created by solocares on 15/11/2.
//  Copyright © 2015年 solocares. All rights reserved.
//

#import "SoloTabBar.h"
#import "SoloTabBarButton.h"
@interface SoloTabBar()
//创建一个数组
@property (nonatomic, strong)NSMutableArray *tabBarButtons;
@property (nonatomic, weak)UIButton *plusButton;
/**
 *  选中时的button
 */
@property (nonatomic,weak) SoloTabBarButton *selectedButton;
@end
@implementation SoloTabBar

//懒加载
- (NSMutableArray *)tabBarButtons {
    if (_tabBarButtons == nil) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
        
    //添加一个“+”按钮
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateNormal];
        
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateNormal];
        plusButton.bounds = CGRectMake(0, 0, plusButton.currentBackgroundImage.size.width, plusButton.currentBackgroundImage.size.height);
        [self addSubview:plusButton];
         self.plusButton = plusButton;
    }
    return self;
}

/**
*  调用一次创建一个button
*
*  @param item ->NSObject,里面包含了title、image、selectedImage
*/
- (void)addTabBarButtonWithItem:(UITabBarItem *)item{
    
    //1.创建按钮
    SoloTabBarButton *button = [[SoloTabBarButton alloc]init];
    [self addSubview:button];
    //添加按钮到数组
    [self.tabBarButtons addObject:button];
    //2.设置数据
//    [button setTitle:item.title forState:UIControlStateNormal];
//    [button setImage:item.image forState:UIControlStateNormal];
//    [button setImage:item.selectedImage forState:UIControlStateSelected];
//    [button setBackgroundImage:[UIImage imageNamed:@"tabbar_slider"] forState:UIControlStateSelected];
    //2.设置属性
    button.item = item;//封装
    //3.监听按钮的点击
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchDown];
    //4.默认选择第零个按钮
    if (self.tabBarButtons.count == 1) {
        [self buttonClicked:button];
    }
}
//监听按钮点击
- (void)buttonClicked:(SoloTabBarButton *)button {
    //通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectedButton.tag to:button.tag];
    }
    
    /**
     *  3部曲
     */
    //1.让当前选中的按钮取消选中
    self.selectedButton.selected = NO;
    //2.重新点击按钮选中
    button.selected = YES;
    //3.然后他就变成我们选中的按钮
    self.selectedButton = button;
}
/**
 *  设置它的frame
 */
- (void)layoutSubviews {
    [super subviews];
    //调整加号按钮的位置
    CGFloat h = self.frame.size.height;
    CGFloat w = self.frame.size.width;
    self.plusButton.center = CGPointMake(w * 0.5, h * 0.5);
    CGFloat buttonY = 0;
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonW = self.frame.size.width/self.subviews.count;
    for (int index = 0; index < self.tabBarButtons.count; index ++) {
        //1.取出按钮
        SoloTabBarButton *button = self.tabBarButtons[index];
        //2.设置按钮的frame
        CGFloat buttonX = index * buttonW;
        if (index > 1) {
            buttonX = (index +1) * buttonW;
        }
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        //3.绑定按钮
        button.tag = index;
        
    }
    
}
@end
