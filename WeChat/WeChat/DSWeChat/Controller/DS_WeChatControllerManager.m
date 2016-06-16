//
//  DS_WeChatControllerManager.m
//  WeChat
//
//  Created by wangyang on 16/5/15.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_WeChatControllerManager.h"
#import "DSWeChatController.h"
#import "DS_WeChatListModel.h"
#import "DS_WechatMenuModel.h"

@implementation DS_WeChatControllerManager
+ (NSArray *)dataSource
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    DS_WeChatListModel *model = [[DS_WeChatListModel alloc] init];
    model.chatIcon = @"icon1.jpg";
    model.chatRoomName = @"🐷toon🐶";
    model.chatSoundNOticeState = 1;
    model.chatRoomType = 2;
    model.memberNums = @"10";
    model.showUserName = NO;
    
    DS_WeChatMsgModel *msg1 = [[DS_WeChatMsgModel alloc] init];
    msg1.userIcon = @"user3.png";
    msg1.msgSources = NO;
    msg1.userName = @"员工A";
    msg1.msg = @"你今天干嘛啦？";
    msg1.msgType = 1;
    msg1.timestamp = @"16:43";
    msg1.showTimetamp = YES;
    msg1.chatMsgId = @"123456";
    
    DS_WeChatMsgModel *msg2 = [[DS_WeChatMsgModel alloc] init];
    msg2.userIcon = @"user4.png";
    msg2.msgSources = YES;
    msg2.userName = @"员工B";
    msg2.msg = @"iOS开发者，致力于书写最简洁、高效的代码，QQ:1508425305,邮箱：wangyang307395644@126.com";
    msg2.msgType = 1;
    msg2.timestamp = @"16:43";
    msg2.showTimetamp = NO;
    msg2.chatMsgId = @"123457";
    
    DS_WeChatMsgModel *msg3 = [[DS_WeChatMsgModel alloc] init];
    msg3.userIcon = @"user4.png";
    msg3.msgSources = YES;
    msg3.userName = @"员工C";
    msg3.msg = @"我和你谈钱，你跟我谈理想，我和你谈理想，你和我谈现实，我和你谈现实，你和我谈环境！真他妈的操蛋，我和你谈钱，你跟我谈理想，我和你谈理想，你和我谈现实，我和你谈现实，你和我谈环境！真他妈的操蛋，我和你谈钱，你跟我谈理想，我和你谈理想，你和我谈现实，我和你谈现实，你和我谈环境！真他妈的操蛋，我和你谈钱，你跟我谈理想，我和你谈理想，你和我谈现实，我和你谈现实，你和我谈环境！真他妈的操蛋，我和你谈钱，你跟我谈理想，我和你谈理想，你和我谈现实，我和你谈现实，你和我谈环境！真他妈的操蛋，我和你谈钱，你跟我谈理想，我和你谈理想，你和我谈现实，我和你谈现实，你和我谈环境！真他妈的操蛋!";
    msg3.msgType = 1;
    msg3.timestamp = @"16:43";
    msg3.showTimetamp = NO;
    msg3.chatMsgId = @"123458";
    
    DS_WeChatMsgModel *msg4 = [[DS_WeChatMsgModel alloc] init];
    msg4.userIcon = @"user3.png";
    msg4.msgSources = NO;
    msg4.userName = @"员工D";
    msg4.msg = @"hahhaha";
    msg4.msgType = 1;
    msg4.timestamp = @"16:43";
    msg4.showTimetamp = NO;
    msg4.chatMsgId = @"123459";

    DS_WeChatMsgModel *msg5 = [[DS_WeChatMsgModel alloc] init];
    msg5.userIcon = @"user3.png";
    msg5.msgSources = NO;
    msg5.userName = @"员工E";
    msg5.msg = @"我和你谈钱，你跟我谈理想，我和你谈理想，你和我显示，真他妈操蛋";
    msg5.msgType = 1;
    msg5.timestamp = @"16:43";
    msg5.showTimetamp = YES;
    msg5.chatMsgId = @"123460";
    
    model.chatIds = @"123460";
    model.msgArray = @[msg1,msg2,msg3,msg4,msg5,msg1,msg2,msg3,msg4,msg5,msg1,msg2,msg3,msg4,msg5,msg1,msg2,msg3,msg4,msg5];
    
    DS_WeChatListModel *model1 = [[DS_WeChatListModel alloc] init];
    model1.chatIcon = @"icon2.jpg";
    model1.chatRoomName = @"Dscore";
    model1.chatSoundNOticeState = 1;
    model1.chatRoomType = 1;
    model1.showUserName = YES;
    
    DS_WeChatMsgModel *msg11 = [[DS_WeChatMsgModel alloc] init];
    msg11.userIcon = @"icon2.jpg";
    msg11.msgSources = NO;
    msg11.userName = @"王阳";
    msg11.msg = @"个人开发者王阳";
    msg11.msgType = 1;
    msg11.timestamp = @"18:43";
    msg11.showTimetamp = YES;
    msg11.chatMsgId = @"123461";
    
    DS_WeChatMsgModel *msg12 = [[DS_WeChatMsgModel alloc] init];
    msg12.userIcon = @"icon2.jpg";
    msg12.msgSources = NO;
    msg12.userName = @"王阳";
    msg12.msg = @"icon2.jpg";
    msg12.msgType = 2;
    msg12.timestamp = @"18:53";
    msg12.showTimetamp = YES;
    msg12.chatMsgId = @"123461";
    
    DS_WeChatMsgModel *msg13 = [[DS_WeChatMsgModel alloc] init];
    msg13.userIcon = @"icon2.jpg";
    msg13.msgSources = NO;
    msg13.userName = @"王阳";
    msg13.msg = @"测试时候是是是";
    msg13.msgType = 1;
    msg13.timestamp = @"18:43";
    msg13.showTimetamp = NO;
    msg13.chatMsgId = @"123461";
    
    model1.chatIds = @"123461";
    model1.msgArray = @[msg11,msg12,msg13];
    [array addObject:model];
    [array addObject:model1];
    return array;
}

+ (BOOL)checkIsChatRecordWithUserId:(NSString *)userId
{
    for (DS_WeChatListModel *model in [DS_WeChatControllerManager dataSource]) {
        if (model.chatRoomType == 1 && [model.chatIds isEqualToString:userId]) {
            return YES;
        }
    }
    return NO;
}

+ (DS_WeChatListModel *)obtianSignChatMsgDataWithChatId:(NSString *)chatId
{
    BOOL result = [DS_WeChatControllerManager checkIsChatRecordWithUserId:chatId];
    if (!result) {
        NSAssert(nil, @"must checkIsChatRecordWithUserId is exist");
    }
    for (DS_WeChatListModel *model in [DS_WeChatControllerManager dataSource]) {
        if (model.chatRoomType == 1 && [model.chatIds isEqualToString:chatId]) {
            return model;
        }
    }
    return nil;
}

+ (NSArray *)searchDataSource
{
    DS_WeChatListModel *model1 = [[DS_WeChatListModel alloc] init];
    model1.chatIcon = @"icon2.jpg";
    model1.chatSoundNOticeState = 1;
    model1.chatRoomType = 11;
    return @[model1];
}

+ (NSArray *)menuDataSource
{
    DS_WechatMenuModel *model = [[DS_WechatMenuModel alloc] init];
    model.icon = @"menu_add_newmessage_icon.png";
    model.title = @"发起群聊";
    
    DS_WechatMenuModel *model1 = [[DS_WechatMenuModel alloc] init];
    model1.icon = @"barbuttonicon_add_cube.png";
    model1.title = @"添加朋友";
    
    DS_WechatMenuModel *model2 = [[DS_WechatMenuModel alloc] init];
    model2.icon = @"contacts_add_scan.png";
    model2.title = @"扫一扫";
    
    DS_WechatMenuModel *model3 = [[DS_WechatMenuModel alloc] init];
    model3.icon = @"menu_add_newmessage_icon.png";
    model3.title = @"收付款";
    
    return @[model,model1,model2,model3];
}
@end
