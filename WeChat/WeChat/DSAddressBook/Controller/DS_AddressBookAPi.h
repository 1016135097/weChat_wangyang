//
//  DS_AddressBookAPi.h
//  WeChat
//
//  Created by wangyang on 16/5/23.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DS_AddressBookAPi : NSObject
+ (instancetype)defaultManager;
/**
 *  检查权限
 */
- (BOOL)checkAddressBookAuthorization;
- (void)readAddressBookList:(void (^)(NSArray *bookList))block;
@end