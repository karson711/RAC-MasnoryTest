//
//  RACMapViewController.m
//  RACTest
//
//  Created by anfa on 2019/4/9.
//  Copyright © 2019 anfa. All rights reserved.
//

#import "RACMapViewController.h"

@interface RACMapViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation RACMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"映射";
    
//    [self RAC_map];
    
    [self RAC_flattenMap];
    
}

//map作用：是将原信号的值自定义为新的值，不需要再返回RACStream类型，value为源信号的内容，将value处理好的内容直接返回即可。map方法将会创建一个一模一样的信号，只修改其value。
-(void)RAC_map{
    [[self.textField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return [NSString stringWithFormat:@"map---自定义了返回内容：%@",value];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"map--x---%@",x);
    }];
}

//flattenMap作用：把原信号的内容映射成一个新信号，并return返回给一个RACStream类型数据。实际上是根据前一个信号传递进来的参数重新建立了一个信号，这个参数，可能会在创建信号的时候用到，也有可能用不到。
-(void)RAC_flattenMap{
    [[self.textField.rac_textSignal flattenMap:^__kindof RACSignal * _Nullable(NSString * _Nullable value) {
        //自定义返回内容
        return [RACSignal return:[NSString stringWithFormat:@"flattenmap----自定义了返回内容：%@",value]];
    }]subscribeNext:^(id  _Nullable x) {
        NSLog(@"flattenmap---x---%@",x);
    }];
}

/*
 总结一下：如果使用map命令，则block代码块中return的是对象类型；而flattenMap命令block代码块中return的是一个新的信号
 */

@end
