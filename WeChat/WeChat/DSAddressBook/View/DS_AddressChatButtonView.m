//
//  DS_AddressChatButtonView.m
//  WeChat
//
//  Created by wangyang on 16/5/28.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_AddressChatButtonView.h"

@interface DS_AddressChatButtonView ()
@property (nonatomic,strong)UIButton *sendMsgButton;
@property (nonatomic,strong)UIButton *videoChatButton;
@end

@implementation DS_AddressChatButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.sendMsgButton];
        [self addSubview:self.videoChatButton];
        [self needsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    WEAKSELF;
    [self.sendMsgButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mas_top).offset(20);
        make.height.mas_equalTo(@50);
        make.left.mas_equalTo(weakSelf.mas_left).offset(20);
        make.width.mas_equalTo(UISCREENWIDTH - 40);
    }];
    
    [self.videoChatButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.sendMsgButton.mas_bottom).offset(15);
        make.height.mas_equalTo(@50);
        make.left.mas_equalTo(weakSelf.mas_left).offset(20);
        make.width.mas_equalTo(UISCREENWIDTH - 40);
    }];
    [super updateConstraints];
}

- (void)sendMsgAction
{
    if (self.sendMsgBlock) {
        self.sendMsgBlock();
    }
}

- (void)videoChatAction
{
    if (self.videoChatBlock) {
        self.videoChatBlock();
    }
}

- (UIButton *)sendMsgButton
{
    if (!_sendMsgButton) {
        _sendMsgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendMsgButton setTitle:DS_CustomLocalizedString(@"sendMsg", nil) forState:UIControlStateNormal];
        [_sendMsgButton setBackgroundImage:[[UIImage imageNamed:@"fts_green_btn.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateNormal];
        [_sendMsgButton setBackgroundImage:[[UIImage imageNamed:@"fts_green_btn_HL.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateSelected];
        [_sendMsgButton addTarget:self action:@selector(sendMsgAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendMsgButton;
}

- (UIButton *)videoChatButton
{
    if (!_videoChatButton) {
        _videoChatButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_videoChatButton setTitle:DS_CustomLocalizedString(@"videoChat", nil) forState:UIControlStateNormal];
        [_videoChatButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_videoChatButton setBackgroundImage:[[UIImage imageNamed:@"collect_pic_bg.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateNormal];
        [_videoChatButton setBackgroundImage:[[UIImage imageNamed:@"fts_gray_btn_HL.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:15] forState:UIControlStateSelected];
        _videoChatButton.layer.masksToBounds = YES;
        _videoChatButton.layer.cornerRadius = 7.f;
        [_videoChatButton addTarget:self action:@selector(videoChatAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _videoChatButton;
}
@end
