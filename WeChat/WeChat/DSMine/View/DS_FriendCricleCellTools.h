//
//  DS_FriendCricleCellTools.h
//  WeChat
//
//  Created by wangyang on 16/6/1.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DS_FriendCricleTool.h"
/**配图片间距**/
static const CGFloat KPictureMargin = 10.f;
/**屏幕左、右间距**/
static const CGFloat KLeftMargin = 15.;
/**头像尺寸**/
static const CGFloat KHeaderIconSizeWidth = 45.;

/**
 * 描述语、rss区域、用户名最大宽度
 */
#define KDescTextMaxWidth \
[DS_FriendCricleCellTools rssContentFrameSizeWidth]

/**
 * 配图图片实际宽度（多张情况下）
 */
#define KPictureHeight [DS_FriendCricleCellTools rssContentPictureSizeWidth];

//点击评论的通知
extern NSString *const KclickPraiseAndComment;

typedef struct ClickPraiseAndComment{
    NSInteger cellIndex;
    NSInteger commentIndex;
    char _commentString;
    NSInteger praiseIndex;
}ClickPraiseAndComment;

@interface DS_FriendCricleCellTools : NSObject
+ (CGFloat)calculatePictureHeightWithPictures:(NSArray *)pictures;
+ (CGFloat)calculatePictureHeightWithFeedType:(DSFriendCircleFeedType)type;
+ (CGFloat)rssContentPictureSizeWidth;
+ (CGFloat)rssContentFrameSizeWidth;
@end
