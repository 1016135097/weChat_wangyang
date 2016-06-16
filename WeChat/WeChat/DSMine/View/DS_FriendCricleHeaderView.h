//
//  DS_FriendCricleHeaderView.h
//  WeChat
//
//  Created by wangyang on 16/5/30.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DS_UserModel,DS_AddressBookModel;
@interface DS_FriendCricleHeaderView : UIView
@property (nonatomic,strong)DS_UserModel *userModel;
@property (nonatomic,strong)DS_AddressBookModel *bookModel;
@end
