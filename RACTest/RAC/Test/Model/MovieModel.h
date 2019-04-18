//
//  MovieModel.h
//  RACTest
//
//  Created by anfa on 2019/4/17.
//  Copyright © 2019 anfa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MovieModelProtocol <NSObject>
@optional
//将模型渲染
- (void)renderWithModel:(id)model;
@end

@interface MovieModel : NSObject

//电影名
@property (nonatomic,copy) NSString *title;
//剧照
@property (nonatomic,strong) NSDictionary *images;
//电影分类
@property (nonatomic,strong) NSArray *genres;
//排名信息
@property (nonatomic,strong) NSDictionary *rating;
//原型
@property (nonatomic,strong) NSArray *casts;
//电影时长
@property (nonatomic,strong) NSArray *durations;
//多少人看过
@property (nonatomic,assign) NSInteger collect_count;
//大陆上映时间
@property (nonatomic,copy) NSString *mainland_pubdate;
//是否有资源
@property (nonatomic,copy) NSString *has_video;
//电影原名
@property (nonatomic,copy) NSString *original_title;
//固定值movie
@property (nonatomic,copy) NSString *subtype;
//导演信息
@property (nonatomic,strong) NSArray *directors;
//各地上映日期
@property (nonatomic,strong) NSArray *pubdates;
//上映年
@property (nonatomic,copy) NSString *year;
//网页链接
@property (nonatomic,copy) NSString *alt;
//电影 id，用于电影介绍
@property (nonatomic,copy) NSString *id;

@end




NS_ASSUME_NONNULL_END
