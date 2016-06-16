//
//  DS_WeChatListModel.h
//  WeChat
//
//  Created by wangyang on 16/5/15.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DS_ChatMessage.h"

@interface DS_WeChatListModel : NSObject
//群图像
@property (nonatomic,copy)NSString *chatIcon;
//群名称
@property (nonatomic,copy)NSString *chatRoomName;
//0 代表 消息免打扰 1 代表 消息不打扰
@property (nonatomic,assign)DS_ChatRoomMsgVoice chatSoundNOticeState;
//群类型
@property (nonatomic,assign)DS_ChatType chatRoomType;
//群成员数
@property (nonatomic,copy)NSString *memberNums;
@property (nonatomic,strong)NSArray *msgArray;
//聊天室内是否显示聊天成员名称
@property (nonatomic,assign)BOOL showUserName;
//聊天室Id与聊天信息msgId绑定 (唯一标示符)
@property (nonatomic,copy)NSString *chatIds;

@end

@interface DS_WeChatMsgModel : NSObject
//头像
@property (nonatomic,copy)NSString *userIcon;
//消息来源 YES 来自自己 No 其他人
@property (nonatomic,assign)BOOL msgSources;
//用户名
@property (nonatomic,copy)NSString *userName;
//消息内容
@property (nonatomic,copy)NSString *msg;
//消息类型
@property (nonatomic,assign)DS_ChatMessageType msgType;
//时间戳
@property (nonatomic,copy)NSString *timestamp;
//是否需要显示时间戳
@property (nonatomic,assign)BOOL showTimetamp;
//聊天消息和用户Id绑定
@property (nonatomic,copy)NSString *chatMsgId;
//缓存消息尺寸size
@property (nonatomic,assign)CGSize cacheMsgSize;
@end
