//
//  RACRACCommandVC.m
//  RACTest
//
//  Created by anfa on 2019/4/9.
//  Copyright © 2019 anfa. All rights reserved.
//

#import "RACRACCommandVC.h"

@interface RACRACCommandVC ()

@end

@implementation RACRACCommandVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"RACCommand";
    
    [self RAC_RACCommand];
}

/*
 RACCommand:
 RACCommand为事件响应信号的管理者。其本身并不继承自RACSignal或者RACStream类，而是继承于NSObject，用于管理RACSignal类的创建于订阅的类。
 RACCommand类用于响应动作事件的执行，执行命令通常由用户交互页面的手势操作来触发。该类可以实现多种不同情况下的响应事件处理，除了可以快速绑定交互页面，还可以确保其在未使用时不会执行信号操作。
 因此在实际项目开发中，RACCommand使用的场景多用于交互手势操作响应事件，以及网络请求时不同请求状态的处理封装处理。当需要响应事件或网络请求时，直接执行对应RACCommand就可以发送信号，执行操作。当RACCommand内部收到请求时，把处理的结果返回给外部，这时要通过signalBlock返回的信号进行数据传递。
 */
-(void)RAC_RACCommand{
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@"this is a signal of command"];
            NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:1234 userInfo:@{@"key":@"error"}];
            [subscriber sendError:error];
            
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"disposable");
            }];
        }];
    }];
    
//    //command信号是否正在进行
//    [command.executing subscribeNext:^(NSNumber * _Nullable x) {
//        NSLog(@"executing----%@",x);
//    }];
    /*
 从打印结果中可以发现，executing属性在信号开始时，一定会返回0，代表RACCommand未执行，在实际应用中，并不需要监听command第一次未执行状态。此处可将属性executing的代码修改成自动跳过第一个信号
     */
    [[command.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        NSLog(@"executing----%@",x);
    }];
    
    
    //错误信号
    [command.errors subscribeNext:^(NSError * _Nullable x) {
        NSLog(@"errors == %@",x);
    }];
    
//    //command信号中的signal信号发送出来的订阅信号
//    [command.executionSignals subscribeNext:^(id  _Nullable x) {
//        NSLog(@"executionSignals == %@",x);
//    }];
    //监听最后一次发送的信号
    [[command.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        NSLog(@"executionSignals == %@",x);
    }];
    
    //必须执行命令，否则所有信号都不会订阅到
    [command execute:@"command执行"];
}

@end
