//
//  DS_KeyBoardEmjView.m
//  WeChat
//
//  Created by wangyang on 16/6/11.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_KeyBoardEmjView.h"

#define KFunsButtonSize CGSizeMake(40, 40)

@interface DS_KeyBoardEmjView ()
@property (nonatomic,strong)UIScrollView *funsScrollView;
@property (nonatomic,strong)UIButton *addButton;
@property (nonatomic,strong)UIButton *setButton;
@end

@implementation DS_KeyBoardEmjView

- (instancetype)init
{
    if (self = [super init]) {
        [self addSubview:self.funsScrollView];
        [self addSubview:self.addButton];
        [self addSubview:self.setButton];
        [self configDataSources];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    WEAKSELF;
    [self.addButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(KFunsButtonSize);
        make.left.and.bottom.mas_equalTo(weakSelf);
    }];
    
    [self.setButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(KFunsButtonSize);
        make.right.and.bottom.mas_equalTo(weakSelf);
    }];
    
    [self.funsScrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.setButton.mas_left);
        make.left.mas_equalTo(weakSelf.addButton.mas_right);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(weakSelf);
    }];
    [super updateConstraints];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(UISCREENWIDTH, 170);
}

- (void)configDataSources
{
//    [self.dataSourcesArray addObject:@1];
//    [self.dataSourcesArray addObject:@2];
//    [self.dataSourcesArray addObject:@3];
//    [self.dataSourcesArray addObject:@4];
//    self.pageControl.numberOfPages = self.dataSourcesArray.count;
    self.funsScrollView.contentSize = CGSizeMake(UISCREENWIDTH * 5.3, 40);
    self.funsScrollView.backgroundColor = [UIColor yellowColor];
    [self.collectionView reloadData];
}

- (UIScrollView *)funsScrollView
{
    if (!_funsScrollView) {
        _funsScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    }
    return _funsScrollView;
}

- (UIButton *)addButton
{
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
        _addButton.backgroundColor = UIColorFromRGB(0xffffff);
    }
    return _addButton;
}

- (UIButton *)setButton
{
    if (!_setButton) {
        _setButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
        _setButton.backgroundColor = UIColorFromRGB(0xffffff);
    }
    return _setButton;
}
@end
