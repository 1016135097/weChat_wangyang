//
//  DS_AddressContactDetailManager.h
//  WeChat
//
//  Created by wangyang on 16/5/28.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DS_AddressBookModel,DS_WeChatListModel;

@interface DS_AddressContactDetailManager : NSObject
+ (NSArray *)cellDataSoources;

/**
 * 通过userId创建单聊聊天室（之前创建过返回之前创建的，如果没有创建新的）
 */
+ (DS_WeChatListModel *)creatSingChatRoomWithContactModel:(DS_AddressBookModel *)model;
@end
