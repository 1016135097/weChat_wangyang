//
//  DS_FriendCricleCell.h
//  WeChat
//
//  Created by wangyang on 16/5/30.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DS_FriendCricleModel,DS_FriendCricleCell,DS_FriendCricleCommentModel;

@protocol DS_FriendCricleCellDelegate <NSObject>

@optional
/**
 * 描述语打开\关闭
 */
- (void)DS_FriendCricleCellClickedTitleOpen:(DS_FriendCricleCell *)cell withCricleModel:(DS_FriendCricleModel *)model;

/**
 * praise and comment swicth open/close
 */
- (void)DS_FriendCricleCellClickedPraiseAndCommentOpen:(DS_FriendCricleCell *)cell withModel:(DS_FriendCricleModel *)model withCilckedIndexPath:(NSIndexPath *)indexPath;

- (void)friednCricleCellClickedComment:(DS_FriendCricleCell *)cell withCellIndex:(NSInteger)cellIndex withCommentIndex:(NSInteger)commentIndex withComment:(DS_FriendCricleCommentModel *)comment;

@end

@interface DS_FriendCricleCell : UITableViewCell

@property (nonatomic,strong)DS_FriendCricleModel *model;
@property (nonatomic,weak)id<DS_FriendCricleCellDelegate> delegate;
@property (nonatomic,strong)NSIndexPath *indexPath;

@end
