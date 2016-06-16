//
//  DS_AddressBookCell.m
//  WeChat
//
//  Created by wangyang on 16/5/23.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_AddressBookCell.h"
#import "DS_AddressBookModel.h"

@interface DS_AddressBookCell ()
@property (nonatomic,strong)UIImageView *iconImageView;
@property (nonatomic,strong)UILabel *nameLabel;

@end
@implementation DS_AddressBookCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.nameLabel];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    WEAKSELF;
    [self.iconImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.size.mas_equalTo(CGSizeMake(32, 32));
        make.left.mas_equalTo(weakSelf.contentView).offset(15);
    }];
    
    [self.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.right.mas_equalTo(weakSelf.contentView);
        make.left.mas_equalTo(weakSelf.iconImageView.mas_right).offset(10);
    }];
    [super updateConstraints];
}

- (void)setModel:(DS_AddressBookModel *)model
{
    _model = model;
    self.iconImageView.image = [UIImage imageNamed:model.icon];
    self.nameLabel.text = model.name;
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
    }
    return _nameLabel;
}
@end
