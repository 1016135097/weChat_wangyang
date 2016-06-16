//
//  DS_KeyBoardFunsView.m
//  WeChat
//
//  Created by wangyang on 16/6/11.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_KeyBoardFunsView.h"

@implementation DS_KeyBoardFunsView

- (instancetype)init
{
    if (self = [super init]) {
        [self configDataSources];
    }
    return self;
}

- (void)configDataSources
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"keyBoardFunsList.plist" ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *page1Array = [DS_KeyBoardCellItemModel mj_objectArrayWithKeyValuesArray:dict[@"0"]];
    NSArray *page2Array = [DS_KeyBoardCellItemModel mj_objectArrayWithKeyValuesArray:dict[@"1"]];
    [self.dataSourcesArray addObject:page1Array];
    [self.dataSourcesArray addObject:page2Array];
    self.pageControl.numberOfPages = self.dataSourcesArray.count;
    [self.collectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(UISCREENWIDTH, 190);
}

- (void)updateViewConstraints
{
    WEAKSELF;
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(weakSelf).offset(-20);
    }];
    
    [self.pageControl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(weakSelf);
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(weakSelf.mas_bottom);
    }];
}
@end
