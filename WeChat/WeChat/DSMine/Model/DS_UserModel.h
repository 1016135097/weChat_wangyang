//
//  DS_UserModel.h
//  WeChat
//
//  Created by wangyang on 16/5/29.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DS_UserModel : NSObject
//头像
@property (nonatomic,copy)NSString *icon;
//名字
@property (nonatomic,copy)NSString *name;
//微信号
@property (nonatomic,copy)NSString *weiXinNumber;
//我的二维码
@property (nonatomic,copy)NSString *qrCode;
//我的地址
@property (nonatomic,copy)NSString *address;
//性别
@property (nonatomic,copy)NSString *sex;
//地区
@property (nonatomic,copy)NSString *area;
//个性签名
@property (nonatomic,copy)NSString *signature;
//userId
@property (nonatomic,copy)NSString *userId;
//朋友圈背景色
@property (nonatomic,copy)NSString *circleBgImage;


@end
