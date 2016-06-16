//
//  DS_KeyBoardBaseFunsView.m
//  WeChat
//
//  Created by wangyang on 16/6/11.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_KeyBoardBaseFunsView.h"

static NSString *identifier = @"DS_KeyBoardBaseFunsViewCell";

@interface DS_KeyBoardBaseFunsView ()

@end

@implementation DS_KeyBoardBaseFunsView

- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = UIColorFromRGB(0xf2f2f4);
        [self addSubview:self.collectionView];
        [self addSubview:self.pageControl];
        [self updateViewConstraints];
    }
    return self;
}

- (void)updateViewConstraints
{
    WEAKSELF;
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(weakSelf).offset(-30);
    }];
    
    [self.pageControl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(weakSelf);
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(weakSelf.collectionView.mas_bottom);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSourcesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DS_KeyBoardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.index = indexPath.row;
    cell.dataArray = self.dataSourcesArray[indexPath.item];
    return cell;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger x = scrollView.contentOffset.x;
    self.pageControl.currentPage = (x+self.frame.size.width*0.5)/self.frame.size.width;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.itemSize = CGSizeMake(UISCREENWIDTH, 190);
        layout.minimumLineSpacing = 0.f;
        layout.minimumInteritemSpacing = 0.f;
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView registerClass:[DS_KeyBoardCell class] forCellWithReuseIdentifier:identifier];
        _collectionView.backgroundColor = UIColorFromRGB(0xf2f2f4);
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
    }
    return _collectionView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    }
    return _pageControl;
}

- (NSMutableArray *)dataSourcesArray
{
    if (!_dataSourcesArray) {
        _dataSourcesArray = [NSMutableArray array];
    }
    return _dataSourcesArray;
}

@end
