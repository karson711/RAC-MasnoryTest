//
//  MovieCollectionViewCell.h
//  RACTest
//
//  Created by anfa on 2019/4/17.
//  Copyright © 2019 anfa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovieCollectionViewCell : UICollectionViewCell

+ (NSString *)cellReuseIdentifier;

- (void)renderWithModel:(id)model;

@end

NS_ASSUME_NONNULL_END
