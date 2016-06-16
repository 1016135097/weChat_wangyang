//
//  DS_BaseTableViewController.m
//  WeChat
//
//  Created by wangyang on 16/5/14.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_BaseTableViewController.h"
#import "DS_WeChatControllerManager.h"
#import "DS_WeChatViewCell.h"
#import "DS_WeChatListModel.h"

static NSString *identifier = @"UITableViewCellDS";
@interface DS_BaseTableViewController ()

@property (nonatomic,copy)tableViewCellBlock cellBlock;
@property (nonatomic,copy)tableViewCellBlock cellClickBlock;
@property (nonatomic,copy)tableViewCellBlock cellUnClickBlock;

@end

@implementation DS_BaseTableViewController

#pragma mark - life cricle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerTableViewCellClass];
    [self.view addSubview:self.tableView];
    [self registerSearchTableViewCellClass];
    self.view.backgroundColor = KBackgroundColor;
    self.tableView.backgroundColor = KBackgroundColor;
    [self updateViewTableViewConstraints];
}

- (void)registerTableViewCellClass
{
    [self.tableView registerClass:[DS_LanguageCell class] forCellReuseIdentifier:identifier];
}

- (void)registerSearchTableViewCellClass
{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)updateViewTableViewConstraints
{
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0)).priorityLow();
    }];
}

#pragma mark - UITableViewDataSource and UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DS_LanguageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    self.cellBlock(tableView,cell,indexPath,self.dataSourceArray[indexPath.row]);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellClickBlock) {
        self.cellClickBlock(tableView,nil,indexPath,self.dataSourceArray[indexPath.row]);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellUnClickBlock) {
        self.cellUnClickBlock(tableView,nil,indexPath,self.dataSourceArray[indexPath.row]);
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = self.tableView.contentOffset;
    CGRect rect = self.seachBarView.frame;
    rect.origin = CGPointMake(0, -point.y);
    self.seachBarView.frame = rect;
    [self tableViewScrollViewDidScroll:scrollView];
}

- (void)tableViewScrollViewDidScroll:(UIScrollView *)scrollView 
{}

#pragma mark - UISearchDisplayDelegate
- (void) searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller
{
    UIView *viewTop =controller.searchBar.subviews[0];
    for (UIView *searchbuttons in [viewTop subviews]){
        if ([searchbuttons isKindOfClass:UIButton.class]) {
            UIButton *cancelButton = (UIButton*)searchbuttons;
            [cancelButton setTitleColor:[UIColor colorWithRed:0 green:1.0 blue:0 alpha:1] forState:UIControlStateNormal];
            [cancelButton setTitleColor:[UIColor colorWithRed:0 green:1.0 blue:0 alpha:0.3] forState:UIControlStateHighlighted];
            [self.shadeSearchBarView removeFromSuperview];
            return;
        }
    }
}

-(void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView
{
    tableView.contentInset = UIEdgeInsetsZero;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(nullable NSString *)searchString
{
    UITableView *tableView = controller.searchResultsTableView;
    for( UIView *subview in tableView.subviews ) {
        if( [subview class] == [UILabel class] ) {
            UILabel *lbl = (UILabel*)subview;
            lbl.hidden = YES;
            return YES;
        }
    }
    return YES;
}

- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.seachBarView updateVoiceMarginWithState:DS_searchBarVoiceStateNomal];
    self.tableView.hidden = NO;
}

#pragma mark - UISearchBar
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    if (self.seachBarView.searchBarState == DS_searchBarVoiceStateNomal) {
        [self.seachBarView addSubview:self.shadeSearchBarView];
    }
    [self.seachBarView updateVoiceMarginWithState:DS_searchBarVoiceStateTop];
    self.tableView.hidden = YES;
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length > 0) {
        self.seachBarView.voiceImageView.hidden = YES;
    }else {
        self.seachBarView.voiceImageView.hidden = NO;
        [self.searchDataArray removeAllObjects];
    }
    _searchString = searchText;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.seachBarView.voiceImageView.hidden = NO;
}


#pragma mark - public funs
- (void)tableViewCellBlock:(tableViewCellBlock)block
{
    self.cellBlock = block;
}

- (void)tableViewDidClickBlock:(tableViewCellBlock)block
{
    self.cellClickBlock = block;
}

- (void)tableViewDidUnClickBlock:(tableViewCellBlock)block
{
    self.cellUnClickBlock = block;
}

#pragma mark - setter and getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [self allocTableView];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.sectionHeaderHeight = [self headerHeight];
        _tableView.sectionFooterHeight = [self footerHeight];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, 15.f)];
    }
    return _tableView;
}

- (UITableView *)allocTableView
{
    return [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
}

- (DS_SearchBarView *)seachBarView
{
    if (!_seachBarView) {
        _seachBarView = [[DS_SearchBarView alloc] initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, 49)];
        _seachBarView.searchBar.delegate = self;
    }
    return _seachBarView;
}

- (UISearchDisplayController *)searchController
{
    if (!_searchController) {
        _searchController = [[UISearchDisplayController alloc] initWithSearchBar:self.seachBarView.searchBar contentsController:self];
        _searchController.searchResultsTableView.backgroundColor = KBackgroundColor;
        _searchController.searchResultsTableView.rowHeight = 60.f;
        _searchController.delegate = self;
        _searchController.searchResultsDelegate = self;
        _searchController.searchResultsDataSource = self;
        _searchController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _searchController;
}

- (UIView *)shadeSearchBarView
{
    if (!_shadeSearchBarView) {
        _shadeSearchBarView = [[UIView alloc] initWithFrame: CGRectMake(UISCREENWIDTH - 50, 0, 50, self.seachBarView.frame.size.height)];
        _shadeSearchBarView.backgroundColor = KBackgroundColor;
    }
    return _shadeSearchBarView;
}

- (void)setCellHeight:(CGFloat)cellHeight
{
    _cellHeight = cellHeight;
    self.tableView.rowHeight = self.cellHeight;
}

- (CGFloat)headerHeight
{
    return 0.f;
}

- (CGFloat)footerHeight
{
    return 0.f;
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end

@implementation DS_LanguageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (selected) {
        self.accessoryType = UITableViewCellAccessoryCheckmark;
    }else {
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}

@end
