//
//  MovieListModel.h
//  RACTest
//
//  Created by anfa on 2019/4/17.
//  Copyright © 2019 anfa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovieModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieListModel : NSObject

//返回数量
@property (nonatomic,assign) NSInteger count;
//分页量
@property (nonatomic,assign) NSInteger start;
//数据库总数量
@property (nonatomic,assign) NSInteger total;
//返回数据相关信息
@property (nonatomic,copy)   NSString *title;
//具体电影信息 主要数据都在这里面
@property (nonatomic,strong) NSArray<MovieModel *> *subjects;

@end

NS_ASSUME_NONNULL_END
