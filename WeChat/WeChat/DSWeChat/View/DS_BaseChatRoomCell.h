//
//  DS_BaseChatRoomCell.h
//  WeChat
//
//  Created by wangyang on 16/5/17.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DS_WeChatMsgModel;

@interface DS_BaseChatRoomCell : UITableViewCell
@property (nonatomic,strong)DS_WeChatMsgModel *msgModel;
@end
