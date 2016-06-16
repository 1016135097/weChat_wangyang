//
//  DS_WeChatAddItemView.m
//  WeChat
//
//  Created by wangyang on 16/5/22.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_WeChatAddItemView.h"
#import "DS_WechatMenuModel.h"

static NSString *identifier = @"DS_WeChatMenuCell";
@interface DS_WeChatAddItemView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UIImageView *bgImgaeView;
@property (nonatomic,strong)NSArray *menuArray;
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation DS_WeChatAddItemView
- (instancetype)initWithMenu:(NSArray *)menu
{
    if (self = [super init]) {
        [self addSubview:self.bgImgaeView];
        [self addSubview:self.tableView];
        self.userInteractionEnabled = YES;
        self.menuArray = menu;
    }
    return self;
}

- (void)updateConstraints
{
    WEAKSELF;
    [self.bgImgaeView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf).offset(7);
    }];
    [super updateConstraints];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DS_WeChatMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.model = self.menuArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.menuItemClicked) {
        self.menuItemClicked(indexPath.row,self.menuArray[indexPath.row]);
    }
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_tableView registerClass:[DS_WeChatMenuCell class] forCellReuseIdentifier:identifier];
        _tableView.scrollEnabled = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 40.5f;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.sectionHeaderHeight = 0.f;
        _tableView.sectionFooterHeight = 0.f;
        _tableView.separatorInset = UIEdgeInsetsMake(40.5, 15, 0, 15);
        _tableView.separatorColor = [UIColor colorWithRed:0.468 green:0.519 blue:0.549 alpha:0.900];
    }
    return _tableView;
}

- (UIImageView *)bgImgaeView
{
    if (!_bgImgaeView) {
        _bgImgaeView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"MoreFunction_icon.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(30, 10, 30, 50) resizingMode:UIImageResizingModeStretch]];
        _bgImgaeView.userInteractionEnabled = YES;
    }
    return _bgImgaeView;
}
@end

@interface DS_WeChatMenuCell()
@property (nonatomic,strong)UIImageView *iconImageView;
@property (nonatomic,strong)UILabel *titleLabel;

@end
@implementation DS_WeChatMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.titleLabel];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    WEAKSELF;
    [self.iconImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.left.mas_equalTo(weakSelf.contentView).offset(20);
    }];
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.and.top.and.bottom.mas_equalTo(weakSelf.contentView);
        make.left.mas_equalTo(weakSelf.iconImageView.mas_right).offset(15);
    }];
    [super updateConstraints];
}

- (void)setModel:(DS_WechatMenuModel *)model
{
    _model = model;
    self.iconImageView.image = [UIImage imageNamed:model.icon];
    self.titleLabel.text = DS_CustomLocalizedString(model.title, nil);
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

@end
