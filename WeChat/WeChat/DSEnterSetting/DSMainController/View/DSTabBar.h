//
//  DSTabBar.h
//  WeChat
//
//  Created by wangyang on 15/11/6.
//  Copyright © 2015年 wangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DSTabBar;
extern NSString *const KSELECTEDITEMNOTI;
@protocol DSTabBarDeletate <NSObject>
@optional
- (void)tabBarItemWithTabBar:(DSTabBar *)tabBar withSelectedItem:(NSUInteger)selectedIndex;

@end

@interface DSTabBar : UIView
- (void)tabBarWithTabBarItem:(UITabBarItem *)item;
/**
 * selected index，default selected 0 
 */
@property (nonatomic,assign)NSUInteger selectedIndex;
@property (nonatomic,assign)id<DSTabBarDeletate> deletgate;
- (void)clickedTabBarIndex:(NSUInteger)index;

@end
