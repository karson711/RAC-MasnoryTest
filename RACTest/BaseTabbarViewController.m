

#import "BaseTabbarViewController.h"
#import "BaseNavigationController.h"
#import "BlockKitBasicUseVC.h"

/*------Tabbar栏------*/
#define TabbarTextNormalColor  [UIColor colorWithRed:169/255.0f green:180/255.0f blue:184/255.0f alpha:1.0f]//文字默认颜色
#define TabbarTextSelectColor  [UIColor colorWithRed:0/255.0f green:120/255.0f blue:220/255.0f alpha:1.0f]//文字选中颜色

#define TabbarTextFontSize 20

#import "MenuListViewController.h"
#import "MasonryViewController.h"


@interface BaseTabbarViewController ()<UITabBarDelegate,UITabBarControllerDelegate>

@property(nonatomic,strong)UIButton * btn;

@end

@implementation BaseTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;

    [self addDcChildViewContorller];

}

#pragma mark - 添加子控制器
- (void)addDcChildViewContorller
{
    NSArray *childArray = @[
                            @{
                                @"ClassName"    : @"MenuListViewController",
                                @"TabTitle"     : @"RAC",
                                @"NavTitle"     : @"RAC",
                                @"normalImage"  : @"",
                                @"selectImage"  : @""
                                },
                            @{
                                @"ClassName"    : @"MasonryViewController",
                                @"TabTitle"     : @"Masonry",
                                @"NavTitle"     : @"Masonry",
                                @"normalImage"  : @"",
                                @"selectImage"  : @""
                              },
                            @{
                                @"ClassName"    : @"BlockKitBasicUseVC",
                                @"TabTitle"     : @"BlockKit",
                                @"NavTitle"     : @"BlockKit",
                                @"normalImage"  : @"",
                                @"selectImage"  : @""
                                }
                            ];
    [childArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *vc = [NSClassFromString(dict[@"ClassName"]) new];
        vc.navigationItem.title = dict[@"NavTitle"];
        
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        if ([dict[@"normalImage"] length] > 0) {
            item.image =  [[UIImage imageNamed:dict[@"normalImage"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            item.selectedImage = [[UIImage imageNamed:dict[@"selectImage"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            //        float origin = -9 + 6;
            //        item.imageInsets = UIEdgeInsetsMake(origin, 3, -origin,0);//（当只有图片的时候）需要自动调整
            //        item.titlePositionAdjustment = UIOffsetMake(-2 + 8, 2-8);
            //        item.imageInsets = UIEdgeInsetsMake(6, 0, -6,0);
            
            //        item.titlePositionAdjustment = UIOffsetMake(0, -2);
        }
        
        //title设置
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:TabbarTextNormalColor,NSFontAttributeName:[UIFont systemFontOfSize:TabbarTextFontSize]} forState:UIControlStateNormal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:TabbarTextSelectColor,NSFontAttributeName:[UIFont systemFontOfSize:TabbarTextFontSize]} forState:UIControlStateSelected];
        item.title = dict[@"TabTitle"];
        [self addChildViewController:nav];
    }];
    
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];

}
    
#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{

    return YES;
}

    
#pragma mark - <UITabBarControllerDelegate>
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //点击tabBarItem动画
}
    
#pragma mark - UITabBar delegate
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{

}

@end
