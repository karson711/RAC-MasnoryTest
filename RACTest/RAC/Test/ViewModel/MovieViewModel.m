//
//  MovieViewModel.m
//  RACTest
//
//  Created by anfa on 2019/4/17.
//  Copyright © 2019 anfa. All rights reserved.
//

#import "MovieViewModel.h"
#import "MovieModel.h"
#import "MovieListModel.h"

//豆瓣电影API
#define url @"https://api.douban.com/v2/movie/in_theaters?apikey=0b2bdeda43b5688921839c8ecb20399b&city=%E5%8C%97%E4%BA%AC&start=0&count=100&client=&udid="

@implementation MovieViewModel

-(instancetype)init{
    if (self = [super init]) {
        [self initViewModel];
    }
    return self;
}

-(void)initViewModel{
    @weakify(self);
    self.command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            @strongify(self);
            [self getDoubanList:^(NSArray<MovieModel *> *array) {
                [subscriber sendNext:array];
                [subscriber sendCompleted];
            }];
            return nil;
        }];
    }];
}

-(void)getDoubanList:(void(^)(NSArray <MovieModel *>*array))successBlock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MovieListModel *base = [MovieListModel yy_modelWithDictionary:responseObject];
        successBlock(base.subjects);
        
    } failure:nil];
}

@end
