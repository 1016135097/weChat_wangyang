//
//  DS_ActionSheetView.m
//  WeChat
//
//  Created by wangyang on 16/5/29.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_ActionSheetView.h"
static const CGFloat KSignHeight = 60.f;
static const CGFloat KSectionMariginHeight = 8.f;
static const NSTimeInterval KanimationDurationTime = 0.3;

static NSString *identifier = @"DS_TableViewCell";
@interface DS_ActionSheetView ()<UITableViewDataSource,UITableViewDelegate> {
    CGFloat _height;
    NSString *_selectedString;
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataSources;
@property (nonatomic,strong)UIView *bgView;
@end

@implementation DS_ActionSheetView

- (instancetype)initWithTitles:(NSArray *)titleArray delegate:(id<DS_ActionSheetViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle
{
    _height = KSectionMariginHeight;
    if (titleArray) {
        _height += KSignHeight * titleArray.count;
        [self.dataSources addObject:titleArray];
    }
    if (cancelButtonTitle) {
        _height += KSignHeight;
        [self.dataSources addObject:@[cancelButtonTitle]];
    }
    self.delegate = delegate;
    if (self = [super init]) {
        self.frame = CGRectMake(0, UISCREENHEIGHT - _height, UISCREENWIDTH, _height);
        [self addSubview:self.tableView];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSources[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DS_ActionSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.titleLabel.text = self.dataSources[indexPath.section][indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0? CGFLOAT_MIN:KSectionMariginHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedString = self.dataSources[indexPath.section][indexPath.row];
    if (indexPath.section == 1) {
        if ([self.delegate respondsToSelector:@selector(ActionSheetViewCancel:)]) {
            [self.delegate ActionSheetViewCancel:self];
        }
        [self touchPopViewWithIndex:indexPath.row + [[self.dataSources firstObject] count]];
    }else if ([self.delegate respondsToSelector:@selector(ActionSheetView:clickedButtonAtIndex:)] && indexPath.section == 0) {
        [self.delegate ActionSheetView:self clickedButtonAtIndex:indexPath.row];
        [self touchPopViewWithIndex:indexPath.row];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - public Func
- (void)showInView:(UIView *)view
{
    if ([self.delegate respondsToSelector:@selector(willPresentActionSheetView:)]) {
        [self.delegate willPresentActionSheetView:self];
    }
    
    [view addSubview:self.bgView];
    [UIView animateWithDuration:KanimationDurationTime animations:^{
        [view addSubview:self];
        self.frame = CGRectMake(0, UISCREENHEIGHT - _height - 64, UISCREENWIDTH, _height);
    }completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(didPresentActionSheetView:)]) {
            [self.delegate didPresentActionSheetView:self];
        }
    }];
}

#pragma mark - pravite funs
- (void)touchPopViewTap:(UIGestureRecognizer *)ges
{
    NSInteger index = 0;
    index += [[self.dataSources firstObject] count];
    if (self.dataSources.count == 2) {
        index += [[self.dataSources lastObject] count];
    }
    [self touchPopViewWithIndex:index];
}

- (void)touchPopViewWithIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(actionSheetView:willDismissWithButtonIndex:)]) {
        [self.delegate actionSheetView:self willDismissWithButtonIndex:index];
    }
    
    [UIView animateWithDuration:KanimationDurationTime animations:^{
        self.frame = CGRectMake(0, UISCREENHEIGHT - 64, UISCREENWIDTH, _height);
    } completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
        if ([self.delegate respondsToSelector:@selector(actionSheetView:didDismissWithButtonIndex:)]) {
            [self.delegate actionSheetView:self didDismissWithButtonIndex:index];
        }
    }];
}

#pragma mark - setter and getter
- (void)setCancelButtonTextColor:(UIColor *)cancelButtonTextColor
{
    _cancelButtonTextColor = cancelButtonTextColor;
}

- (void)setOtherButtonTextColor:(UIColor *)otherButtonTextColor
{
    _otherButtonTextColor = otherButtonTextColor;
}

- (NSString *)selectedTitle
{
    return _selectedString;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.rowHeight = KSignHeight;
        [_tableView registerClass:[DS_ActionSheetCell class] forCellReuseIdentifier:identifier];
        _tableView.sectionFooterHeight = 0.f;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]){
            [_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]){
            [_tableView setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    return _tableView;
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.5];
        _bgView.frame = [UIScreen mainScreen].bounds;
        _bgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchPopViewTap:)];
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}

- (NSMutableArray *)dataSources
{
    if (!_dataSources) {
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
}
@end

@implementation DS_ActionSheetCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLabel];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    WEAKSELF;
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.contentView);
    }];
    
    [super updateConstraints];
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
@end
