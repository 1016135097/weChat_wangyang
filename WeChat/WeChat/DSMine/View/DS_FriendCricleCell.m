//
//  DS_FriendCricleCell.m
//  WeChat
//
//  Created by wangyang on 16/5/30.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_FriendCricleCell.h"
#import "DS_FriendCricleModel.h"
#import "UILabel+DSAdaptContent.h"
#import "DS_FriendCricleCellTools.h"
#import "UIImage+DSImage.h"
#import "DS_FriendCricleRssView.h"
#import "DS_FriendCricleCellPraise_CommentView.h"

#define KDescTextFont [UIFont systemFontOfSize:16.]

static const NSInteger KDescTextMaxRows = 5;

@interface DS_FriendCricleCell () {
    CGFloat _picturesHeight;
    CGFloat _praise_commentHeight;
    struct {
        unsigned int cellDesOpenState : 1;
        unsigned int cellPraiseAndCommentOpenState:1;
        unsigned int cellCommentClick : 1;
    }cellDelegate;
}

@property (nonatomic,strong)UIView *bottomLineView;
@property (nonatomic,strong)UIImageView *headerImageView;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *desLabel;
@property (nonatomic,strong)UIButton *showDesButton;
@property (nonatomic,strong)DS_FriendCricleRssView *rssView;
@property (nonatomic,strong)UILabel *timestampLabel;
@property (nonatomic,strong)UIImageView *praiseImageView;
@property (nonatomic,strong)DS_FriendCricleCellPraise_CommentView *pra_CommentView;
@end

@implementation DS_FriendCricleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.bottomLineView];
        [self.contentView addSubview:self.headerImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.desLabel];
        [self.contentView addSubview:self.showDesButton];
        self.rssView = ({
            DS_FriendCricleRssView *view = [[DS_FriendCricleRssView alloc] initWithFeedType:KCellFeedType(reuseIdentifier)];
            [self.contentView addSubview:view];
            view;
        });
        [self.contentView addSubview:self.timestampLabel];
        [self.contentView addSubview:self.praiseImageView];
        [self.contentView addSubview:self.pra_CommentView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)constraint
{
    WEAKSELF;
    [self.headerImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(KHeaderIconSizeWidth, KHeaderIconSizeWidth));
        make.left.mas_equalTo(weakSelf.contentView).offset(KLeftMargin);
        make.top.mas_equalTo(weakSelf.contentView).offset(KLeftMargin);
    }];
    
    [self.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.headerImageView.mas_right).offset(KPictureMargin);
        make.top.mas_equalTo(weakSelf.headerImageView.mas_top).offset(5);
        make.width.mas_lessThanOrEqualTo(KDescTextMaxWidth);
    }];
    
    [self.desLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.nameLabel.mas_left);
        make.top.mas_equalTo(weakSelf.nameLabel.mas_bottom).offset(KPictureMargin);
        make.width.mas_lessThanOrEqualTo(KDescTextMaxWidth);
    }];
    [self.desLabel setContentHuggingWithLabelContent];
    
    if (!self.showDesButton.hidden) {
        [self.showDesButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(45, 20));
            make.left.mas_equalTo(weakSelf.desLabel.mas_left);
            make.top.mas_equalTo(weakSelf.desLabel.mas_bottom).offset(3);
        }];
    }
    
    [self.rssView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.nameLabel.mas_left);
        if (!weakSelf.model.dec) {
            make.top.mas_equalTo(weakSelf.nameLabel.mas_bottom).offset(5);
        }else if(!weakSelf.showDesButton.hidden){
            make.top.mas_equalTo(weakSelf.showDesButton.mas_bottom).offset(5);
        }else{
            make.top.mas_equalTo(weakSelf.desLabel.mas_bottom).offset(5);
        }
        make.width.mas_equalTo(KDescTextMaxWidth);
        make.height.equalTo(@(_picturesHeight)).priorityLow();
    }];
    
    [self.timestampLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.nameLabel.mas_left);
        make.top.mas_equalTo(weakSelf.rssView.mas_bottom).offset(5);
        make.width.mas_equalTo(KDescTextMaxWidth);
        make.height.mas_equalTo(16);
    }];
    
    [self.praiseImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.right.mas_equalTo(weakSelf.contentView).offset(-KLeftMargin);
        make.centerY.mas_equalTo(weakSelf.timestampLabel);
    }];
    
    if (!self.pra_CommentView.hidden) {
        [self.pra_CommentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.timestampLabel.mas_bottom).offset(5);
            make.left.mas_equalTo(weakSelf.nameLabel.mas_left);
            make.width.mas_equalTo(KDescTextMaxWidth);
            make.height.mas_equalTo(_praise_commentHeight).priorityLow();
        }];
    }
    
    [self.bottomLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.and.left.mas_equalTo(weakSelf.contentView);
        if (self.pra_CommentView.hidden) {
            make.top.mas_equalTo(weakSelf.timestampLabel.mas_bottom).offset(10);
        }else {
             make.top.mas_equalTo(weakSelf.pra_CommentView.mas_bottom).offset(10);
        }
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(weakSelf.contentView);
    }];
}

- (void)setModel:(DS_FriendCricleModel *)model
{
    _model = model;
    self.headerImageView.image = [UIImage imageNamed:model.headIcon];
    self.nameLabel.text = model.name;
    self.desLabel.text = model.dec;
    NSInteger rows = [self.desLabel calculateLabelNumberOfRowsWithText:model.dec withFont:KDescTextFont withMaxWidth:KDescTextMaxWidth];
    if (rows > KDescTextMaxRows) {
        if (model.open) {
            self.desLabel.numberOfLines = 0;
            [self.showDesButton setTitle:@"收起" forState:UIControlStateNormal];
        }else {
            self.desLabel.numberOfLines = KDescTextMaxRows;
            [self.showDesButton setTitle:@"全文" forState:UIControlStateNormal];
        }
        self.showDesButton.hidden = NO;
    }else {
        self.showDesButton.hidden = YES;
    }
    if (model.feedType != DSFriendCircleFeedTypePicture) {
        _picturesHeight = [DS_FriendCricleCellTools calculatePictureHeightWithFeedType:model.feedType];
    }else{
        _picturesHeight = [DS_FriendCricleCellTools calculatePictureHeightWithPictures:model.feedModel.pictures];
    }
    
    self.rssView.feedModel = model.feedModel;
    self.timestampLabel.text = model.timeStamp;
    
    if (model.praises.count == 0 && model.comments.count == 0) {
        self.pra_CommentView.hidden = YES;
    }else {
        self.pra_CommentView.hidden = NO;
        self.pra_CommentView.praiseArray = model.praises;
        self.pra_CommentView.commentArray = model.comments;
        _praise_commentHeight = self.pra_CommentView.Praise_CommentViewHeight;
    }
    [self constraint];
}

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
}

#pragma mark - clicked
- (void)clickedBtn:(UIButton *)btn
{
    if ([btn.titleLabel.text isEqualToString:@"全文"]) {
        self.model.open = YES;
    }else {
        self.model.open = NO;
    }
    if (cellDelegate.cellDesOpenState) {
        [self.delegate DS_FriendCricleCellClickedTitleOpen:self withCricleModel:self.model];
    }
}

- (void)praiseAndCommentAction
{
    if (cellDelegate.cellPraiseAndCommentOpenState) {
        [self.delegate DS_FriendCricleCellClickedPraiseAndCommentOpen:self withModel:self.model withCilckedIndexPath:self.indexPath];
    }
}

- (void)cilckedCommentWithIndex:(NSInteger)index withComment:(DS_FriendCricleCommentModel *)comment
{
    if (cellDelegate.cellCommentClick) {
        [self.delegate friednCricleCellClickedComment:self withCellIndex:self.indexPath.row withCommentIndex:index withComment:comment];
    }
}

#pragma mark - end
- (void)setDelegate:(id<DS_FriendCricleCellDelegate>)delegate
{
    _delegate = delegate;
    cellDelegate.cellDesOpenState = [delegate respondsToSelector:@selector(DS_FriendCricleCellClickedTitleOpen:withCricleModel:)];
    cellDelegate.cellPraiseAndCommentOpenState = [delegate respondsToSelector:@selector(DS_FriendCricleCellClickedPraiseAndCommentOpen:withModel:withCilckedIndexPath:)];
    cellDelegate.cellCommentClick = [delegate respondsToSelector:@selector(friednCricleCellClickedComment:withCellIndex:withCommentIndex:withComment:)];
}

- (UIView *)bottomLineView
{
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    }
    return _bottomLineView;
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
    }
    return _nameLabel;
}

- (UILabel *)desLabel
{
    if (!_desLabel) {
        _desLabel = [[UILabel alloc] init];
        _desLabel.numberOfLines = 0;
        _desLabel.font = KDescTextFont;
    }
    return _desLabel;
}

- (UIButton *)showDesButton
{
    if (!_showDesButton) {
        _showDesButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_showDesButton addTarget:self action:@selector(clickedBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_showDesButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_showDesButton setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [_showDesButton setBackgroundImage:[UIImage imageWithColor:[UIColor grayColor]] forState:UIControlStateHighlighted];
        _showDesButton.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    }
    return _showDesButton;
}

- (UILabel *)timestampLabel
{
    if (!_timestampLabel) {
        _timestampLabel = [[UILabel alloc] init];
        _timestampLabel.textColor = [UIColor grayColor];
    }
    return _timestampLabel;
}
- (UIImageView *)praiseImageView
{
    if (!_praiseImageView) {
        _praiseImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AlbumOperateMoreHL.png"]];
        _praiseImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(praiseAndCommentAction)];
        [_praiseImageView addGestureRecognizer:tap];
    }
    return _praiseImageView;
}

- (DS_FriendCricleCellPraise_CommentView *)pra_CommentView
{
    if (!_pra_CommentView) {
        _pra_CommentView = [[DS_FriendCricleCellPraise_CommentView alloc] init];
        _pra_CommentView.hidden = YES;
        WEAKSELF;
        _pra_CommentView.commentClicked = ^(NSInteger index,DS_FriendCricleCommentModel *comment){
            [weakSelf cilckedCommentWithIndex:index withComment:comment];
        };
    }
    return _pra_CommentView;
}
@end
