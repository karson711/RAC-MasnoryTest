
//导航栏基类

#import "BaseNavigationController.h"

@interface BaseNavigationController ()


@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];    
    // Do any additional setup after loading the view.
    
}

#pragma mark - push后隐藏TabBar
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count >= 1) {
        
        viewController.hidesBottomBarWhenPushed = YES; // 隐藏底部的工具条
    }else {
        viewController.hidesBottomBarWhenPushed = NO;
    }
    //跳转
    [super pushViewController:viewController animated:animated];
}

@end
