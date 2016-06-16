//
//  DS_AddressContactDetailCell.m
//  WeChat
//
//  Created by wangyang on 16/5/28.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_AddressContactDetailCell.h"
#import "DS_AddressContactDetainCellModel.h"
#import "UILabel+DSAdaptContent.h"
#import "DS_AddressBookModel.h"

@interface DS_AddressContactDetailCell ()
@property (nonatomic,strong)UIImageView *iconImageView;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *weixinNumberLabel;
@property (nonatomic,strong)UILabel *titleLabel;
//地区+电话号码
@property (nonatomic,strong)UILabel *dataLabel;
@end

@implementation DS_AddressContactDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.weixinNumberLabel];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.dataLabel];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    WEAKSELF;
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView).offset(15);
        make.centerY.mas_equalTo(weakSelf.contentView);
    }];
    [self.titleLabel setContentHuggingWithLabelContent];
    
    [self.iconImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.left.mas_equalTo(weakSelf.contentView).offset(15);
        make.centerY.mas_equalTo(weakSelf.contentView);
    }];
    
    [self.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.iconImageView.mas_right).offset(15);
        make.top.mas_equalTo(weakSelf.iconImageView.mas_top).offset(0);
        make.right.mas_equalTo(weakSelf.contentView).offset(-15);
    }];
    
    [self.weixinNumberLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.nameLabel.mas_left);
        make.top.mas_equalTo(weakSelf.nameLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(weakSelf.contentView).offset(-15);
    }];
    
    [self.dataLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.left.mas_equalTo(weakSelf.contentView).offset(120);
        make.right.mas_equalTo(weakSelf.contentView).offset(-15);
    }];
    [super updateConstraints];
}

- (void)setCellModel:(DS_AddressContactDetainCellModel *)cellModel
{
    _cellModel = cellModel;
    if (cellModel.iconTag) {
        self.iconImageView.hidden = NO;
        self.nameLabel.hidden = NO;
        self.weixinNumberLabel.hidden = NO;
        self.titleLabel.hidden = YES;
    }else {
        self.iconImageView.hidden = YES;
        self.nameLabel.hidden = YES;
        self.weixinNumberLabel.hidden = YES;
        self.titleLabel.hidden = NO;
        self.titleLabel.text = cellModel.comments;
    }
    
    if ([self.cellModel.comments isEqualToString:DS_CustomLocalizedString(@"area", nil)] || [self.cellModel.comments isEqualToString:DS_CustomLocalizedString(@"number", nil)]) {
        self.dataLabel.hidden = NO;
    }else {
        self.dataLabel.hidden = YES;
    }
    
    if (cellModel.arrow) {
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}

- (void)setModel:(DS_AddressBookModel *)model
{
    _model = model;
    if (self.cellModel.iconTag) {
        self.iconImageView.image = [UIImage imageNamed:model.icon];
        self.nameLabel.text = model.name;
        self.weixinNumberLabel.text = [NSString stringWithFormat:@"微信号：%@",model.weixinNumber];
    }
    
    if (!self.dataLabel.hidden) {
        if ([self.cellModel.comments isEqualToString:DS_CustomLocalizedString(@"number", nil)]) {
            self.dataLabel.textColor = UIColorFromRGB(0x5c6991);
            self.dataLabel.text = model.number;
        }else {
            self.dataLabel.textColor = UIColorFromRGB(0x000000);
            self.dataLabel.text = model.area;
        }
    }
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _nameLabel;
}

- (UILabel *)weixinNumberLabel
{
    if (!_weixinNumberLabel) {
        _weixinNumberLabel = [[UILabel alloc] init];
        _weixinNumberLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _weixinNumberLabel.textColor = [UIColor grayColor];
    }
    return _weixinNumberLabel;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

- (UILabel *)dataLabel
{
    if (!_dataLabel) {
        _dataLabel = [[UILabel alloc] init];
    }
    return _dataLabel;
}
@end
