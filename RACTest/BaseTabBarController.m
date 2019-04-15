//
//  BaseTabBarController.m
//  RACTest
//
//  Created by anfa on 2019/4/15.
//  Copyright © 2019 anfa. All rights reserved.
//

#import "BaseTabBarController.h"
#import "MenuListViewController.h"
#import "MasonryViewController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 创建子控制器
    MenuListViewController *homeVC = [[MenuListViewController alloc] init];
    [self setTabBarItem:homeVC.tabBarItem
                  title:@"RAC"
              titleSize:18.0
          titleFontName:@"HeiTi SC"
          selectedImage:nil
     selectedTitleColor:[UIColor redColor]
            normalImage:nil
       normalTitleColor:[UIColor blackColor]];
    
    MasonryViewController *blogVC = [[MasonryViewController alloc] init];
    [self setTabBarItem:blogVC.tabBarItem
                  title:@"Masonry"
              titleSize:18.0
          titleFontName:@"HeiTi SC"
          selectedImage:nil
     selectedTitleColor:[UIColor redColor]
            normalImage:nil
       normalTitleColor:[UIColor blackColor]];
    
    UINavigationController *homeNV = [[UINavigationController alloc] initWithRootViewController:homeVC];
    UINavigationController *blogNV = [[UINavigationController alloc] initWithRootViewController:blogVC];
    // 把子控制器添加到UITabBarController
    self.viewControllers = @[homeNV, blogNV];
}

- (void)setTabBarItem:(UITabBarItem *)tabbarItem
                title:(NSString *)title
            titleSize:(CGFloat)size
        titleFontName:(NSString *)fontName
        selectedImage:(NSString *)selectedImage
   selectedTitleColor:(UIColor *)selectColor
          normalImage:(NSString *)unselectedImage
     normalTitleColor:(UIColor *)unselectColor
{
    
    //设置图片
    tabbarItem = [tabbarItem initWithTitle:title image:[[UIImage imageNamed:unselectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    // S未选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:unselectColor,NSFontAttributeName:[UIFont fontWithName:fontName size:size]} forState:UIControlStateNormal];
    
    // 选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:selectColor,NSFontAttributeName:[UIFont fontWithName:fontName size:size]} forState:UIControlStateSelected];
}

@end
