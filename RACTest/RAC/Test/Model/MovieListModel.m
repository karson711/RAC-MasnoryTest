//
//  MovieListModel.m
//  RACTest
//
//  Created by anfa on 2019/4/17.
//  Copyright © 2019 anfa. All rights reserved.
//

#import "MovieListModel.h"

@implementation MovieListModel

// 声明自定义类参数类型
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"subjects" : [MovieModel class]};
}

@end
