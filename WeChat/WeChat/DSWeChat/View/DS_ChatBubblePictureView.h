//
//  DS_ChatBubblePictureView.h
//  WeChat
//
//  Created by wangyang on 16/6/7.
//  Copyright © 2016年 wangyang. All rights reserved.
//

//#import "DS_ChatBubbleBaseView.h"
#import <UIKit/UIKit.h>

@interface DS_ChatBubblePictureView : UIView
//图片页面
@property (nonatomic, strong)NSString * pictureUrl;
//消息来自自己还是其他人
@property (nonatomic,assign)BOOL msgSources;
@end
