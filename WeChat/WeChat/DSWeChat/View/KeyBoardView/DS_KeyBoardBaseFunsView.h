//
//  DS_KeyBoardBaseFunsView.h
//  WeChat
//
//  Created by wangyang on 16/6/11.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DS_KeyBoardCell.h"

@interface DS_KeyBoardBaseFunsView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *dataSourcesArray;
@property (nonatomic,strong)UIPageControl *pageControl;

- (void)updateViewConstraints;
@end
