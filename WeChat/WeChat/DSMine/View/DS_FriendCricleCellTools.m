//
//  DS_FriendCricleCellTools.m
//  WeChat
//
//  Created by wangyang on 16/6/1.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_FriendCricleCellTools.h"

NSString *const KclickPraiseAndComment = @"KclickPraiseAndCommentAction";

@implementation DS_FriendCricleCellTools

#pragma mark - rss 结构高度计算
+ (CGFloat)calculatePictureHeightWithFeedType:(DSFriendCircleFeedType)type
{
    CGFloat height = 0.f;
    switch (type) {
        case DSFriendCircleFeedTypeNomal:
            break;
        case DSFriendCircleFeedTypeSignNew:
        case DSFriendCircleFeedTypeTwoNew:
            height = 60.f;
            break;
        case DSFriendCircleFeedTypeVideo:
            height = 300.f;
            break;
        default:
            break;
    }
    return height;
}

+ (CGFloat)calculatePictureHeightWithPictures:(NSArray *)pictures
{
    if (!pictures || pictures.count == 0) {
        return 0.f;
    }
    switch (pictures.count) {
        case 1:
            return [DS_FriendCricleCellTools calculateSignPictureHeight:[pictures firstObject]];
            break;
        case 2:
        case 3:
            return KPictureHeight;
        case 4:
        case 5:
        case 6:
            return [DS_FriendCricleCellTools rssContentPictureSizeWidth] * 2 + KPictureMargin;
            break;
        case 7:
        case 8:
        case 9:
        default:
            return [DS_FriendCricleCellTools rssContentPictureSizeWidth] * 3 + KPictureMargin * 2;
            break;
    }
}

/**服务器返回来的一张图片缩略图在图片后缀**/
+ (CGFloat)calculateSignPictureHeight:(NSString *)url
{
    return 100;
}

#pragma mark - rss内部空间宽度计算
+ (CGFloat)rssContentPictureSizeWidth
{
    return ([DS_FriendCricleCellTools rssContentFrameSizeWidth] - KPictureMargin * 2) /3.f;
}

+ (CGFloat)rssContentFrameSizeWidth
{
    return UISCREENWIDTH - KLeftMargin * 2 - KPictureMargin - KHeaderIconSizeWidth;
}
@end
