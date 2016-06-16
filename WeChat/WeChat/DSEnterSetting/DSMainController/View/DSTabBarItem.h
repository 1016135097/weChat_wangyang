//
//  DSTabBarItem.h
//  WeChat
//
//  Created by wangyang on 15/11/4.
//  Copyright © 2015年 wangyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DSTabBarItem;

@protocol DSTabBarItemDlegate <NSObject>
@optional
- (void)tabBarItemSelectedWithItem:(DSTabBarItem *)item;
@end

@interface DSTabBarItem : UIView
@property (nonatomic,assign)BOOL selected;
@property (nonatomic,strong)UITabBarItem *item;
@property (nonatomic,weak)id<DSTabBarItemDlegate> delegate;
@end
