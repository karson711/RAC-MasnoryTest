//
//  BlockKitBasicUseVC.m
//  RACTest
//
//  Created by anfa on 2019/4/15.
//  Copyright © 2019 anfa. All rights reserved.
//

#import "BlockKitBasicUseVC.h"


@interface BlockKitBasicUseVC ()

@end

@implementation BlockKitBasicUseVC
/*
 参考网址：
 http://www.cocoachina.com/ios/20160505/16112.html
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [self associatedObject];
    
    [self uiKitAction];
    
}

/*
 添加 AssociatedObject
 当我们想要为一个已经存在的类添加属性时，就需要用到 AssociatedObject 为类添加属性，而 BlocksKit 提供了更简单的方法来实现，不需要新建一个分类。
 
 BlocksKit 通过另一种方式实现了『弱属性』：
 先获取了一个 _BKWeakAssociatedObject 对象 assoc，然后更新这个对象的属性 value。
 因为直接使用 AssociatedObject 不能为对象添加弱属性，所以在这里添加了一个对象，然后让这个对象持有一个弱属性：
 这就是 BlocksKit 实现弱属性的方法.
 */
-(void)associatedObject{
    NSObject *test = [[NSObject alloc] init];
    [test bk_associateValue:@"Anfa" withKey:@"name"];
    NSLog(@"name---%@",[test bk_associatedValueForKey:@"name"]);
}

/*
 UIKit相关的Block
 */
-(void)uiKitAction{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"测试按钮点击" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    UITextField *field = [[UITextField alloc] init];
    field.placeholder = @"请输入";
    field.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:field];
    
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    redView.userInteractionEnabled = YES;
    [self.view addSubview:redView];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).insets(UIEdgeInsetsMake(100, 20, 0, 0));
        make.right.equalTo(redView.mas_left).mas_offset(-20);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(50);
    }];
    
    [field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(20);
        make.top.equalTo(btn.mas_bottom).mas_offset(30);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(40);
    }];
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(100);
        make.right.equalTo(self.view).with.offset(10);
//        make.left.equalTo(btn.mas_right).mas_offset(20);
        make.height.mas_equalTo(50);
    }];
    
    //按钮点击
    [btn bk_addEventHandler:^(id sender) {
        NSLog(@"点击了测试按钮");
    } forControlEvents:UIControlEventTouchUpInside];
    
    //UItextField return监听
    [field setBk_shouldReturnBlock:^BOOL(UITextField *field) {
        // do something like
        [self.view endEditing:YES];
        return YES;
    }];

    //手势动作
    [redView addGestureRecognizer:[UITapGestureRecognizer bk_recognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        NSLog(@"手势点击redView");
    }]];
    
}

@end
