//
//  DS_FriendCricleHeaderView.m
//  WeChat
//
//  Created by wangyang on 16/5/30.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_FriendCricleHeaderView.h"
#import "DS_UserHeader.h"
#import "UILabel+DSAdaptContent.h"
#import "DS_AddressBookModel.h"

@interface DS_FriendCricleHeaderView ()
@property (nonatomic,strong)UIImageView *headerImageView;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UIImageView *bgImageView;
@end

@implementation DS_FriendCricleHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.bgImageView];
        [self addSubview:self.headerImageView];
        [self addSubview:self.nameLabel];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    WEAKSELF;
    [self.bgImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 35, 0));
    }];
    
    [self.headerImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.right.mas_equalTo(weakSelf).offset(-15);
        make.bottom.mas_equalTo(weakSelf).offset(-10);
    }];
    
    [self.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.headerImageView.mas_left).offset(-20);
        make.bottom.mas_equalTo(weakSelf.bgImageView.mas_bottom).offset(-15);
        make.height.mas_equalTo(@15);
    }];
    [self.nameLabel setContentHuggingWithLabelContent];
    [super updateConstraints];
}

- (void)setUserModel:(DS_UserModel *)userModel
{
    _userModel = userModel;
    self.headerImageView.image = [UIImage imageNamed:userModel.icon];
    self.bgImageView.image = [UIImage imageNamed:userModel.circleBgImage];
    self.nameLabel.text = userModel.name;
}

- (void)setBookModel:(DS_AddressBookModel *)bookModel
{
    _bookModel = bookModel;
    self.headerImageView.image = [UIImage imageNamed:bookModel.icon];
    self.bgImageView.image = [UIImage imageNamed:bookModel.circleBgImage];
    self.nameLabel.text = bookModel.name;
}

- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.backgroundColor = [UIColor grayColor];
    }
    return _bgImageView;
}

- (UIImageView *)headerImageView
{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] init];
    }
    return _headerImageView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = UIColorFromRGB(0xffffff);
        _nameLabel.textAlignment = NSTextAlignmentRight;
    }
    return _nameLabel;
}
@end
