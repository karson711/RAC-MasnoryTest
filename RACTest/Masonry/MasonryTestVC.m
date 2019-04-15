//
//  MasonryTestVC.m
//  RACTest
//
//  Created by anfa on 2019/4/15.
//  Copyright © 2019 anfa. All rights reserved.
//

#import "MasonryTestVC.h"
#define padding 10

@interface MasonryTestVC ()

@property (nonatomic,strong)UIView *yellowView;
@property (nonatomic,strong)UIView *blueView;
@property (nonatomic,strong)UIView *redView;

@end

@implementation MasonryTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.yellowView = [[UIView alloc] init];
    self.yellowView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.yellowView];
    
    self.blueView = [[UIView alloc] init];
    self.blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.blueView];
    
    self.redView = [[UIView alloc] init];
    self.redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.redView];
    
//    [self setUpPadding];
    [self testTwo];
}

-(void)setUpPadding{
    /**
     下面的例子是通过给equalTo()方法传入一个数组，设置数组中子视图及当前make对应的视图之间等高。
     
     需要注意的是，下面block中设置边距的时候，应该用insets来设置，而不是用offset。
     因为用offset设置right和bottom的边距时，这两个值应该是负数，所以如果通过offset来统一设置值会有问题。
     */
    
    /**********  等高   ***********/
//    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(self.view).insets(UIEdgeInsetsMake(padding, padding, 0, padding));
//        make.bottom.equalTo(self.blueView.mas_top).offset(-padding);
//    }];
//
//    [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, padding, 0, padding));
//        make.bottom.equalTo(self.yellowView.mas_top).offset(-padding);
//    }];
//
//    /**
//     下面设置make.height的数组是关键，通过这个数组可以设置这三个视图高度相等。其他例如宽度之类的，也是类似的方式。
//     */
//    [self.yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(self.view).insets(UIEdgeInsetsMake(0, padding, padding, padding));
//        make.height.equalTo(@[self.redView,self.blueView]);
//    }];
    
    /**********  等宽   ***********/
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.view).insets(UIEdgeInsetsMake(padding, padding, padding, 0));
        make.right.equalTo(self.blueView.mas_left).offset(-padding);
    }];
    [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.view).insets(UIEdgeInsetsMake(padding, 0, padding, 0));
        make.right.equalTo(self.yellowView.mas_left).offset(-padding);
    }];
    [self.yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self.view).insets(UIEdgeInsetsMake(padding, 0, padding, padding));
        make.width.equalTo(@[self.redView, self.blueView]);
    }];
}

//子视图垂直居中练习
-(void)testTwo{
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.left.equalTo(self.view).mas_offset(padding);
        make.right.equalTo(self.blueView.mas_left).mas_offset(-padding);
        make.height.mas_equalTo(150);
    }];
    
    [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.right.equalTo(self.view).mas_offset(-padding);
        make.width.equalTo(self.redView);
        make.height.mas_equalTo(150);
    }];
}

@end
