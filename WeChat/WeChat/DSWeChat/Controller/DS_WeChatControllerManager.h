//
//  DS_WeChatControllerManager.h
//  WeChat
//
//  Created by wangyang on 16/5/15.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DS_WeChatControllerManager,DS_WeChatListModel;

@interface DS_WeChatControllerManager : NSObject
/**
 * 数据源
 */
+ (NSArray *)dataSource;

/**
 * 检查单聊是否有建立聊天室
 */
+ (BOOL)checkIsChatRecordWithUserId:(NSString *)userId;

/**
 * 获取单聊聊天室数据
 */
+ (DS_WeChatListModel *)obtianSignChatMsgDataWithChatId:(NSString *)chatId;

/**
 * 搜索数据源
 */
+ (NSArray *)searchDataSource;

/**
 * item数据源
 */
+ (NSArray *)menuDataSource;
@end
