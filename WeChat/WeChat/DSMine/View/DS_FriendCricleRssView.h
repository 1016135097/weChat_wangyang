//
//  DS_FriendCricleRssView.h
//  WeChat
//
//  Created by wangyang on 16/6/2.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DS_FriendCricleTool.h"
#import "DS_FriendCricleModel.h"

@interface DS_FriendCricleRssView : UIView
- (instancetype)initWithFeedType:(DSFriendCircleFeedType)type;

@property (strong,nonatomic)DS_FriendCricleFeedModel *feedModel;
@end
