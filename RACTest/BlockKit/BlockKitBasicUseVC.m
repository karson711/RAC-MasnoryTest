//
//  BlockKitBasicUseVC.m
//  RACTest
//
//  Created by anfa on 2019/4/15.
//  Copyright © 2019 anfa. All rights reserved.
//

#import "BlockKitBasicUseVC.h"
#import <NSMutableDictionary+BlocksKit.h>

@interface BlockKitBasicUseVC ()

@end

@implementation BlockKitBasicUseVC
/*
 参考网址：
 实现原理
 http://www.cocoachina.com/ios/20160505/16112.html
 github地址
 https://github.com/BlocksKit/BlocksKit
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [self associatedObject];
    
    [self uiKitAction];
    
//    [self blockAction];
    
    [self mutableContainerAction];
    
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

/*
 //串行遍历容器中所有元素
 - (void)bk_each:(void (^)(id obj))block;
 //并发遍历容器中所有元素（不要求容器中元素顺次遍历的时候可以使用此种遍历方式来提高遍历速度）
 - (void)bk_apply:(void (^)(id obj))block;
 //返回第一个符合block条件（让block返回YES）的对象
 - (id)bk_match:(BOOL (^)(id obj))block;
 //返回所有符合block条件（让block返回YES）的对象
 - (NSArray *)bk_select:(BOOL (^)(id obj))block;
 //返回所有！！！不符合block条件（让block返回YES）的对象
 - (NSArray *)bk_reject:(BOOL (^)(id obj))block;
 //返回对象的block映射数组
 - (NSArray *)bk_map:(id (^)(id obj))block;
 
 //查看容器是否有符合block条件的对象
 //判断是否容器中至少有一个元素符合block条件
 - (BOOL)bk_any:(BOOL (^)(id obj))block;
 //判断是否容器中所有元素都！！！不符合block条件
 - (BOOL)bk_none:(BOOL (^)(id obj))block;
 //判断是否容器中所有元素都符合block条件
 - (BOOL)bk_all:(BOOL (^)(id obj))block;
 */
-(void)blockAction{
    NSArray *arr = @[@"a",@"ds",@"dd",@"s",@"c"];
    NSString *str = [arr bk_match:^BOOL(id obj) {
        return ((NSString *)obj).length == 1;
    }];
    
    NSArray *arr_01 = [arr bk_select:^BOOL(id obj) {
        return ((NSString *)obj).length == 1;
    }];
    
    NSArray *arr_02 = [arr bk_reject:^BOOL(id obj) {
        return ((NSString *)obj).length == 1;
    }];
    
    NSLog(@"str = %@",str);
    NSLog(@"arr_01 = %@",arr_01);
    NSLog(@"arr_02 = %@",arr_02);
}

/*
//删除容器中!!!不符合block条件的对象，即只保留符合block条件的对象
- (void)bk_performSelect:(BOOL (^)(id obj))block;

//删除容器中符合block条件的对象
- (void)bk_performReject:(BOOL (^)(id obj))block;

//容器中的对象变换为自己的block映射对象
- (void)bk_performMap:(id (^)(id obj))block;
 */
-(void)mutableContainerAction{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:@[@"302",@"200",@"290",@"100",@"430"]];
    BOOL(^valiationBlock)(id) = ^(NSString *obj){
        BOOL match = [obj integerValue] > 300?YES:NO;
        return match;
    };
    [arr bk_performSelect:valiationBlock];
    NSLog(@"arr===%@",arr);
    
    id(^transformBlock)(id) = ^(NSString *obj){
        return [obj substringToIndex:1];
    };
    [arr bk_performMap:transformBlock];
    NSLog(@"arr===%@",arr);
    
    NSMutableDictionary *subject = [NSMutableDictionary dictionary];
    [subject setObject:@1 forKey:@"1"];
    [subject setObject:@2 forKey:@"2"];
    [subject setObject:@3 forKey:@"3"];
    
    void(^keyValueBlock)(id,id) = ^(id key,id value){
        NSLog(@"key:Value=%@:%@",key,value);
    };
    [subject bk_each:keyValueBlock];
}



@end
