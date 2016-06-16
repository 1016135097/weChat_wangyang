//
//  DS_FriendCricleTool.h
//  WeChat
//
//  Created by wangyang on 16/6/2.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * DS_FriendCircleFeedTypeNomal  纯文本
 * DS_FriendCircleFeedTypeNew  图 + 文字(2行显示，不满一行时，居中显示)
 **/

typedef NS_ENUM(NSUInteger,DSFriendCircleFeedType){
    DSFriendCircleFeedTypeNomal = 1,  //普通模式
    DSFriendCircleFeedTypePicture = 2, //照片
    DSFriendCircleFeedTypeSignNew = 3,  //单行新闻
    DSFriendCircleFeedTypeTwoNew = 4,  //2行行新闻
    DSFriendCircleFeedTypeVideo = 10  //小视频
};

#define KCellIndentifier(FeedType) [DS_FriendCricleTool returnReusableCellWithIdentifier:FeedType]

#define KCellFeedType(identifier) [DS_FriendCricleTool returnFeedTypeWithIndentifier:identifier]

@interface DS_FriendCricleTool : NSObject

/**
 * return cell identifier
 */
+ (NSString *)returnReusableCellWithIdentifier:(DSFriendCircleFeedType)type;
+ (DSFriendCircleFeedType)returnFeedTypeWithIndentifier:(NSString *)identifier;
+ (NSDictionary *)cellIdentifier;
@end
