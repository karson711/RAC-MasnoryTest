//
//  RACRACSubjectVC.m
//  RACTest
//
//  Created by anfa on 2019/4/9.
//  Copyright © 2019 anfa. All rights reserved.
//

#import "RACRACSubjectVC.h"

@interface RACRACSubjectVC ()

@end

@implementation RACRACSubjectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"RACSubject";
    
    /*
 在初始化创建RACSubject类的对象同时，创建了一个组合式销毁栈，而且在dealloc方法中执行了组合式销毁栈的信号销毁操作，并没有和父类RACSignal一样，创建并保存了一个销毁信号的成员变量。也就是说RACSubject类是在内部通过组合式销毁栈RACCompoundDisposable自动完成信号销毁。
 那么与之对应的RACSubject与父类RACSignal的订阅、发送消息也有不同。
 在RACSignal类的subscribe方法中，执行了_didSubscribe()代码块，也就是在创建信号时保存的成员变量didSubscribe销毁信号，而RACSignal类的subscribe方法则是通过RACCompoundDisposable来完成信号的销毁。
 RACSubject类中在发送信号时，RACSubject类会将所有的订阅者信号全部遍历并发送一次。除此以外，RACSubject类与父类RACSignal的发送信号流程相同：执行相应的nextBlock( )
 RACSubject类是将父类RACSignal的封装，将销毁信号的管理放在内部进行自动管理实现
     */
    //1. 创建信号
    RACSubject *subject = [RACSubject subject];
    //2. 订阅信号
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"x----%@",x);
    }];
    
    //3. 发送信号
    [subject sendNext:@"this is a RACSubject"];
}


@end
