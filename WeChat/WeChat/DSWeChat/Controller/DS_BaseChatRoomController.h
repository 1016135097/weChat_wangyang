//
//  DS_BaseChatRoomController.h
//  WeChat
//
//  Created by wangyang on 16/5/17.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_BaseTableViewController.h"
#import "DS_ChatMessage.h"
#import "DS_KeyboardView.h"

extern const NSTimeInterval KtimeDuration;

@interface DS_BaseChatRoomController : DS_BaseTableViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate,DS_KeyboardViewDelegate> {
    NSTimer *_timer;
    NSInteger _scrollIndex;
}

@property (nonatomic,strong)DS_WeChatListModel *roomModel;
@property (nonatomic,strong)DS_KeyboardView *keyBoardView;

/**
 * Scroll to the bottom for the first time in msg unread
 */
- (void)scrollToRow;

/**
 * 滚到底部
 */
- (void)scrollViewToBottom;


@end
