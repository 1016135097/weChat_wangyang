//
//  DSWeChatController.m
//  WeChat
//
//  Created by wangyang on 15/11/5.
//  Copyright © 2015年 wangyang. All rights reserved.
//

#import "DSWeChatController.h"
#import "DS_ChatMessage.h"
#import "DS_WeChatControllerManager.h"
#import "DS_SingleChatController.h"
#import "DS_GroupChatController.h"
#import "DS_WeChatAddItemView.h"
#import "DS_WechatMenuModel.h"
#import "DS_WeChatViewCell.h"
#import <objc/runtime.h>

static NSString *identifier = @"DS_WeChatViewCell";

@interface DSWeChatController ()

@property (nonatomic,strong)DS_WeChatAddItemView *menuItem;
@property (nonatomic,strong)UIView *shadeView;

@end

@implementation DSWeChatController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cellHeight = 60.f;
    [self.view addSubview:self.seachBarView];
    self.searchController.active = NO;
    self.dataSourceArray = [DS_WeChatControllerManager dataSource];
    [self.shadeView addSubview:self.menuItem];
    [self.view addSubview:self.shadeView];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, UISCREENWIDTH, 49)];
    [self initWithTabBar];
    [self blockCallBack];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!self.menuItem.hidden) {
        self.shadeView.hidden = YES;
    }
}

#pragma mark - pushOtherController
- (void)pushSingleControllerWithModel:(DS_WeChatListModel *)model
{
    DS_BaseChatRoomController *chatRoom = [[DS_SingleChatController alloc] init];
    chatRoom.roomModel = model;
    [self.navigationController pushViewController:chatRoom animated:YES];
}

- (void)pushGroupChatControllerWithModel:(DS_WeChatListModel *)model
{
    DS_BaseChatRoomController *chatRoom = [[DS_GroupChatController alloc] init];
    chatRoom.roomModel = model;
    [self.navigationController pushViewController:chatRoom animated:YES];
}

#pragma mark - UITableView
- (void)registerTableViewCellClass
{
    [self.tableView registerClass:[DS_WeChatViewCell class] forCellReuseIdentifier:identifier];
}

- (void)registerSearchTableViewCellClass
{
    [self.searchController.searchResultsTableView registerClass:[DS_WeChatViewCell class] forCellReuseIdentifier:identifier];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableView == self.tableView?self.dataSourceArray.count:self.searchDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DS_WeChatViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (self.tableView == tableView) {
        cell.model = self.dataSourceArray[indexPath.row];
    }else {
        cell.model = self.searchDataArray[indexPath.row];
    }
    return cell;
}

#pragma mark - iOS8 系统实现 iOS8系统以下需要自己实现
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView == self.tableView?YES:NO;
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *edtionRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"标为未读" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    
    edtionRowAction.backgroundColor = UIColorFromRGB(0xf2f2f4);
    UITableViewRowAction *deletedRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
    }];
    deletedRowAction.backgroundColor = UIColorFromRGB(0xff0000);
    return @[deletedRowAction,edtionRowAction];
}
#pragma mark - end

#pragma mark - UISearchBarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.searchDataArray = [[DS_WeChatControllerManager searchDataSource] mutableCopy];
    DS_WeChatListModel *model = [self.searchDataArray firstObject];
    model.chatRoomName = _searchString;
    [self.searchController.searchResultsTableView reloadData];
}

#pragma mark - pravite funs
- (void)initWithTabBar
{
    self.navigationItem.rightBarButtonItem = [UINavigationItem rightBarButtonItemWithTarget:self action:@selector(rightItemAction) normalImage:nil highLightImage:nil];
}

- (void)rightItemAction
{
    self.shadeView.hidden = !self.shadeView.hidden;
}

- (void)menuCreateGroupChat
{
    NSLog(@"%s",__func__);
}

- (void)menuAddFriends
{
    NSLog(@"%s",__func__);
}

- (void)menuScan
{
    NSLog(@"%s",__func__);
}

- (void)menuPay
{
    NSLog(@"%s",__func__);
}

#pragma mark - BlockCallBack
- (void)blockCallBack
{
    WEAKSELF;
    [self tableViewDidClickBlock:^(UITableView *tableView,UITableViewCell *cell, NSIndexPath *indexPath, DS_WeChatListModel *model) {
        if (tableView == self.tableView) {
            switch (model.chatRoomType) {
                case DS_ChatTypeAlone:
                    [weakSelf pushSingleControllerWithModel:model];
                    break;
                case DS_ChatTypeRoom:
                    [weakSelf pushGroupChatControllerWithModel:model];
                default:
                    break;
            }
        }else {
            NSLog(@"search cell clicked");
        }
    }];
    
    [self tableViewCellBlock:^(UITableView *tableView,UITableViewCell *cell, NSIndexPath *indexPath, id model) {
        NSLog(@"search tableView call");
    }];
    
    self.seachBarView.voiceClicked = ^{
        NSLog(@"clicked voice");
    };
    
    self.menuItem.menuItemClicked = ^(NSInteger index,DS_WechatMenuModel *model){
        NSLog(@"menu clicked");
        switch (index) {
            case DS_WeChatAddItemTypeNewMessage:
                [weakSelf menuCreateGroupChat];
                break;
            case DS_WeChatAddItemTypeAddCube:
                [weakSelf menuAddFriends];
                break;
            case DS_WeChatAddItemTypeScan:
                [weakSelf menuScan];
                break;
            case DS_WeChatAddItemTypePay:
                [weakSelf menuPay];
                break;
            default:
                break;
        }
    };
}

#pragma mark - setter and getter
- (DS_WeChatAddItemView *)menuItem
{
    if (!_menuItem) {
        NSArray *arr = [DS_WeChatControllerManager menuDataSource];
        _menuItem = [[DS_WeChatAddItemView alloc] initWithMenu:[DS_WeChatControllerManager menuDataSource]];
        CGFloat w = 150;
        CGFloat x = UISCREENWIDTH - w - 5;
        CGFloat h = arr.count * 40 + 9;
        CGFloat y = 5;
        _menuItem.frame = CGRectMake(x, y, w, h);
    }
    return _menuItem;
}

- (UIView *)shadeView
{
    if (!_shadeView) {
        _shadeView = [[UIView alloc] initWithFrame:self.view.bounds];
        _shadeView.userInteractionEnabled = YES;
        _shadeView.hidden = YES;
    }
    return _shadeView;
}
@end
