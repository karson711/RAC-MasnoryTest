//
//  MasonryBasicVC.m
//  RACTest
//
//  Created by anfa on 2019/4/15.
//  Copyright © 2019 anfa. All rights reserved.
//

#import "MasonryBasicVC.h"

@interface MasonryBasicVC ()

@property (nonatomic,strong)UIView *yellowView;
@property (nonatomic,strong)UIView *greenView;
@property (nonatomic,strong)UIView *blueView;
@property (nonatomic,strong)UIView *redView;
@property (nonatomic,strong)UILabel *textLabel;

@end

@implementation MasonryBasicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Masonry基本使用";
    
    self.yellowView = [[UIView alloc] init];
    self.yellowView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.yellowView];
    
    self.blueView = [[UIView alloc] init];
    self.blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.blueView];
    
    self.greenView = [[UIView alloc] init];
    self.greenView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.greenView];
    
    self.redView = [[UIView alloc] init];
    self.redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.redView];
    
    self.textLabel = [[UILabel alloc] init];
    self.textLabel.numberOfLines = 0;
    self.textLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.textLabel];
    
    [self setUpPadding];
}

/*
 //基础API
 mas_makeConstraints()    添加约束
 mas_remakeConstraints()  移除之前的约束，重新添加新的约束
 mas_updateConstraints()  更新约束，写哪条更新哪条，其他约束不变
 
 equalTo()       参数是对象类型，一般是视图对象或者mas_width这样的坐标系对象
 mas_equalTo()   和上面功能相同，参数可以传递基础数据类型对象，可以理解为比上面的API更强大
 
 width()         用来表示宽度，例如代表view的宽度
 mas_width()     用来获取宽度的值。和上面的区别在于，一个代表某个坐标系对象，一个用来获取坐标系对象的值
 
 //更新约束和布局
 - (void)updateConstraintsIfNeeded  调用此方法，如果有标记为需要重新布局的约束，则立即进行重新布局，内部会调用updateConstraints方法
 - (void)updateConstraints          重写此方法，内部实现自定义布局过程
 - (BOOL)needsUpdateConstraints     当前是否需要重新布局，内部会判断当前有没有被标记的约束
 - (void)setNeedsUpdateConstraints  标记需要进行重新布局
 
 Masonry本质上就是对系统AutoLayout进行的封装，包括里面很多的API，都是对系统API进行了一次二次包装。
 typedef NS_OPTIONS(NSInteger, MASAttribute) {
 MASAttributeLeft = 1 << NSLayoutAttributeLeft,
 MASAttributeRight = 1 << NSLayoutAttributeRight,
 MASAttributeTop = 1 << NSLayoutAttributeTop,
 MASAttributeBottom = 1 << NSLayoutAttributeBottom,
 MASAttributeLeading = 1 << NSLayoutAttributeLeading,
 MASAttributeTrailing = 1 << NSLayoutAttributeTrailing,
 MASAttributeWidth = 1 << NSLayoutAttributeWidth,
 MASAttributeHeight = 1 << NSLayoutAttributeHeight,
 MASAttributeCenterX = 1 << NSLayoutAttributeCenterX,
 MASAttributeCenterY = 1 << NSLayoutAttributeCenterY,
 MASAttributeBaseline = 1 << NSLayoutAttributeBaseline,
 };
 
 */
-(void)setUpPadding{
    /**
     设置yellow视图和self.view等大，并且有10的内边距。
     注意根据UIView的坐标系，下面right和bottom进行了取反。所以不能写成下面这样，否则right、bottom这两个方向会出现问题。
     make.edges.equalTo(self.view).with.offset(10);
     
     除了下面例子中的offset()方法，还有针对不同坐标系的centerOffset()、sizeOffset()、valueOffset()之类的方法。
     */
    [self.yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(10);
        make.top.equalTo(self.view).with.offset(100);
        make.right.equalTo(self.view).with.offset(-10);
        make.bottom.equalTo(self.view).with.offset(-10);
    }];
    
    // 下面的方法和上面例子等价，区别在于使用insets()方法。
    [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        // 下、右不需要写负号，insets方法中已经为我们做了取反的操作了。
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(120, 20, 20, 20));
    }];
    
    // 设置greenView的center和size，这样就可以达到简单进行约束的目的
    [self.greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    // 为了更清楚的看出约束变化的效果，在显示两秒后更新约束。
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 指定更新size，其他约束不变。
        [self.greenView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(300, 300));
        }];
    });
    
//    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//        make.width.mas_equalTo(100);
//        make.height.mas_equalTo(100);
//    }];
    /*
     Masonry也帮我们定义好了一些默认的优先级常量，分别对应着不同的数值，优先级最大数值是1000。
     static const MASLayoutPriority MASLayoutPriorityRequired = UILayoutPriorityRequired;
     static const MASLayoutPriority MASLayoutPriorityDefaultHigh = UILayoutPriorityDefaultHigh;
     static const MASLayoutPriority MASLayoutPriorityDefaultMedium = 500;
     static const MASLayoutPriority MASLayoutPriorityDefaultLow = UILayoutPriorityDefaultLow;
     static const MASLayoutPriority MASLayoutPriorityFittingSizeLevel = UILayoutPriorityFittingSizeLevel;
     */
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(self.view).priorityLow();
        make.width.mas_equalTo(20).priorityHigh();
        make.height.equalTo(self.view).priority(200);
        make.height.mas_equalTo(100).priority(1000);
    }];
    
    //大于等于和小于等于某个值的约束
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        // 设置宽度小于等于200
        make.width.lessThanOrEqualTo(@(200));
        // 设置高度大于等于10
        make.height.greaterThanOrEqualTo(@(10));
    }];
    
    self.textLabel.text = @"这是测试的字符串。能看到1、2、3个步骤，第一步当然是上传照片了，要上传正面近照哦。上传后，网站会自动识别你的面部，如果觉得识别的不准，你还可以手动修改一下。左边可以看到16项修改参数，最上面是整体修改，你也可以根据自己的意愿单独修改某项，将鼠标放到选项上面，右边的预览图会显示相应的位置";
    
    
}



@end
