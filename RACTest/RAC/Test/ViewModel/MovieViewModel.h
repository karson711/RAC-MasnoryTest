//
//  MovieViewModel.h
//  RACTest
//
//  Created by anfa on 2019/4/17.
//  Copyright © 2019 anfa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovieViewModel : NSObject

//command处理实际事务  网络请求
@property (nonatomic,strong)RACCommand *command;

@end

NS_ASSUME_NONNULL_END
