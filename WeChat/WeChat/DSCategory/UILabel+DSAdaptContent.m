//
//  UILabel+DSAdaptContent.m
//  WeChat
//
//  Created by wangyang on 16/5/15.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "UILabel+DSAdaptContent.h"

@implementation UILabel (DSAdaptContent)

- (void)setContentHuggingWithLabelContent
{
    [self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
}

- (NSInteger)calculateLabelNumberOfRowsWithText:(NSString *)text
                                       withFont:(UIFont *)font
                                   withMaxWidth:(CGFloat)width
{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return ceil(rect.size.height / font.lineHeight);
}

@end

@implementation UILabel (DSAttributeText)

- (void)labelWithNomalText:(NSString *)nomalString
        attributeTextRange:(NSRange)range
        attributeTextColor:(UIColor *)attrTextColor
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:nomalString];
    [attrString setAttributes:@{NSForegroundColorAttributeName:attrTextColor} range:range];
    self.attributedText = attrString;
}

@end
