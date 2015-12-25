//
//  SoloTabBarViewController.m
//  solocaresWeiBo
//
//  Created by solocares on 15/11/1.
//  Copyright © 2015年 solocares. All rights reserved.
//

#import "SoloTabBarViewController.h"
#import "SoloHomeViewController.h"
#import "SoloMeViewController.h"
#import "SoloMessageViewController.h"
#import "SoloDiscoverTableViewController.h"
#import "SoloTabBar.h"
#import "SoloNavigationController.h"
@interface SoloTabBarViewController ()<SoloTabBarDelegate>
/**
 *  自定义的tabbar
 */
@property (nonatomic,weak)SoloTabBar *customTabBar;
@end

@implementation SoloTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化tabbar
    [self setupTabbar];

    //初始化所有控制器
    [self setupAllChildViewController];
}
- (void)setupTabbar {
    SoloTabBar *customTabBar = [[SoloTabBar alloc]init];
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    //这里要把除了customTabBar以外的按钮全部删掉
    //去viewWillAppear方法里删除
    self.customTabBar = customTabBar;
}
/**
 *  监听tabbar按钮的改变o
 *
 *  @param tabBar <#tabBar description#>
 *  @param from   原来选中的位置
 *  @param to     最新选中的位置
 */
- (void)tabBar:(SoloTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to{
    NSLog(@"---%d----%d",from,to);
    self.selectedIndex = to;
}

//*****如果把这个方法注释掉再把上面[self setupTabbar]注释掉，就是用的系统自己的tabbar*****
- (void)viewWillAppear:(BOOL)animated{
    //注:只要是view开头的方法，都要写这个super
    [super viewWillAppear:animated];
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {//这里UITabBarButton是苹果私有类，不公开的，只能写UIControl类
            [child removeFromSuperview];
        }
    }
    
}
- (void)setupAllChildViewController {
    //首页
    SoloHomeViewController *home = [[SoloHomeViewController alloc]init];
    [self setupChildViewController:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    
    //消息
    SoloMessageViewController *message = [[SoloMessageViewController alloc]init];
    [self setupChildViewController:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    
    
    
    //广场
    SoloDiscoverTableViewController *discover = [[SoloDiscoverTableViewController alloc]init];
    [self setupChildViewController:discover title:@"广场" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    
    
    //我
    SoloMeViewController *me = [[SoloMeViewController alloc]init];
    [self setupChildViewController:me title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
}
/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的字控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    //1.设置控制器的属性
    childVc.title = title;
    if (iOS7) {
        imageName = [imageName stringByAppendingString:@"_os7"];
        selectedImageName = [selectedImageName stringByAppendingString:@"_os7"];
    }
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //2.包装一个导航控制器
    SoloNavigationController *nav = [[SoloNavigationController alloc]initWithRootViewController:childVc];
    [self addChildViewController:nav];
    //3.添加Tabbar内部的按钮
    //其实他们这些属性都传值给了tabbaritem，继承于NSObject，是一个模型，用来装数据的
    //这个方法是把Tabbaritem传给tabbar
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];
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
