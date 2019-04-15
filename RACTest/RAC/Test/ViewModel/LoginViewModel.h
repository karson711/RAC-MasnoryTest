//
//  LoginViewModel.h
//  RACTest
//
//  Created by anfa on 2019/4/9.
//  Copyright © 2019 anfa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewModel : NSObject

@property (nonatomic,strong)NSString *iconURL;
@property (nonatomic,strong)NSString *userName;
@property (nonatomic,strong)NSString *password;
@property (nonatomic,strong)RACSignal *loginEnableSignal;
@property (nonatomic,strong)RACCommand *loginCommand;
@property (nonatomic,assign) BOOL isLogining;
@property (nonatomic,strong)RACSubject *statusSubject;

@end

NS_ASSUME_NONNULL_END
