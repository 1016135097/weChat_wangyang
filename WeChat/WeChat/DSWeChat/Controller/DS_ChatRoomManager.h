//
//  DS_ChatRoomManager.h
//  WeChat
//
//  Created by wangyang on 16/5/17.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DS_WeChatListModel,DS_WeChatMsgModel;
@interface DS_ChatRoomManager : NSObject
+ (CGFloat)calculateCellHeightWithMsg:(DS_WeChatMsgModel *)msg;
@end
