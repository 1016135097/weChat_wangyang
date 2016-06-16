//
//  DS_ActionSheetView.h
//  WeChat
//
//  Created by wangyang on 16/5/29.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DS_ActionSheetView;

@protocol DS_ActionSheetViewDelegate <NSObject>
@optional

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)ActionSheetView:(DS_ActionSheetView *)actionSheetView clickedButtonAtIndex:(NSInteger)buttonIndex;

// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
// If not defined in the delegate, we simulate a click in the cancel button
- (void)ActionSheetViewCancel:(DS_ActionSheetView *)actionSheetView;

- (void)willPresentActionSheetView:(DS_ActionSheetView *)actionSheetView;
// before animation and showing view
- (void)didPresentActionSheetView:(DS_ActionSheetView *)actionSheetView;  // after animation

- (void)actionSheetView:(DS_ActionSheetView *)actionSheetView willDismissWithButtonIndex:(NSInteger)buttonIndex; // before animation and hiding view
- (void)actionSheetView:(DS_ActionSheetView *)actionSheetView didDismissWithButtonIndex:(NSInteger)buttonIndex;

@end

@interface DS_ActionSheetView : UIView
- (instancetype)initWithTitles:(NSArray *)titleArray delegate:(id<DS_ActionSheetViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle;

- (void)showInView:(UIView *)view;

@property(nonatomic,weak)id<DS_ActionSheetViewDelegate> delegate;

/**
 * clicks location title
 */
@property(nonatomic,copy,readonly)NSString *selectedTitle;

/**
 * cancel button title color
 */
@property(nonatomic,strong)UIColor *cancelButtonTextColor;

/**
 * other button title color
 */
@property(nonatomic,strong)UIColor *otherButtonTextColor;

@end

@interface DS_ActionSheetCell : UITableViewCell
@property (nonatomic,strong)UILabel *titleLabel;
@end
