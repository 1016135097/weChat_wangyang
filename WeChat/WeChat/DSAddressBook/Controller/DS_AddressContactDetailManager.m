//
//  DS_AddressContactDetailManager.m
//  WeChat
//
//  Created by wangyang on 16/5/28.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_AddressContactDetailManager.h"
#import "DS_AddressContactDetainCellModel.h"
#import "DS_AddressBookModel.h"
#import "DS_WeChatControllerManager.h"
#import "DS_WeChatListModel.h"

@implementation DS_AddressContactDetailManager
+ (NSArray *)cellDataSoources
{
    DS_AddressContactDetainCellModel *model00 = [[DS_AddressContactDetainCellModel alloc] init];
    model00.iconTag = YES;
    model00.height = 90.;
    NSArray *section0 = @[model00];
    
    DS_AddressContactDetainCellModel *model10 = [[DS_AddressContactDetainCellModel alloc] init];
    model10.comments = DS_CustomLocalizedString(@"conmmentAndTag", nil);
    model10.arrow = YES;
    model10.height = 44.;

    DS_AddressContactDetainCellModel *model11 = [[DS_AddressContactDetainCellModel alloc] init];
    model11.comments = DS_CustomLocalizedString(@"number", nil);
    model11.height = 44.;
    NSArray *section1 = @[model10,model11];
    
    DS_AddressContactDetainCellModel *model20 = [[DS_AddressContactDetainCellModel alloc] init];
    model20.comments = DS_CustomLocalizedString(@"area", nil);
    model20.height = 44.;
    
    DS_AddressContactDetainCellModel *model21 = [[DS_AddressContactDetainCellModel alloc] init];
    model21.comments = DS_CustomLocalizedString(@"personPhoto", nil);
    model21.height = 90.;
    model21.arrow = YES;
    
    DS_AddressContactDetainCellModel *model22 = [[DS_AddressContactDetainCellModel alloc] init];
    model22.comments = DS_CustomLocalizedString(@"more", nil);
    model22.height = 44.;
    model22.arrow = YES;
    
    NSArray *section2 = @[model20,model21,model22];
    
    return @[section0,section1,section2];
}

+ (DS_WeChatListModel *)creatSingChatRoomWithContactModel:(DS_AddressBookModel *)model
{
    BOOL result = [DS_WeChatControllerManager checkIsChatRecordWithUserId:model.userId];
    if (!result) {
        //创建新的单聊聊天室
        DS_WeChatListModel *listModel = [[DS_WeChatListModel alloc] init];
        listModel.chatIcon = model.icon;
        listModel.chatRoomName = model.name;
        listModel.chatSoundNOticeState = 1;
        listModel.chatRoomType = DS_ChatTypeAlone;
        listModel.memberNums = @"1";
        listModel.chatIds = model.userId;
        return listModel;
    }else {
        //获取之前的单聊聊天时数据
        return [DS_WeChatControllerManager obtianSignChatMsgDataWithChatId:model.userId];
    }

}
@end
