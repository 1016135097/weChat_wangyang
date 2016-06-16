//
//  DS_ChatBubbleBaseView.h
//  WeChat
//
//  Created by wangyang on 16/6/7.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DS_ChatMessage.h"

@interface DS_ChatBubbleBaseView : UIView

//背景
@property (nonatomic,strong)UIImageView *bubbleImageView;
//消息来自自己还是其他人
@property (nonatomic,assign)BOOL msgSources;
@end
