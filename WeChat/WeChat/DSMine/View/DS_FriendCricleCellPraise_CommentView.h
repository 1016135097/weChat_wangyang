//
//  DS_FriendCricleCellPraise_CommentView.h
//  WeChat
//
//  Created by wangyang on 16/6/5.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DS_FriendCricleCommentModel;

@interface DS_FriendCricleCellPraise_CommentView : UIView
@property (nonatomic,strong)NSArray *praiseArray;
@property (nonatomic,strong)NSArray *commentArray;
@property (nonatomic,assign,readonly)CGFloat Praise_CommentViewHeight;
@property (nonatomic,copy)void (^commentClicked)(NSInteger index,DS_FriendCricleCommentModel *comment);
@end

@interface DS_FriendCricleCellPraise_CommentCell : UITableViewCell
@property (nonatomic,strong)UILabel *titleLabel;
@end