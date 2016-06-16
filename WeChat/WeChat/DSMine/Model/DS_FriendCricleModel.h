//
//  DS_FriendCricleModel.h
//  WeChat
//
//  Created by wangyang on 16/5/31.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DS_FriendCricleTool.h"
@class DS_FriendCricleFeedModel;

@interface DS_FriendCricleModel : NSObject

@property (nonatomic,copy)NSString *headIcon;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *dec;
@property (nonatomic,assign)DSFriendCircleFeedType feedType;
@property (nonatomic,strong)DS_FriendCricleFeedModel *feedModel;
@property (nonatomic,copy)NSString *timeStamp;
@property (nonatomic,strong)NSArray *praises;
@property (nonatomic,strong)NSArray *comments;
//描述语打开状态
@property (nonatomic,assign)BOOL open;

@end

@interface DS_FriendCricleFeedModel : NSObject

@property (nonatomic,copy)NSString *signPicture;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *subTitle;
@property (nonatomic,strong)NSArray *pictures;
@end

@interface DS_FriendCricleCommentModel : NSObject
@property (nonatomic,strong)NSString *fromUserId;
@property (nonatomic,strong)NSString *fromUserName;
@property (nonatomic,strong)NSString *toUserId;
@property (nonatomic,strong)NSString *toUserName;
@property (nonatomic,strong)NSString *comment;
@end

@interface DS_FriendCriclePraiseModel : NSObject
@property (nonatomic,strong)NSString *fromUserId;
@property (nonatomic,strong)NSString *fromUserName;

@end