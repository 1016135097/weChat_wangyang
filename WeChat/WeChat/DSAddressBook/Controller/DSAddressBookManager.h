//
//  DSAddressBookManager.h
//  WeChat
//
//  Created by wangyang on 16/5/23.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSAddressBookManager : NSObject
+ (BOOL)showAddressBook;
+ (void)readAddressBookWithList:(void(^)(NSArray *listArray,NSArray *alphabetArray,NSInteger totoal))block;
@end
