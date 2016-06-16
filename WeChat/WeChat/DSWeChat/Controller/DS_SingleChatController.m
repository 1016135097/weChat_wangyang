//
//  DS_SingleChatController.m
//  WeChat
//
//  Created by wangyang on 16/5/19.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_SingleChatController.h"
#import "DS_UserHeader.h"

@interface DS_SingleChatController ()

@end

@implementation DS_SingleChatController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = DS_CustomLocalizedString(self.roomModel.chatRoomName, nil);
    if (self.joinType == DS_ChatRoomJoinTypeVideoChat) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"视频聊天连线中" message:@"正在开发中，敬请期待" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
    }else if (self.joinType == DS_ChatRoomJoinTypeSoundChat){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"语音聊天连线中" message:@"正在开发中，敬请期待" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
    }
    [self scrollViewToBottom];
}

#pragma mark - 相册照片回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //得到图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
    UIImage *newImage = [UIImage imageWithData:imageData];
    NSLog(@"%@",newImage);
}

#pragma mark - DS_KeyboardViewDelegate
- (void)keyBoardSendMsgTextView:(DS_KeyboardView *)view sendMsgText:(NSString *)text
{
    DS_WeChatMsgModel *model = [self cofigMsgStrcutWithMsg:text];
    NSMutableArray *array = [self.roomModel.msgArray mutableCopy];
    [array addObject:model];
    self.roomModel.msgArray = array;
    self.dataSourceArray = [self.roomModel.msgArray mutableCopy];
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:1];
    [indexPaths addObject:[NSIndexPath indexPathForRow:self.dataSourceArray.count - 1 inSection:0]];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    [self scrollViewToBottom];
}

#pragma mark - 组建消息结构体
- (DS_WeChatMsgModel *)cofigMsgStrcutWithMsg:(NSString *)msg
{
    DS_WeChatMsgModel *model = [[DS_WeChatMsgModel alloc] init];
    DS_UserTool *user = [DS_UserTool shareInstance];
    model.userIcon = user.userModel.icon;
    model.msgSources = YES;
    model.userName = user.userModel.name;
    model.msg = msg;
    model.msgType = 1;
    model.timestamp = @"18:43";
    model.showTimetamp = NO;
    model.chatMsgId = user.userModel.userId;
    return model;
}

@end
