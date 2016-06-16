//
//  DS_ChatBubbleView.m
//  WeChat
//
//  Created by wangyang on 16/5/17.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_ChatBubbleView.h"
#import "DS_ChatBubblePictureView.h"
#import "DS_ChatBubbleTextView.h"
#import "DS_WeChatListModel.h"
#import "DS_ChatBubblePictureView.h"

@interface DS_ChatBubbleView ()
//纯文本
@property (nonatomic,strong)DS_ChatBubbleTextView *textView;
//图片
@property (nonatomic,strong)DS_ChatBubblePictureView *pictureView;
@property (nonatomic,strong)NSMutableArray *subViewArray;
@end

@implementation DS_ChatBubbleView
- (instancetype)init
{
    if (self = [super init]) {
        [self addSubview:self.pictureView];
        [self addSubview:self.textView];
        [self.subViewArray addObject:self.textView];
        [self.subViewArray addObject:self.pictureView];
        [self updateViewConstraints];
    }
    return self;
}

- (void)updateViewConstraints
{
//    WEAKSELF;
    if ([self.textView superview]) {
        [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    
    if ([self.pictureView superview]) {        
        [self.pictureView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 40));
        }];
    }
}

- (void)removeFromSuperviewWithOutView:(UIView *)subView
{
    [self.subViewArray enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![subView isEqual:obj]) {
            [obj removeFromSuperview];
        }
    }];
    
    if (![subView superview]) {
        [self addSubview:subView];
    }
}

#pragma mark - setter 赋值
- (void)setMsgModel:(DS_WeChatMsgModel *)msgModel
{
    _msgModel = msgModel;
    
    switch (msgModel.msgType) {
        case DS_ChatMessageTypeText:
        {
            [self removeFromSuperviewWithOutView:self.textView];
            [self updateViewConstraints];
            self.textView.msgSources = msgModel.msgSources;
            self.textView.msgTextLabel.text = msgModel.msg;
        }
            break;
        case DS_ChatRoomTypePicture:
        {
            [self removeFromSuperviewWithOutView:self.pictureView];
            [self updateViewConstraints];
            self.pictureView.msgSources = msgModel.msgSources;
            self.pictureView.pictureUrl = msgModel.msg;
        }
            break;
        default:
            break;
    }
}


#pragma mark - getter
- (DS_ChatBubblePictureView *)pictureView
{
    if (!_pictureView) {
        _pictureView = [[DS_ChatBubblePictureView alloc] init];
    }
    return _pictureView;
}

- (DS_ChatBubbleTextView *)textView
{
    if (!_textView) {
        _textView = [[DS_ChatBubbleTextView alloc] init];
    }
    return _textView;
}

- (NSMutableArray *)subViewArray
{
    if (!_subViewArray) {
        _subViewArray = [NSMutableArray array];
    }
    return _subViewArray;
}

@end
