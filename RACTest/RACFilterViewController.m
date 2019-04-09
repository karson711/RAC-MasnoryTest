//
//  RACFilterViewController.m
//  RACTest
//
//  Created by anfa on 2019/4/9.
//  Copyright © 2019 anfa. All rights reserved.
//

#import "RACFilterViewController.h"

@interface RACFilterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation RACFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"信号过滤";
}

//信号过滤有以下几种方法：filter、ignore、ignoreValue、distinctUntilChanged

/*
 filter方法：
 在filter的block代码块中，通过return一个BOOL值来判断是否过滤掉信号.
 过滤出符合条件的值，变换出来新的信号并发送给订阅者;当block中的vlaue为NO时，将映射成一个空信号，订阅者不会受到空信号的订阅信号消息
 */
-(void)RAC_filter{
    @weakify(self)
    [[self.textField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        //过滤判断条件
        @strongify(self)
        if (self.textField.text.length >= 6) {
            self.textField.text = [self.textField.text substringToIndex:6];
        }
        return value.length <= 6;
    }] subscribeNext:^(NSString * _Nullable x) {
        //订阅逻辑区域
        NSLog(@"filter---x---%@",x);
    }];
}

/*
 ignoreValue与ignore方法：
 ignoreValue与ignore都是基于filter方法封装的。
 ignoreValue是直接将指定的信号全部过滤掉，筛选条件全部为NO，将所有信号变为空信号。
 ignore是将符合指定字符串条件的信号过滤掉。
 */
-(void)RAC_ignore{
    [[self.textField.rac_textSignal ignore:@"1"] subscribeNext:^(NSString * _Nullable x) {
        //将self.testTextField的textSignal中字符串为指定条件的信号过滤掉
    }];
    
    [[self.textField.rac_textSignal ignoreValues] subscribeNext:^(id  _Nullable x) {
        //将self.testTextField的所有textSignal全部过滤掉
        
    }];
}

//distinctUntilChanged方法：用于判断当前信号的值跟上一次的值相同，若相同时将不会收到订阅信号。
-(void)RAC_distinctUntilChanged{
    RACSubject *subject = [RACSubject subject];
    [[subject distinctUntilChanged] subscribeNext:^(id  _Nullable x) {
        
    }];
    [subject sendNext:@"1122"];
    [subject sendNext:@"3344"];
    [subject sendNext:@"3344"];
}

@end
