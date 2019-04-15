//
//  RACHomeViewController.m
//  RACTest
//
//  Created by anfa on 2019/4/4.
//  Copyright © 2019 anfa. All rights reserved.
//

#import "RACHomeViewController.h"
#import <ReactiveObjC.h>

@interface RACHomeViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *touchBtn;
@property (weak, nonatomic) IBOutlet UILabel *gestureLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation RACHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"基础控件使用";
    
    [self RAC_Base];
    
    [self RACButton_targetAction];
    
    [self RAC_TextFieldDelegate];
}

-(void)RAC_Base{
    //RAC基本使用流程
    
    //1. 创建signal信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        //subscriber并不是一个对象
        //3. 发送信号
        [subscriber sendNext:@"sendMessage"];
        
        //发送error信号
        NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:1001 userInfo:@{@"errorMsg":@"This is a error message"}];
        [subscriber sendError:error];
        
        //4. 销毁信号
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"signal已销毁");
        }];
    }];
    
    //2.1 订阅信号
    [signal subscribeNext:^(id  _Nullable x) {
        
    }];
    
    //2.2 订阅error信号
    [signal subscribeError:^(NSError * _Nullable error) {
        
    }];
}

-(void)RACButton_targetAction{
    [[self.touchBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"点击按钮");
        NSLog(@"x===%@",x);
    }];
    
    self.gestureLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [self.gestureLabel addGestureRecognizer:tap];
    [tap.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        NSLog(@"手势点击");
        NSLog(@"手势x===%@",x);
    }];
}

-(void)RAC_KVO{
    [RACObserve(self.gestureLabel, text) subscribeNext:^(id  _Nullable x) {
        NSLog(@"kvo---%@",x);
    }];
}

-(void)RAC_TextFieldDelegate{
    [[self rac_signalForSelector:@selector(textFieldDidEndEditing:) fromProtocol:@protocol(UITextFieldDelegate)] subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"textfieldDelegate=====%@",x);
    }];
    self.textField.delegate = self;
}

-(void)RAC_Notification{
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardDidHideNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"notification---%@",x);
    }];
}

-(void)RAC_timer{
    //在主程序中
    [[RACSignal interval:2 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
        NSLog(@"timer--主程序---%@",x);
    }];
    
    //创建一个新线程
    [[RACSignal interval:1 onScheduler:[RACScheduler schedulerWithPriority:RACSchedulerPriorityHigh name:@"com.ReactiveCocoa.RACScheduler.mainThreadScheduler"]] subscribeNext:^(NSDate * _Nullable x) {
        NSLog(@"timer--新线程---%@",x);
        NSLog(@"currentThread---%@",[NSThread currentThread]);
    }];
}

-(void)RAC_sequence{
    //遍历数组
    NSArray *racArray = @[@"rac1",@"rac2",@"rac3"];
    [racArray.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"sequence---%@",x);
    }];
    
    //遍历字典
    NSDictionary *dict = @{@"name":@"tree",@"lever":@"high",@"age":@"30"};
    [dict.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        RACTwoTuple *tuple = (RACTwoTuple *)x;
        NSLog(@"key===%@,value===%@",tuple[0],tuple[1]);
    }];
}

@end
