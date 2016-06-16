//
//  DS_FriendCricleTool.m
//  WeChat
//
//  Created by wangyang on 16/6/2.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_FriendCricleTool.h"

static NSString *const KReplaceSting = @"FeedType";

@implementation DS_FriendCricleTool

+ (NSString *)returnReusableCellWithIdentifier:(DSFriendCircleFeedType)type
{
    switch (type) {
        case DSFriendCircleFeedTypeNomal:
            return @"DSFriendCircle_Nomal";
            break;
        case DSFriendCircleFeedTypePicture:
            return @"DSFriendCircle_Picture";
            break;
        case DSFriendCircleFeedTypeSignNew:
            return @"DSFriendCircle_New";
            break;
        case DSFriendCircleFeedTypeTwoNew:
            return @"DSFriendCircle_TwoNew";
            break;
        case DSFriendCircleFeedTypeVideo:
            return @"DSFriendCircle_Video";
        default:
            return @"DSFriendCircle_Unknown";
            break;
    }
    return @"DSFriendCircle_Unknown";
}

+ (DSFriendCircleFeedType)returnFeedTypeWithIndentifier:(NSString *)identifier
{
     return [[DS_FriendCricleTool cellIdentifier][identifier] intValue];
}

+ (NSDictionary *)cellIdentifier
{
    return @{@"DSFriendCircle_Nomal":@(DSFriendCircleFeedTypeNomal),
             @"DSFriendCircle_Picture":@(DSFriendCircleFeedTypePicture),
             @"DSFriendCircle_New":@(DSFriendCircleFeedTypeSignNew),
             @"DSFriendCircle_TwoNew":@(DSFriendCircleFeedTypeTwoNew),
             @"DSFriendCircle_Video":@(DSFriendCircleFeedTypeVideo)
             };
}
@end
