//
//  DS_FriendCricleCellPraise_CommentView.m
//  WeChat
//
//  Created by wangyang on 16/6/5.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_FriendCricleCellPraise_CommentView.h"
#import "DS_FriendCricleCellTools.h"
#import "DS_FriendCricleModel.h"
#import "DS_UserHeader.h"
#import "UILabel+DSAdaptContent.h"

#define KTitleFont [UIFont systemFontOfSize:15.]

static NSString *identifier = @"DS_FriendCricleCellPraise_CommentCell";
@interface DS_FriendCricleCellPraise_CommentView ()<UITableViewDataSource,UITableViewDelegate> {
    CGFloat _selfHeight;
    
}
@property (nonatomic,strong)UIImageView *bgImageView;
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation DS_FriendCricleCellPraise_CommentView

- (instancetype)init
{
    if (self = [super init]) {
        [self addSubview:self.tableView];
        [self needsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    WEAKSELF;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
    }];
    [super updateConstraints];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DS_FriendCricleCellPraise_CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    DS_FriendCricleCommentModel *model = self.commentArray[indexPath.row];
    cell.titleLabel.attributedText = [self configMsgContentModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DS_FriendCricleCommentModel *model = self.commentArray[indexPath.row];
    return [self calculateCellHeightWitHString:[self configMsgContentModel:model].string];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.commentClicked) {
        self.commentClicked(indexPath.row,self.commentArray[indexPath.row]);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

/**
 * index 0 第一用户 1 第二用户
 */
- (void)userNameClickedWithIndex:(NSInteger)index withModel:(DS_FriendCricleCommentModel *)model
{
    
}

#pragma mark - pravite funs
- (CGFloat)calculateCellHeightWitHString:(NSString *)string
{
   CGRect rect = [string boundingRectWithSize:CGSizeMake([DS_FriendCricleCellTools rssContentFrameSizeWidth] - 20., CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:KTitleFont} context:nil];
    return ceil(rect.size.height) + 6;
}

- (NSAttributedString *)configMsgContentModel:(DS_FriendCricleCommentModel *)model
{
    DS_UserTool *userTool = [DS_UserTool shareInstance];
    NSString *str = @"";
    NSMutableAttributedString *attrString = nil;
    //别人评论自己和自己回复自己是同一种情况（@:@）
    if ([model.toUserId isEqualToString:userTool.userModel.userId] || [model.fromUserId isEqualToString:userTool.userModel.userId]) {
        str = [NSString stringWithFormat:@"%@：%@",model.fromUserName,model.comment];
        NSRange range = [str rangeOfString:model.fromUserName];
        attrString = [[NSMutableAttributedString alloc] initWithString:str];
        [attrString setAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor]} range:range];
    }else {
        //别人评论第三方和别人回复自己是同一种情况(@回复@:@)
        str = [NSString stringWithFormat:@"%@回复%@：%@",model.fromUserName,model.toUserName,model.comment];
        NSRange range = [str rangeOfString:model.fromUserName];
        NSRange range1 = [str rangeOfString:model.toUserName];
        attrString = [[NSMutableAttributedString alloc] initWithString:str];
        [attrString setAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor]} range:range];
        [attrString setAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor]} range:range1];
    }
    return attrString;
}

#pragma mark - setter and getter
- (void)setPraiseArray:(NSArray *)praiseArray
{
    _praiseArray = praiseArray;
}

- (void)setCommentArray:(NSArray *)commentArray
{
    _commentArray = commentArray;
    [self.tableView reloadData];
    _selfHeight = self.tableView.contentSize.height;
}

- (CGFloat)Praise_CommentViewHeight
{
    return _selfHeight;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundView = self.bgImageView;
        [_tableView registerClass:[DS_FriendCricleCellPraise_CommentCell class] forCellReuseIdentifier:identifier];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.scrollEnabled = NO;
        _tableView.sectionHeaderHeight = 0.f;
        _tableView.sectionFooterHeight = 0.f;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, 5.f)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        
        UIImage *img = [UIImage imageNamed:@"ff_likes_comments_background.png"];
        _bgImageView = [[UIImageView alloc] initWithImage:[img stretchableImageWithLeftCapWidth:25 topCapHeight:8]];
    }
    return _bgImageView;
}
@end

@implementation DS_FriendCricleCellPraise_CommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLabel];
        self.backgroundColor = [UIColor colorWithRed:1. green:1. blue:1. alpha:0.1];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 10, 0, 10));
    }];
    [super updateConstraints];
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = KTitleFont;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

@end
