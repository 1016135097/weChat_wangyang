//
//  DS_AddressBookModel.h
//  WeChat
//
//  Created by wangyang on 16/5/23.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,DS_AddressBookType) {
    DS_AddressBookTypeContact = 0,    //联系人
    DS_AddressBookTypeAddFriends,  //新的朋友
    DS_AddressBookTypeGroupChat,  //群聊
    DS_AddressBookTypeTag,        //标签
    DS_AddressBookTypePiblicNumber //公众号
};

@interface DS_AddressBookModel : NSObject
@property (nonatomic,copy)NSString *icon;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *number;
@property (nonatomic,copy)NSString *namePrefix;
@property (nonatomic,assign)DS_AddressBookType type; //类型
@property (nonatomic,copy)NSString *area;
@property (nonatomic,copy)NSString *weixinNumber;
@property (nonatomic,copy)NSString *userId;
//社交资料
@property (nonatomic,copy)NSString *socialContact;
//朋友圈背景图
@property (nonatomic,copy)NSString *circleBgImage;

@end
