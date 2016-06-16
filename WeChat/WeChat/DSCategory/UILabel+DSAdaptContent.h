//
//  UILabel+DSAdaptContent.h
//  WeChat
//
//  Created by wangyang on 16/5/15.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (DSAdaptContent)
- (void)setContentHuggingWithLabelContent;
- (NSInteger)calculateLabelNumberOfRowsWithText:(NSString *)text
                                       withFont:(UIFont *)font
                                   withMaxWidth:(CGFloat)width;
@end

@interface UILabel (DSAttributeText)
- (void)labelWithNomalText:(NSString *)nomalString
        attributeTextRange:(NSRange)range
        attributeTextColor:(UIColor *)attrTextColor;
@end