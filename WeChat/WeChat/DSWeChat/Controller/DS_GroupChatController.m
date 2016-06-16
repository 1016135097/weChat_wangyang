//
//  DS_GroupChatController.m
//  WeChat
//
//  Created by wangyang on 16/5/19.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_GroupChatController.h"

@interface DS_GroupChatController ()

@end

@implementation DS_GroupChatController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *title = [NSString stringWithFormat:@"%@(%@)",self.roomModel.chatRoomName,self.roomModel.memberNums];
    self.title = DS_CustomLocalizedString(title, nil);
    WEAKSELF;
    _timer = [NSTimer scheduledTimerWithTimeInterval:KtimeDuration block:^{
        [weakSelf scrollToRow];
    } repeats:YES];
}

@end
