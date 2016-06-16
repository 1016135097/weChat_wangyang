//
//  DS_FriendCricleRssView.m
//  WeChat
//
//  Created by wangyang on 16/6/2.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_FriendCricleRssView.h"
#import "DS_FriendCricleFeedPicturesView.h"
#import "UILabel+DSAdaptContent.h"

@interface DS_FriendCricleRssView () {
    DSFriendCircleFeedType _type;
}
@property (nonatomic,strong)DS_FriendCricleFeedPicturesView *picturesView;
@property (nonatomic,strong)UIImageView *signImageView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *subTitleLabel;

@end

@implementation DS_FriendCricleRssView

- (instancetype)initWithFeedType:(DSFriendCircleFeedType)type
{
    if (self = [super init]) {
        _type = type;
        switch (type) {
            case DSFriendCircleFeedTypePicture:
                [self installationPicture];
                break;
            case DSFriendCircleFeedTypeSignNew:
                [self installationSignNew];
                break;
            case DSFriendCircleFeedTypeTwoNew:
                [self installationTwoNew];
                break;
            default:
                break;
        }
    }
    return self;
}

#pragma mark - 图片
- (void)installationPicture
{
    self.backgroundColor = UIColorFromRGB(0xffffff);
    [self addSubview:self.picturesView];
    WEAKSELF;
    [self.picturesView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
    }];
}

#pragma mark - 新闻
- (void)installationSignNew
{
    self.backgroundColor = UIColorFromRGB(0xf2f2f4);
    [self addSubview:self.signImageView];
    self.titleLabel.numberOfLines = 2;
    [self addSubview:self.titleLabel];
    WEAKSELF;
    [self.signImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.mas_equalTo(weakSelf).offset(5);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(50);
    }];
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.signImageView.mas_right).offset(5);
        make.top.mas_equalTo(weakSelf.signImageView.mas_top).offset(3);
        make.right.mas_lessThanOrEqualTo(weakSelf).offset(-5);
        make.bottom.mas_equalTo(weakSelf.signImageView.mas_bottom).offset(-3);
    }];
}

- (void)installationTwoNew
{
    self.backgroundColor = UIColorFromRGB(0xf2f2f4);
    [self addSubview:self.signImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.subTitleLabel];
    self.titleLabel.numberOfLines = 1;
    WEAKSELF;
    [self.signImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.mas_equalTo(weakSelf).offset(5);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(50);
    }];
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.signImageView.mas_right).offset(5);
        make.top.mas_equalTo(weakSelf.signImageView).offset(3);
        make.right.mas_lessThanOrEqualTo(weakSelf).offset(-5);
    }];
    [self.titleLabel setContentHuggingWithLabelContent];
    
    [self.subTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.signImageView.mas_right).offset(5);
        make.bottom.mas_equalTo(weakSelf.signImageView).offset(-3);
        make.right.mas_lessThanOrEqualTo(weakSelf).offset(-5);
    }];
    [self.titleLabel setContentHuggingWithLabelContent];
}

#pragma mark - setter and getter
- (void)setFeedModel:(DS_FriendCricleFeedModel *)feedModel
{
    _feedModel = feedModel;
    switch (_type) {
        case DSFriendCircleFeedTypePicture:
            self.picturesView.pictures = feedModel.pictures;
            break;
        case DSFriendCircleFeedTypeSignNew:
        {
            self.signImageView.image = [UIImage imageNamed:feedModel.signPicture];
            self.titleLabel.text = feedModel.title;
        }
            break;
        case DSFriendCircleFeedTypeTwoNew:
        {
            self.signImageView.image = [UIImage imageNamed:feedModel.signPicture];
            self.titleLabel.text = feedModel.title;
            self.subTitleLabel.text = feedModel.subTitle;
        }
            break;
        default:
            break;
    }
}

- (DS_FriendCricleFeedPicturesView *)picturesView
{
    if (!_picturesView) {
        _picturesView = [[DS_FriendCricleFeedPicturesView alloc] init];
    }
    return _picturesView;
}

- (UIImageView *)signImageView
{
    if (!_signImageView) {
        _signImageView = [[UIImageView alloc] init];
    }
    return _signImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel
{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.textColor = [UIColor grayColor];
        _subTitleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _subTitleLabel;
}

@end
