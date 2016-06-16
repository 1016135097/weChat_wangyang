//
//  DS_ChatRoomManager.m
//  WeChat
//
//  Created by wangyang on 16/5/17.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_ChatRoomManager.h"
#import "DS_WeChatListModel.h"

@implementation DS_ChatRoomManager

#pragma mark - public funs
+ (CGFloat)calculateCellHeightWithMsg:(DS_WeChatMsgModel *)msg
{
    CGSize size = CGSizeMake(0, 0);
    switch (msg.msgType) {
            //文字
        case DS_ChatMessageTypeText:
            size = [DS_ChatRoomManager msgTextHeight:msg.msg];
            break;
        case DS_ChatRoomTypePicture:
            size = [DS_ChatRoomManager msgPictureHeight:msg.msg];
            break;
        case DS_ChatRoomTypeVoice:
        case DS_ChatRoomTypeVoiceRead:
            size = [DS_ChatRoomManager msgTextHeight:msg.msg];
            break;
            
        default:
            break;
    }
    return [DS_ChatRoomManager caculateCellHight:msg withSize:size];
}

#pragma mark - pravite funs
+ (CGFloat)caculateCellHight:(DS_WeChatMsgModel *)msg withSize:(CGSize)size
{
    // top and bottom margin
    CGFloat timetampHeight = 45.f;
    if (msg.showTimetamp) {
        timetampHeight += 23;
    }
    if (msg.msgType == DS_ChatMessageTypeText) {
        timetampHeight += size.height>35.f?size.height:35.;
    }else if (msg.msgType == DS_ChatRoomTypePicture){
        timetampHeight += size.height;
    }
    msg.cacheMsgSize = CGSizeMake(ceil(size.width), ceil(timetampHeight));
    return timetampHeight;
}

//纯文字
+ (CGSize)msgTextHeight:(NSString *)msg
{
    CGRect rect = [msg boundingRectWithSize:KCHATBUBBLESIZE options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:KCHATBUBBLEFONT} context:nil];
    return rect.size;
}

//图片
+ (CGSize)msgPictureHeight:(NSString *)msg
{
    return CGSizeMake(200, 200);
}

//语音
+ (CGSize)msgVoiceHeight:(NSString *)msg
{
    return CGSizeMake(0, 0);
}

@end
