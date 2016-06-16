//
//  UIViewController+DSPushViewController.h
//  WeChat
//
//  Created by wangyang on 16/5/12.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (DSPushViewController)

/**
 * viewController:next viewController
 * animated 
 * index:back parentController when pop
 */
- (void)pushMyViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
                       index:(NSInteger)index;
@end
