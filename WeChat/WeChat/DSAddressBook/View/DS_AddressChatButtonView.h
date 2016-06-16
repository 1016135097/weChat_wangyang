//
//  DS_AddressChatButtonView.h
//  WeChat
//
//  Created by wangyang on 16/5/28.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DS_AddressChatButtonView : UIView
@property (nonatomic,copy)void (^sendMsgBlock)(void);
@property (nonatomic,copy)void (^videoChatBlock)(void);
@end
