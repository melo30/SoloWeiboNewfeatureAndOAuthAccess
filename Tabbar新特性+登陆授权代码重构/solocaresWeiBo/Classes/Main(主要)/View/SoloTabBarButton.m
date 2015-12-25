//
//  SoloTabBarButton.m
//  solocaresWeiBo
//
//  Created by solocares on 15/11/2.
//  Copyright © 2015年 solocares. All rights reserved.
//


//图标比例宏
#define SoloTabBarButtonImageRatio 0.6

#import "SoloTabBarButton.h"

@implementation SoloTabBarButton

//前言：因为默认tabbarbutton的图标是左边图片，右边label，我们需要上下排布，所以就要自定义button

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}
//下面是自定义button需要重写的两个方法 imageRect和titleRect：

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * SoloTabBarButtonImageRatio;
    return CGRectMake(0, 0, imageW, imageH);
}
//长按的时候图标不会消失
- (void)setHighlighted:(BOOL)highlighted{
    
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height * (1 - SoloTabBarButtonImageRatio);
    CGFloat titleY = contentRect.size.height * SoloTabBarButtonImageRatio;
    return CGRectMake(0, titleY, titleW, titleH);
}
//注：最后再去SoloTabBar.m里面去导入SoloTabBarButton，将原来自己默认的button改为现在的button
- (void)setItem:(UITabBarItem *)item {
        _item = item;
    
        [self setTitle:item.title forState:UIControlStateNormal];
        [self setImage:item.image forState:UIControlStateNormal];
        [self setImage:item.selectedImage forState:UIControlStateSelected];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        //[self setBackgroundImage:[UIImage imageNamed:@"tabbar_slider"] forState:UIControlStateSelected];
    
}
@end
