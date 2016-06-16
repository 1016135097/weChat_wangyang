//
//  WYLabel.h    2.0
//  TextKitDemo  系统要求最低:iOS7 
//  author  王阳  邮箱:wangyang307395644@126.com    QQ:1508425305
//  Created by wangyang on 15/9/23.
//  Copyright (c) 2015年 wangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYLabel;

typedef NS_ENUM(NSInteger, WYLabelVerticalAlignment){
    WYLabelVerticalAlignmentTop = 0,
    WYLabelVerticalAlignmentMiddle,
    WYLabelVerticalAlignmentBottom
};

typedef NS_ENUM(NSUInteger, WYLabelLinkStyle) {
    WYLabelLinkStyleIphoneNumber = 0,  //电话号码
    WYLabelLinkStyleWeb,               //网址
    WYLabelLinkStyleUserText,          //用户自定义文字
    WYLabelLinkStyleOther,             //文本中点击的文字
    WYLabelLinkStyleALL                //all
};

@protocol WYLabelDelegate <NSObject>
@optional
/**
 *  点击link
 *
 *  @param label     self
 *  @param text      点击的link文本
 *  @param linkStyle 点击的link文本类型
 */
- (void)labelLinkClickedWithLabel:(UILabel *)label withCilckedText:(NSString *)text withLinkStyle:(WYLabelLinkStyle)linkStyle;
@end

@interface WYLabel : UILabel

/**
 *  链接、标签、用户名是否可点击  default YES
 */
@property (nonatomic,assign,getter=isAutomaticLinkClicked)IBInspectable BOOL automaticLinkClicked;

/**
 *  可点击link的文本颜色 default blue
 */
@property (nonatomic, strong)IBInspectable UIColor *selectedLinkTextColor;

/**
 *  是否允许点击link有背景色   默认允许
 */
@property (nonatomic,assign,getter=isLinkBackGroudColor) IBInspectable BOOL linkBackGroudColor;

/**
 *  可点击link背景色  default  gray
 */
@property (nonatomic, strong)IBInspectable UIColor *selectedLinkBackGroudColor;

/**
 *  可点击link是否需要下划线  default Yes
 */
@property (nonatomic, assign,getter=isLinkUnderLine)IBInspectable BOOL linkUnderLine;

/**
 *  可点击link文字线宽
 */
@property (nonatomic,assign)NSUInteger linkTextWidth;

/**
 *  文本VerticalStyle  defalut AlignmentMiddle
 */
@property (nonatomic,assign)WYLabelVerticalAlignment labelVerticalAlignment;

/**
 *  距离top间距
 */
@property (nonatomic,assign)NSInteger sapcingTop;

//@property (nonatomic)

/**
 *  自定义link文字
 */
@property (nonatomic,strong)NSArray *linkTextArray;

/**
 *  允许文本的每一个字都可以点击  defalut No
 */
@property (nonatomic,assign,getter=isAllTextLink)BOOL allTextLink;

/**
 *  link 类型 default web
 */
@property (nonatomic,assign)WYLabelLinkStyle labelLinkStyle;
@property (nonatomic,assign)id <WYLabelDelegate> delegate;
@end
