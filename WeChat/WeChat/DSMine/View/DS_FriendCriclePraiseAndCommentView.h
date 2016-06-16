//
//  DS_FriendCriclePraiseAndCommentView.h
//  WeChat
//
//  Created by wangyang on 16/6/5.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DS_FriendCriclePraiseAndCommentView : UIView
- (void)show;
- (void)dismiss;

@property (nonatomic,copy)void (^cilckedAcion)(NSInteger index,BOOL praiseState);
@end
