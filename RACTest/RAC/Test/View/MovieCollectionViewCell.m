//
//  MovieCollectionViewCell.m
//  RACTest
//
//  Created by anfa on 2019/4/17.
//  Copyright © 2019 anfa. All rights reserved.
//

#import "MovieCollectionViewCell.h"
#import "MovieModel.h"

@interface MovieCollectionViewCell ()

@property (nonatomic,weak) UIImageView* imageView;
@property (nonatomic,weak) UILabel* labelTitle;
@property (nonatomic,weak) UILabel* labelPoint;

@end

@implementation MovieCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initStyle];
    }
    return self;
}

-(void)initStyle{
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(imageView.superview);
        make.height.equalTo(imageView.mas_width);
    }];
    self.imageView = imageView;
    
    UILabel *labelTitle = [[UILabel alloc] init];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    labelTitle.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:labelTitle];
    [labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(imageView);
        make.top.equalTo(self.imageView.mas_bottom);
        make.bottom.equalTo(self.contentView);
    }];
    self.labelTitle = labelTitle;
    
    UILabel *labelPoint = [[UILabel alloc] init];
    [self.imageView addSubview:labelPoint];
    [labelPoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(labelPoint.superview);
        make.size.mas_equalTo(CGSizeMake(30, 20));
    }];
    self.labelPoint = labelPoint;
    
}

-(void)renderWithModel:(id)model{
    if ([model isKindOfClass:[MovieModel class]]) {
        MovieModel *movie = model;
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:movie.images[@"large"]?:nil]];
        self.labelTitle.text = movie.title?:@"";
        self.labelPoint.text = [NSString stringWithFormat:@"%@",movie.rating[@"average"]?:@(0)];
    }
}


//cell标识
+(NSString *)cellReuseIdentifier{
    return NSStringFromClass(self.class);
}

@end
