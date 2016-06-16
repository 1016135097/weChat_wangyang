//
//  DS_ChatMessage.h
//  WeChat
//
//  Created by wangyang on 16/5/17.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#ifndef DS_ChatMessage_h
#define DS_ChatMessage_h

typedef NS_ENUM(NSUInteger,DS_ChatType){
    DS_ChatTypeAlone = 1,  //单聊
    DS_ChatTypeRoom = 2,       //群聊
    DS_ChatTypesubscribe = 3,  //订阅号
    DS_ChatTypeNews = 4,       //腾讯新闻
    DS_ChatTypeSearch = 11     //搜一搜
};

typedef NS_ENUM(NSUInteger,DS_ChatRoomMsgVoice){
    DS_ChatRoomMsgVoiceNotice = 1, //新聊天消息声音通知
    DS_ChatRoomMsgVoiceClose       //新聊天消息声音不通知
};

//message state
typedef NS_ENUM(NSUInteger,DS_ChatMessageType){
    DS_ChatMessageTypeText = 1,        //文字 1
    DS_ChatRoomTypePicture = 2,       //图片  2
    DS_ChatRoomTypeVoice = 3,         //语音   3
    DS_ChatRoomTypeVoiceRead = 4,     //语音已听 4
    DS_ChatRoomTypeFace = 6,          //表情    6
    DS_ChatRoomTypeGif = 7,           //GIF   7
    DS_ChatRoomTypeVideo = 11,         //小视频 11
    DS_ChatRoomTypeBonus = 12,         //红包  12
    DS_ChatRoomTypeReceiveBonus = 13,  //领取红包 13
    DS_ChatRoomTypeAccounts = 14,      //转账 14
    DS_ChatRoomTypeLocation = 21,      //位置 21
    DS_ChatRoomTypePersonCard = 31,    //个人名片 31
    DS_ChatRoomTypeDiscount = 32,      //卡券  32
    DS_ChatRoomTypeOutWeb = 33,        //外部分享  33
    DS_ChatRoomTypeAddRoom = 34,       //入群  34
    DS_ChatRoomTypeRmoveRoom = 35,     //退出群  35
    DS_ChatRoomTypeMsgRecall = 41      //消息撤回 41
};

#import "DS_WeChatListModel.h"

#define DS_STRETCH_IMAGE(image, edgeInsets) (CURRENT_SYS_VERSION < 6.0 ? [image stretchableImageWithLeftCapWidth:edgeInsets.left topCapHeight:edgeInsets.top] : [image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch])

//bubble max width
#define KCHATBUBBLEWIDTH (UISCREENWIDTH - 165)
//bubble max size
#define KCHATBUBBLESIZE CGSizeMake(KCHATBUBBLEWIDTH, CGFLOAT_MAX)

#define KCHATBUBBLEFONT DSTEXTFONT(15.)

#endif /* DS_ChatMessage_h */

