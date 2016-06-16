//
//  DS_BaseChatRoomControllerManager.h
//  WeChat
//
//  Created by wangyang on 16/6/14.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DS_BaseChatRoomControllerManager : NSObject

+ (instancetype)shareManager;

/**
 * 打开相册
 */
+ (void)openPhotoWithSuccess:(void(^)(NSArray *photoPictures))photos;


/**
 * 拍照
 */
+ (void)takePictureWithSuccess:(void(^)(UIImage *picture))picture;

@end
