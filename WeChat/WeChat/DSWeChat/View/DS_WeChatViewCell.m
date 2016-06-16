//
//  DS_WeChatViewCell.m
//  WeChat
//
//  Created by wangyang on 16/5/15.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_WeChatViewCell.h"
#import "DS_ChatMessage.h"
#import "UILabel+DSAdaptContent.h"

@interface DS_WeChatViewCell () {
    NSInteger _showSubIndex;
    NSTimer *_timer;
}
@property (nonatomic,strong)UIImageView *iconImageView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *subTitleLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UIImageView *soundLabel;
@end

@implementation DS_WeChatViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.subTitleLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.soundLabel];
        [self updateCellContentConstraints];
    }
    return self;
}

- (void)updateCellContentConstraints
{
    WEAKSELF;
    [self.iconImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44.5, 44.5));
        make.top.mas_equalTo(weakSelf.contentView).offset(8);
        make.left.mas_equalTo(weakSelf.contentView).offset(9);
    }];
    
    [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.contentView).offset(-10);
        make.top.mas_equalTo(weakSelf.contentView).offset(14);
        make.width.mas_lessThanOrEqualTo(100);
    }];
    [self.titleLabel setContentHuggingWithLabelContent];
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.iconImageView.mas_right).offset(9);
        make.top.mas_equalTo(weakSelf.contentView).offset(12.5);
        make.right.mas_equalTo(weakSelf.timeLabel.mas_left).offset(-10);
        make.height.mas_equalTo(17.);
    }];
    
    [self.subTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.titleLabel.mas_left);
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).offset(8);
        make.right.mas_equalTo(weakSelf.contentView).offset(-10);
        make.height.mas_equalTo(17);
    }];
}

#pragma mark - setter and getter
- (void)setModel:(DS_WeChatListModel *)model
{
    _model = model;
    switch (model.chatRoomType) {
        case DS_ChatTypeSearch:
            [self searchListCell];
            break;
        default:
            [self chatListCell];
            break;
    }
}

- (void)searchListCell
{
    self.subTitleLabel.text = DS_CustomLocalizedString(@"searchListCell", nil);
    self.iconImageView.image = [UIImage imageNamed:self.model.chatIcon];
    NSString *attriString = [NSString stringWithFormat:@"搜一搜 %@",self.model.chatRoomName];
    [self.titleLabel labelWithNomalText:attriString
                     attributeTextRange:[attriString rangeOfString:self.model.chatRoomName]
                     attributeTextColor:[UIColor greenColor]];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)chatListCell
{
    DS_WeChatMsgModel *msgLastModel = [self.model.msgArray lastObject];
    self.timeLabel.text = msgLastModel.timestamp;
    self.titleLabel.text = self.model.chatRoomName;
    self.iconImageView.image = [UIImage imageNamed:self.model.chatIcon];
    WEAKSELF;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 block:^{
        STRONGSELF;
        [strongSelf showSubTitle];
    } repeats:YES];
}

- (void)showSubTitle
{
    if (_showSubIndex + 1 > self.model.msgArray.count) {
        [_timer invalidate];
        _timer = nil;
        return;
    }
    DS_WeChatMsgModel *msg = self.model.msgArray[_showSubIndex];
    if (self.model.chatRoomType == DS_ChatTypeRoom && !msg.msgSources) {
        self.subTitleLabel.text = [NSString stringWithFormat:@"%@:%@",msg.userName,msg.msg];
    }else {
        self.subTitleLabel.text = msg.msg;
    }
    _showSubIndex ++;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.cornerRadius = 5.f;
    }
    return _iconImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16.];
        _titleLabel.textColor = UIColorFromRGB(0x070707);
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel
{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.font = [UIFont systemFontOfSize:14.];
        _subTitleLabel.textColor = UIColorFromRGB(0x949494);
        _subTitleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _subTitleLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:13.];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.textColor = UIColorFromRGB(0x949494);
    }
    return _timeLabel;
}

@end
