//
//  DS_WeChatAddItemView.h
//  WeChat
//
//  Created by wangyang on 16/5/22.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DS_WechatMenuModel;

typedef NS_ENUM(NSInteger,DS_WeChatAddItemType){
    DS_WeChatAddItemTypeNewMessage = 0, //发起群聊
    DS_WeChatAddItemTypeAddCube,    //添加朋友
    DS_WeChatAddItemTypeScan,       //扫一扫
    DS_WeChatAddItemTypePay         //收付款
};

@interface DS_WeChatAddItemView : UIView
- (instancetype)initWithMenu:(NSArray *)menu;
@property (nonatomic,copy)void (^menuItemClicked)(NSInteger index,DS_WechatMenuModel *model);
@end

@interface DS_WeChatMenuCell : UITableViewCell
@property (nonatomic,strong)DS_WechatMenuModel *model;
@end
