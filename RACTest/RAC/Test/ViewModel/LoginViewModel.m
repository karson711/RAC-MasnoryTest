//
//  LoginViewModel.m
//  RACTest
//
//  Created by anfa on 2019/4/9.
//  Copyright © 2019 anfa. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        //将图片的变量与userName的属相变化进行绑定
        //同时根据username的变化自定义规则映射出iconURL的地址
        //distinctUntilChanged避免重复发送相同信号
        RAC(self,iconURL) = [[[RACObserve(self, userName) skip:1] map:^id _Nullable(id  _Nullable value) {
            //自定义映射返回的value值，可以在这里做数据库操作、网络请求等等
            return [NSString stringWithFormat:@"http:%@",value];
        }] distinctUntilChanged];
        
        //组合信号，观察userName与password的属性，以改变login的颜色属性
        self.loginEnableSignal = [RACSignal combineLatest:@[RACObserve(self, userName),RACObserve(self, password)] reduce:^(NSString *userName,NSString *password){
            return @(userName.length > 0 && password.length > 0);
        }];
        
        //登录请求逻辑
        [self setupLoginCommand];
        
        //状态文字信号
        self.statusSubject = [RACSubject subject];
        self.isLogining = NO;
    }
    return self;
}

-(void)setupLoginCommand{
    @weakify(self);
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        //请求登录网络封装
        return [self loginRequestData];
    }];
    
    [[self.loginCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        //根据是否正在执行，可以在此处进行UI展示操作
        NSLog(@"executing == %@",x);
        if (x.integerValue == 1) {
            [self statusLableAnimation];
        }
    }];
    
    [[self.loginCommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
       //注意：executionSignals必须要放在主线程中，block中的操作也要放入主线程执行
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.statusSubject sendNext:@"登录成功"];
            self.isLogining = NO;
        });
    }];
    
    [self.loginCommand.errors subscribeNext:^(NSError * _Nullable x) {
        NSLog(@"errors == %@",x);
        @strongify(self);
    //errors也建议放入主线程中，尽管不放入主线程也不会报错，与executionSignals不同。查看errors的代码会发现，errors被封装到RACMulticastConnection对象中，没有进行replay操作。映射的信号当catch到error时，会直接返回error；当没有catch到时，subject会回到主线程中重新规划内存。详情代码见RACCommand实现文件103-115行代码。
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.statusSubject sendNext:@"登录失败"];
            self.isLogining = NO;
        });
    }];
}

-(RACSignal *)loginRequestData{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        //请求网络相关代码写在这里
        //模拟网络操作，延迟3秒执行并判断业务逻辑
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [NSThread sleepForTimeInterval:3];
            if ([self.userName isEqualToString:@"123"] && [self.password isEqualToString:@"123"]) {
                [subscriber sendNext:@"登录成功"];
                [subscriber sendCompleted];
            }else{
                NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:1002 userInfo:@{@"errorKey":@"errorValue"}];
                [subscriber sendError:error];
            }
        });
        return nil;
    }];
}

-(void)statusLableAnimation{
    __block int num = 0;
    self.isLogining = YES;
    RACSignal *timerSignal = [[[RACSignal interval:0.8 onScheduler:[RACScheduler mainThreadScheduler]] map:^id _Nullable(NSDate * _Nullable value) {
        NSLog(@"登录时间%@",value);
        NSString *statusStr = @"登录中，请稍后";
        num += 1;
        int count = num % 3;
        switch (count) {
            case 0:
            {
                statusStr = @"登录中，请稍后.";
            }
                break;
            case 1:
            {
                statusStr = @"登录中，请稍后..";
            }
                break;
            case 2:
            {
                statusStr = @"登录中，请稍后...";
            }
                break;
        }
        return statusStr;
    }] takeUntilBlock:^BOOL(id  _Nullable x) {
        //当超过20秒时，不再执行该信号
        if (num >= 20 || !self.isLogining) {
            return YES;
        }
        return NO;
    }];
    
    [timerSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"subscribeNext == %@",x);
        //状态信号发送订阅信号
        [self.statusSubject sendNext:x];
    }];
}

@end
