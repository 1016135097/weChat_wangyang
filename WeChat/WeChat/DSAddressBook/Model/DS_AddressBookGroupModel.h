//
//  DS_AddressBookGroupModel.h
//  WeChat
//
//  Created by wangyang on 16/5/24.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DS_AddressBookGroupModel : NSObject
@property(nonatomic, copy)NSString *title;//组索引标题
@property(nonatomic,assign)NSInteger count;//组中人数
@property(nonatomic,strong)NSArray *contacts;//组中对应的人
@end
