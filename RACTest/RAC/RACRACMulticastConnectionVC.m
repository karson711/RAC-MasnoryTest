//
//  RACRACMulticastConnectionVC.m
//  RACTest
//
//  Created by anfa on 2019/4/9.
//  Copyright © 2019 anfa. All rights reserved.
//

#import "RACRACMulticastConnectionVC.h"

@interface RACRACMulticastConnectionVC ()

@property (nonatomic,strong)RACSignal *exampleSignal;

@end

@implementation RACRACMulticastConnectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"RACMulticastConnection";
    
//    [self RAC_commonMultConnection];
    
    [self RAC_RACmulticasConnection];
}

/*
 使用场景：
 在实际项目开发过程中，经常会在多处不同地方对同一信号进行订阅。比如：在网络请求时，收到返回数据要针对页面多处进行更新操作。
 从打印结果来看，很明显地RACSignal拥有两个订阅者时，发送信号与销毁信号都执行了两次。当拥有更多订阅者或者需要在发送信号前耗时处理时，这种写法大大降低了运行效率，浪费了不必要的资源。
 */
-(void)RAC_commonMultConnection{
    _exampleSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"message received"];
        NSLog(@"这里进行了一次耗时操作");
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"disposable");
        }];
    }];
    
    [_exampleSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"第一处，收到订阅信号：%@",x);
    }];
    
    [_exampleSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"第二处，收到订阅信号：%@",x);
    }];
}

/*
 发送信号时只执行了一次，两个订阅者都收到了各自的订阅信号。
 RACMulticastConnection是基于RACSubject来实现的，并将RACSubject封装成了RACMulticastConnection对象。
 总结一下RACMulticastConnection实现过程:
 1.创建connect，connect.sourceSignal-> RACSignal(原始信号) connect.signal -> RACSubject
 2.订阅connect.signal，会调用RACSubject的subscribeNext，创建订阅者，而且把订阅者保存起来，不会执行block。
 3.[connect connect]内部会订阅RACSignal(原始信号)，并且订阅者是RACSubject
 4.RACSubject的sendNext,会遍历RACSubject所有订阅者发送信号，并执行他们的nextBlock( )
 */
-(void)RAC_RACmulticasConnection{
    _exampleSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"message received"];
        NSLog(@"这里进行了一次耗时操作");
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"disposable");
        }];
    }];
    
    RACMulticastConnection *connection = [_exampleSignal publish];
    
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"第一处，收到订阅信号：%@",x);
    }];
    
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"第二处，收到订阅信号：%@",x);
    }];
    
    [connection connect];
}

@end
