//
//  DS_FriendCricleController.h
//  WeChat
//
//  Created by wangyang on 16/5/29.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_BaseTableViewController.h"
@class DS_AddressBookModel;

@interface DS_FriendCricleController : DS_BaseTableViewController
/**
 * Check the circle of friends,From the address book
 */
@property (nonatomic,strong)DS_AddressBookModel *model;
@end
