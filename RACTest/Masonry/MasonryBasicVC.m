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

@end

@implementation MasonryBasicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Masonry基本使用";
    
    
}

//设置内边距
-(void)setUpPadding{
    /**
     设置yellow视图和self.view等大，并且有10的内边距。
     注意根据UIView的坐标系，下面right和bottom进行了取反。所以不能写成下面这样，否则right、bottom这两个方向会出现问题。
     make.edges.equalTo(self.view).with.offset(10);
     
     除了下面例子中的offset()方法，还有针对不同坐标系的centerOffset()、sizeOffset()、valueOffset()之类的方法。
     */
//    [self.yellowView ];
}


@end
