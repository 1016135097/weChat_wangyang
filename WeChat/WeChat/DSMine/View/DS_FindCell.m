//
//  DS_FindCell.m
//  WeChat
//
//  Created by wangyang on 16/5/29.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_FindCell.h"
#import "DS_FindCellModel.h"

@interface DS_FindCell ()
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIImageView *iconImageView;
//头像
@property (nonatomic,strong)UIImageView *headIconImageView;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *subNameLabel;
@property (nonatomic,strong)UIImageView *QrCodeImageView;

@end

@implementation DS_FindCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.headIconImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.subNameLabel];
        [self.contentView addSubview:self.QrCodeImageView];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    WEAKSELF;
    [self.iconImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.left.mas_equalTo(weakSelf.contentView).offset(15);
    }];
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.contentView).offset(-15);
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.left.mas_equalTo(weakSelf.iconImageView.mas_right).offset(15);
    }];
    
    [self.headIconImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.left.mas_equalTo(weakSelf.contentView).offset(15);
        make.centerY.mas_equalTo(weakSelf.contentView);
    }];
    
    [self.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.headIconImageView.mas_right).offset(15);
        make.top.mas_equalTo(weakSelf.headIconImageView.mas_top).offset(0);
        make.right.mas_equalTo(weakSelf.contentView).offset(-15);
    }];
    
    [self.subNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.nameLabel.mas_left);
        make.top.mas_equalTo(weakSelf.nameLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(weakSelf.contentView).offset(-15);
    }];
    
    [self.QrCodeImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(18, 18));
        make.right.mas_equalTo(weakSelf.contentView).offset(-0);
        make.centerY.mas_equalTo(weakSelf.contentView);
    }];
    
    [super updateConstraints];
}

- (void)setCellModel:(DS_FindCellModel *)cellModel
{
    _cellModel = cellModel;
    if (cellModel.icon) {
        self.headIconImageView.hidden = YES;
        self.nameLabel.hidden = YES;
        self.subNameLabel.hidden = YES;
        self.QrCodeImageView.hidden = YES;
        self.titleLabel.hidden = NO;
        self.iconImageView.hidden = NO;
        self.titleLabel.text = cellModel.title;
        self.iconImageView.image = [UIImage imageNamed:cellModel.icon];
    }else {
        self.headIconImageView.hidden = NO;
        self.nameLabel.hidden = NO;
        self.subNameLabel.hidden = NO;
        self.QrCodeImageView.hidden = NO;
        self.titleLabel.hidden = YES;
        self.iconImageView.hidden = YES;
        self.nameLabel.text = @"Dscore";
        self.subNameLabel.text = [NSString stringWithFormat:@"微信号：%@",@"Fronxe"];
        self.headIconImageView.image = [UIImage imageNamed:@"icon2.jpg"];
    }
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

- (UIImageView *)headIconImageView
{
    if (!_headIconImageView) {
        _headIconImageView = [[UIImageView alloc] init];
        _headIconImageView.layer.masksToBounds = YES;
        _headIconImageView.layer.cornerRadius = 5.f;
    }
    return _headIconImageView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
    }
    return _nameLabel;
}

- (UILabel *)subNameLabel
{
    if (!_subNameLabel) {
        _subNameLabel = [[UILabel alloc] init];
    }
    return _subNameLabel;
}

- (UIImageView *)QrCodeImageView
{
    if (!_QrCodeImageView) {
        _QrCodeImageView = [[UIImageView alloc] init];
        _QrCodeImageView.image = [UIImage imageNamed:@"setting_myQR.png"];
    }
    return _QrCodeImageView;
}

@end
