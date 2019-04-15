//
//  TestDemoViewController.m
//  RACTest
//
//  Created by anfa on 2019/4/9.
//  Copyright © 2019 anfa. All rights reserved.
//

#import "TestDemoViewController.h"
#import "LoginViewModel.h"

@interface TestDemoViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UITextField *textUserName;
@property (weak, nonatomic) IBOutlet UITextField *textPassword;
@property (weak, nonatomic) IBOutlet UILabel *statusLable;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (nonatomic,strong)LoginViewModel *loginViewModel;
@end

@implementation TestDemoViewController

-(LoginViewModel *)loginViewModel{
    if (!_loginViewModel) {
        _loginViewModel = [[LoginViewModel alloc] init];
    }
    return _loginViewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //绑定试图与viewModel
    [self bindViewModel];
}

-(void)bindViewModel{
    @weakify(self)
    RAC(self.loginViewModel,userName) = self.textUserName.rac_textSignal;
    RAC(self.loginViewModel,password) = self.textPassword.rac_textSignal;
    //将登录按钮能否点击与viewModel中的loginEnableSignal信号进行绑定
    RAC(self.loginButton,enabled) = self.loginViewModel.loginEnableSignal;
    RAC(self.statusLable,text) = self.loginViewModel.statusSubject;
    
    //头像信号订阅
    [RACObserve(self.loginViewModel, iconURL) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        //根据返回的订阅信号自定义头像image
        self.iconImage.image = [UIImage imageNamed:x];
    }];
    
    //登录按钮能否点击颜色变化
    [self.loginViewModel.loginEnableSignal subscribeNext:^(NSNumber *x) {
        @strongify(self);
        UIColor *color = x.integerValue==0?[UIColor lightGrayColor]:[UIColor purpleColor];
        [self.loginButton setBackgroundColor:color];
    }];
    
    //登录请求
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.loginViewModel.loginCommand execute:@"登录事件触发"];
    }];
}

@end
