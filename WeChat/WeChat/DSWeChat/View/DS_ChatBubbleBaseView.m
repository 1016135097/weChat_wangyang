//
//  DS_ChatBubbleBaseView.m
//  WeChat
//
//  Created by wangyang on 16/6/7.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_ChatBubbleBaseView.h"

@implementation DS_ChatBubbleBaseView

- (instancetype)init
{
    if (self = [super init]) {
        [self addSubview:self.bubbleImageView];
        [self updateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    WEAKSELF;
    [self.bubbleImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
    }];
    [super updateConstraints];
}

- (void)setMsgSources:(BOOL)msgSources
{
    _msgSources = msgSources;
    UIImage *img = nil;
    if (msgSources) {
        img = [UIImage imageNamed:@"weChatBubble_Sending_icon.png"];
    }else {
        img = [UIImage imageNamed:@"weChatBubble_Receiving_icon.png"];
    }
    self.bubbleImageView.image = DS_STRETCH_IMAGE(img,UIEdgeInsetsMake(30, 28, 85, 28));
}

- (UIImageView *)bubbleImageView
{
    if (!_bubbleImageView) {
        _bubbleImageView = [[UIImageView alloc] init];
        [_bubbleImageView setAutoresizingMask: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    }
    return _bubbleImageView;
}

@end
