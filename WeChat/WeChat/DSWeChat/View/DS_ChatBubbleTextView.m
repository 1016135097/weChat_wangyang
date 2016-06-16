//
//  DS_ChatBubbleTextView.m
//  WeChat
//
//  Created by wangyang on 16/6/7.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_ChatBubbleTextView.h"
#import "UILabel+DSAdaptContent.h"

@interface DS_ChatBubbleTextView ()
@end

@implementation DS_ChatBubbleTextView

- (instancetype)init
{
    if (self = [super init]) {
        [self addSubview:self.bubbleImageView];
        [self addSubview:self.msgTextLabel];
        [self updateViewConstraint];
    }
    return self;
}

- (void)updateViewConstraint
{
    WEAKSELF;
    [self.msgTextLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).with.insets(UIEdgeInsetsMake(10, 20, 10, 20));
    }];
    [self.msgTextLabel setContentHuggingWithLabelContent];
}

- (UILabel *)msgTextLabel
{
    if (!_msgTextLabel) {
        _msgTextLabel = [[UILabel alloc] init];
        _msgTextLabel.font = KCHATBUBBLEFONT;
        _msgTextLabel.numberOfLines = 0;
    }
    return _msgTextLabel;
}

@end
