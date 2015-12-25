//
//  NewfeatureViewController.m
//  solocaresWeiBo
//
//  Created by 陈诚 on 15/12/23.
//  Copyright © 2015年 solocares. All rights reserved.
//

#import "NewfeatureViewController.h"
#import "SoloTabBarViewController.h"
@interface NewfeatureViewController ()<UIScrollViewDelegate>

@property (nonatomic,weak)UIPageControl *pageControl;
@end

@implementation NewfeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加scrollView
    [self createScrollView];
    //添加PageControl
    [self createPageControl];
}

- (void)createScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    CGFloat imageW = scrollView.frame.size.width;
    CGFloat imageH = scrollView.frame.size.height;
    scrollView.contentSize = CGSizeMake(imageW * 3, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.delegate = self;//要监听scrollView的滚动，就要让self成为scrollView的代理
    [self.view addSubview:scrollView];
    
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%d",i + 1]];
        CGFloat imageX = i * imageW;
        CGFloat imageY = 0;
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        imageView.userInteractionEnabled = YES;
        [scrollView addSubview:imageView];
        //在最后一个图片上添加按钮
        if (i == 2) {
            [self setupLastImageView:imageView];
        }
    }
    //设置背景图片
    self.view.backgroundColor = [UIColor colorWithRed:246.0/256.0 green:246.0/256.0 blue:246.0/256.0 alpha:1.0f];
}
/**
 *  添加内容到最后一个图片上去
 *
 *  @param imageView <#imageView description#>
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    //1.添加开始按钮
    UIButton *startBtn = [[UIButton alloc]init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    //2.设置frame
    CGFloat centerX = imageView.frame.size.width * 0.5;
    CGFloat centerY = imageView.frame.size.height * 0.6;
    startBtn.center =CGPointMake(centerX, centerY);
    startBtn.bounds = (CGRect){CGPointZero, startBtn.currentBackgroundImage.size};
    //3.设置文字
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    [startBtn setTintColor:[UIColor whiteColor]];
    [startBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
    
    //4.添加checkbox
    UIButton *checkbox = [[UIButton alloc]init];
    checkbox.selected = YES;
    [checkbox setTitle:@"分享给大家" forState:UIControlStateNormal];
    [checkbox setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkbox setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    checkbox.bounds = startBtn.bounds;
    CGFloat chekboxCenterX = centerX;
    CGFloat chekboxCenterY = imageView.frame.size.height * 0.5;
    checkbox.center = CGPointMake(chekboxCenterX, chekboxCenterY);
    [checkbox setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    checkbox.titleLabel.font = [UIFont systemFontOfSize:15];
    [checkbox addTarget:self action:@selector(checkboxClicked:) forControlEvents:UIControlEventTouchUpInside];
#if 0
    checkbox.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);//按钮显示范围上下左右切割
    checkbox.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);//btn文字旁的间距
    checkbox.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);//btn图片旁边的间距
#endif
    [imageView addSubview:checkbox];
}
/**
 *  开始微博
 */
- (void)start
{
    //新特性界面不要用push去下一个界面,因为push出来的Ctl实在栈里，会使得新特性Ctl在栈底不易被释放,而且新特性界面没有导航栏，也不能push
    //所以，应该在窗口里面去切换,就相当于push了
    //切换窗口的根控制器，
    self.view.window.rootViewController = [[SoloTabBarViewController alloc]init];
}
- (void)checkboxClicked:(UIButton *)checkbox
{
    //取反，一步ok
    checkbox.selected = !checkbox.isSelected;
}
- (void)createPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.numberOfPages = 3;
    CGFloat centerX = self.view.frame.size.width/2;
    CGFloat centerY = self.view.frame.size.height - 30;
    pageControl.center = CGPointMake(centerX, centerY);
    pageControl.bounds = CGRectMake(0, 0, 100, 30);//这里用bounds设置宽高，不会打乱上面设定的X，Y
    pageControl.userInteractionEnabled = NO;//点圆点傍边不能滑动
    [self.view addSubview:pageControl];
    
    //设置圆点颜色
//       pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_checked_point"]];//这种方法是平铺，会有瑕疵
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:253.0/255.0 green:98.0/255.0 blue:42.0/255.0 alpha:1.0f];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl = pageControl;//上面设置了一个属性，这里需要赋值
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  只要scrollView滚动就会调用
 *
 *  @param scrollView <#scrollView description#>
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //1.取出水平方向上的滚动的距离
    CGFloat offsetX = scrollView.contentOffset.x;
    
    //2.求出页码
    double pageDouble = offsetX / scrollView.frame.size.width;
    int pageInt = (int)(pageDouble + 0.5);
    self.pageControl.currentPage = pageInt;
    NSLog(@"%d",pageInt);
    
}
@end
