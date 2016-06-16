//
//  DS_SingleChatController.h
//  WeChat
//
//  Created by wangyang on 16/5/19.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_BaseChatRoomController.h"

typedef NS_ENUM(NSInteger,DS_ChatRoomJoinType) {
    DS_ChatRoomJoinTypeNomal = 0,   //聊天室普通方式进入
    DS_ChatRoomJoinTypeVideoChat,  //聊天室视频聊天进入
    DS_ChatRoomJoinTypeSoundChat   //聊天室语音视频聊天进入
};

@interface DS_SingleChatController : DS_BaseChatRoomController
@property (nonatomic,assign)DS_ChatRoomJoinType joinType;
@end
