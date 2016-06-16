//
//  DS_AddressContactDetailCell.h
//  WeChat
//
//  Created by wangyang on 16/5/28.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DS_AddressContactDetainCellModel,DS_AddressBookModel;

@interface DS_AddressContactDetailCell : UITableViewCell
@property (nonatomic,strong)DS_AddressContactDetainCellModel *cellModel;
@property (nonatomic,strong)DS_AddressBookModel *model;
@end
