//
//  DS_SocialContactController.m
//  WeChat
//
//  Created by wangyang on 16/5/29.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_SocialContactController.h"
#import "DS_AddressBookModel.h"

@interface DS_SocialContactController ()

@end

@implementation DS_SocialContactController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = DS_CustomLocalizedString(@"socialContactMeans", nil);
    self.dataSourceArray = @[@"个性签名"];
    WEAKSELF;
    [self tableViewCellBlock:^(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath, NSString *model) {
        cell.textLabel.text = model;
        cell.detailTextLabel.text = weakSelf.model.socialContact;
    }];
}

@end
