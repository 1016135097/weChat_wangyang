//
//  DS_LanguageController.m
//  WeChat
//
//  Created by wangyang on 16/5/14.
//  Copyright © 2016年 wangyang. All rights reserved.
//  目前只支持简体中文、繁体中文（香港、台湾）三种国际化

#import "DS_LanguageController.h"
#import "DS_CurrentSystemTool.h"

@interface DS_LanguageController () {
    NSDictionary *_languageDict;
}
@property (nonatomic,strong)UINavigationBar *navigationBar;
@property (nonatomic,copy)NSString *selectedLanguageType;
@property (nonatomic,strong)UILabel *rightItemLabel;
@end

@implementation DS_LanguageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.navigationBar];
    [self obtainData];
    [self setNavigationBarItem];
    _selectedLanguageType = [DS_CurrentSystemTool readCurrentAppLanguage];
    [self tableViewCellBlock:^(UITableView *tableView,UITableViewCell *cell, NSIndexPath *indexPath, NSString *model) {
        cell.textLabel.text = model;
    }];
    __block NSDictionary *dict = _languageDict;
    WEAKSELF;
    [self tableViewDidClickBlock:^(UITableView *tableView,UITableViewCell *cell, NSIndexPath *indexPath, NSString *model) {
        weakSelf.selectedLanguageType = dict[model];
        if ([[DS_CurrentSystemTool readCurrentAppLanguage] isEqualToString:weakSelf.selectedLanguageType]) {
            weakSelf.rightItemLabel.textColor = UIColorFromRGB(0x3f6847);
        }else {
            weakSelf.rightItemLabel.textColor = [UIColor greenColor];
        }
    }];
    
    NSString *currentKey = [DS_CurrentSystemTool currentSetLanguageKey];
    NSInteger index = [self.dataSourceArray indexOfObject:currentKey];
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (void)obtainData
{
    _languageDict = [DS_CurrentSystemTool appAllLanguages];
    self.dataSourceArray = [[_languageDict allKeys] mutableCopy];
}

- (void)setNavigationBarItem
{
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 80, 44);
    label.textAlignment = NSTextAlignmentLeft;
    label.text = DS_CustomLocalizedString(@"cancel",nil);
    label.textColor = [UIColor whiteColor];
    label.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftItemAction)];
    [label addGestureRecognizer:tap];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:label];
    // 45 76 47
    UILabel *rightlabel = [[UILabel alloc] init];
    rightlabel.textColor = UIColorFromRGB(0x3f6847);
    self.rightItemLabel = rightlabel;
    rightlabel.frame = CGRectMake(0, 0, 80, 44);
    rightlabel.textAlignment = NSTextAlignmentRight;
    rightlabel.text = DS_CustomLocalizedString(@"save",nil);
    rightlabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *righttap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightItemAction)];
    [rightlabel addGestureRecognizer:righttap];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightlabel];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.frame = CGRectMake(0, 0, 100, 44);
    titleLabel.text = DS_CustomLocalizedString(@"languageTitle", nil);
    UINavigationItem *navigationBarTitle = [[UINavigationItem alloc] init];
    navigationBarTitle.titleView = titleLabel;
    navigationBarTitle.leftBarButtonItem = leftItem;
    navigationBarTitle.rightBarButtonItem = rightItem;
    [self.navigationBar setItems:[NSArray arrayWithObject: navigationBarTitle]];
}

- (void)leftItemAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightItemAction
{
    if ([_selectedLanguageType isEqualToString:[DS_CurrentSystemTool readCurrentAppLanguage]]) {
        return;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    [DS_CurrentSystemTool saveSetLanguage:_selectedLanguageType];
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    WEAKSELF;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.and.left.and.bottom.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.view.mas_top).offset(64);
    }];
}

- (UINavigationBar *)navigationBar
{
    if (!_navigationBar) {
        _navigationBar = [[UINavigationBar alloc] init];
        _navigationBar.frame = CGRectMake(0, 0, UISCREENWIDTH, 64);
    }
    return _navigationBar;
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
