//
//  MovieListViewController.m
//  RACTest
//
//  Created by anfa on 2019/4/17.
//  Copyright © 2019 anfa. All rights reserved.
//

#import "MovieListViewController.h"

#import <BlocksKit/A2DynamicDelegate.h>

#import "MovieModel.h"
#import "MovieViewModel.h"
#import "MovieListModel.h"
#import "MovieCollectionViewCell.h"

#define scaledCellValue(value) ( floorf(CGRectGetWidth(collectionView.frame) / 375 * (value)) )

@interface MovieListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong)MovieViewModel *viewModel;
//列表
@property (nonatomic,weak) UICollectionView *collectionView;
//列表数据
@property (nonatomic,strong) NSMutableArray *listArray;

@end

@implementation MovieListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"影片列表";
    
    [self bindViewModel];
    
    [self initStyle];
}

/**
 viewModel绑定
 */
-(void)bindViewModel{
    @weakify(self);
    [[self.viewModel.command.executionSignals switchToLatest] subscribeNext:^(NSArray  <MovieModel *>*array) {
        @strongify(self);
        [SVProgressHUD showSuccessWithStatus:@"加载成功"];
        self.listArray = [NSMutableArray arrayWithArray:array];
        [self.collectionView reloadData];
        [SVProgressHUD dismissWithDelay:1.5];
    }];
    
    [self.viewModel.command execute:nil];
    [SVProgressHUD showWithStatus:@"加载中...."];
}

-(void)initStyle{
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
    layOut.scrollDirection = UICollectionViewScrollDirectionVertical;
    layOut.minimumInteritemSpacing = 2;
    layOut.minimumLineSpacing = 5;
    layOut.sectionInset = UIEdgeInsetsMake(0, 15, 0,15);//设置section的编距
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layOut];
    collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.alwaysBounceVertical = YES;
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    self.collectionView = collectionView;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[MovieCollectionViewCell class] forCellWithReuseIdentifier:[MovieCollectionViewCell cellReuseIdentifier]];
}

-(MovieViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[MovieViewModel alloc] init];
    }
    return _viewModel;
}

-(NSMutableArray *)listArray{
    if (!_listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.listArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MovieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[MovieCollectionViewCell cellReuseIdentifier] forIndexPath:indexPath];
    [cell renderWithModel:self.listArray[indexPath.row]];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  CGSizeMake(scaledCellValue(100), scaledCellValue(120));
}

#pragma mark - UICollectionViewDelegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// 点击高亮
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击Item");
    
}


@end
