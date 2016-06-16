//
//  DS_KeyBoardCell.h
//  WeChat
//
//  Created by wangyang on 16/6/13.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DS_KeyBoardCell : UICollectionViewCell

@property (nonatomic,strong)NSArray *dataArray;
@property (nonatomic,assign)NSInteger index;

@end

@interface DS_KeyBoardCellItemView : UIView

@property (nonatomic,strong)UIButton *iconIamge;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)NSIndexPath *indexPath;

@end

@interface DS_KeyBoardCellItemModel : NSObject

@property (nonatomic,copy)NSString *icon;
@property (nonatomic,copy)NSString *name;

@end