//
//  DSAddressBookController.m
//  WeChat
//
//  Created by wangyang on 15/11/5.
//  Copyright © 2015年 wangyang. All rights reserved.
//

#import "DSAddressBookController.h"
#import "DS_AddressBookCell.h"
#import "DSAddressBookManager.h"
#import "DS_WeChatViewCell.h"
#import "DS_WeChatControllerManager.h"
#import "DS_WeChatListModel.h"
#import "DS_AddressBookGroupModel.h"
#import "DS_AddressBookModel.h"
#import "DS_AddressContactDetailController.h"

static NSString *identifier = @"DS_AddressBookCell";
static NSString *searchIdentifier = @"DS_WeChatViewCell";
@interface DSAddressBookController ()
@property (nonatomic,strong)NSArray *alphabetArray;
@property (nonatomic,strong)UILabel *bottomView;
@end

@implementation DSAddressBookController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (![DSAddressBookManager showAddressBook]) {
        self.tableView.hidden = YES;
        return;
    }else {
        self.tableView.hidden = NO;
    }
    [self.view addSubview:self.seachBarView];
    self.searchController.active = NO;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, UISCREENWIDTH, 49)];
    [self blockCallBack];
}

#pragma mark - overwirte
- (void)registerSearchTableViewCellClass
{
    [self.searchController.searchResultsTableView registerClass:[DS_WeChatViewCell class] forCellReuseIdentifier:searchIdentifier];
}

- (UITableView *)allocTableView
{
    return [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
}

- (void)registerTableViewCellClass
{
    [self.tableView registerClass:[DS_AddressBookCell class] forCellReuseIdentifier:identifier];
    self.tableView.sectionIndexColor = [UIColor grayColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:self.bottomView];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    self.tableView.rowHeight = 49;
}

#pragma mark - UITableViewDataSource and UItableViewDelegate
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return tableView == self.searchController.searchResultsTableView?@[]:self.alphabetArray;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSLog(@"%@-%ld",title,(long)index);
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return tableView == self.searchController.searchResultsTableView?1:self.dataSourceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableView == self.searchController.searchResultsTableView?self.searchDataArray.count:[[(DS_AddressBookGroupModel *)self.dataSourceArray[section] contacts]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchController.searchResultsTableView) {
         DS_WeChatViewCell *cell = [tableView dequeueReusableCellWithIdentifier:searchIdentifier];
        cell.model = self.searchDataArray[indexPath.row];
        return cell;
    }
    DS_AddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    DS_AddressBookGroupModel *model = self.dataSourceArray[indexPath.section];
    cell.model = model.contacts[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSString *title = [self.dataSourceArray[section] title];
    if ([title isEqualToString:@""] && tableView == self.tableView) {
        return CGFLOAT_MIN;
    }
    return tableView == self.searchDisplayController.searchResultsTableView?CGFLOAT_MIN:20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DS_AddressBookGroupModel *groupModel = self.dataSourceArray[indexPath.section];
    DS_AddressBookModel *bookModel = groupModel.contacts[indexPath.row];
    if ([groupModel.title isEqualToString:@""]) {
        switch (bookModel.type) {
            case DS_AddressBookTypeAddFriends:
                NSLog(@"新的朋友");
                break;
            case DS_AddressBookTypeGroupChat:
                NSLog(@"群聊");
                break;
            case DS_AddressBookTypeTag:
                NSLog(@"标签");
                break;
            case DS_AddressBookTypePiblicNumber:
                NSLog(@"公众号");
                break;
            default:
                break;
        }
    }else {
        DS_AddressContactDetailController *deatil = [[DS_AddressContactDetailController alloc] init];
        deatil.model = bookModel;
        [self.navigationController pushViewController:deatil animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) return [[UIView alloc] initWithFrame:CGRectZero];
    DS_AddressBookGroupModel *model = self.dataSourceArray[section];
    if ([model.title isEqualToString:@""]) {
        return [[UIView alloc] initWithFrame:CGRectZero];
    }
    UIView *view = [[UIView alloc] init];
    UILabel *label = [[UILabel alloc] init];
    view.frame = CGRectMake(0, 0, UISCREENWIDTH, 20);
    label.frame = CGRectOffset(view.frame, 15, 0);
    [view addSubview:label];
    label.text = [self.dataSourceArray[section] title];
    return view;
}

#pragma mark - block call
- (void)blockCallBack
{
    [DSAddressBookManager readAddressBookWithList:^(NSArray *listArray,NSArray *alphabetArray,NSInteger totoalNumbers) {
        self.dataSourceArray = listArray;
        self.alphabetArray = alphabetArray;
        self.bottomView.text = [NSString stringWithFormat:@"%ld位联系人",totoalNumbers];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - UISearchBarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.searchDataArray = [[DS_WeChatControllerManager searchDataSource] mutableCopy];
    DS_WeChatListModel *model = [self.searchDataArray firstObject];
    model.chatRoomName = _searchString;
    [self.searchController.searchResultsTableView reloadData];
}

#pragma mark - setter and getter
- (UILabel *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, 44)];
        _bottomView.textAlignment = NSTextAlignmentCenter;
    }
    return _bottomView;
}

@end
