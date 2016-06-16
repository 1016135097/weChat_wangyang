//
//  DS_FriendCricleControllerManager.h
//  WeChat
//
//  Created by wangyang on 16/5/31.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^acceptDataBlock)(NSArray *dataArray);

@interface DS_FriendCricleControllerManager : NSObject

+ (instancetype)shareInstance;
- (void)requestWebData;
- (void)dataSourceWithBlock:(acceptDataBlock)block;

@end
