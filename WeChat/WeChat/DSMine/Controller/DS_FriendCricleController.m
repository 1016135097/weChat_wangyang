//
//  DS_FriendCricleController.m
//  WeChat
//
//  Created by wangyang on 16/5/29.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_FriendCricleController.h"
#import "DS_AddressBookModel.h"
#import "DS_FriendCricleCell.h"
#import "DS_FriendCricleHeaderView.h"
#import "DS_UserHeader.h"
#import "DS_FriendCricleControllerManager.h"
#import "DS_FriendCricleTool.h"
#import "DS_FriendCricleModel.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "DS_FriendCriclePraiseAndCommentView.h"

static NSString *identifier = @"DS_FriendCricleCell";
//@protocol DS_FriendCricleCellPraise_CommentProtocol;
@interface DS_FriendCricleController ()<DS_FriendCricleCellDelegate>
@property (nonatomic,strong)DS_FriendCricleHeaderView *headerView;
@property (nonatomic,strong)UIView *bgBottomView;
@property (nonatomic,strong)DS_FriendCriclePraiseAndCommentView *commentView;
@end

@implementation DS_FriendCricleController

#pragma mark - life cricle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationItem];
    [self obtainData];
    [self.view insertSubview:self.headerView belowSubview:self.tableView];
    [self.view insertSubview:self.bgBottomView belowSubview:self.headerView];
    [self tableViewConfigParams];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

#pragma mark - pravite funs
- (void)setNavigationItem
{
    if (self.model) {
        self.title = self.model.name;
        self.headerView.bookModel = self.model;
    }else {
        self.title = DS_CustomLocalizedString(@"friendCricle", nil);
        DS_UserTool *tool = [DS_UserTool shareInstance];
        self.headerView.userModel = tool.userModel;
    }
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)tableViewConfigParams
{
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, ceil(UISCREENHEIGHT * 0.3))];
    self.tableView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1];
}

- (void)obtainData
{
    WEAKSELF;
    DS_FriendCricleControllerManager *manager = [DS_FriendCricleControllerManager shareInstance];
    
    [manager dataSourceWithBlock:^(NSArray *dataArray) {
        weakSelf.dataSourceArray = dataArray;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    }];
    
    [manager requestWebData];
}

#pragma mark  - overwrite
- (UITableView *)allocTableView
{
    return [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
}

- (CGFloat)headerHeight
{
    return 0.f;
}

- (CGFloat)footerHeight
{
    return 0.f;
}

- (void)registerTableViewCellClass
{
    NSArray *cellIdentifiers = [[DS_FriendCricleTool cellIdentifier] allKeys];
    [cellIdentifiers enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.tableView registerClass:[DS_FriendCricleCell class] forCellReuseIdentifier:obj];
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DS_FriendCricleModel *model = self.dataSourceArray[indexPath.row];
    DS_FriendCricleCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIndentifier(model.feedType)];
    cell.delegate = self;
    cell.model = model;
    cell.indexPath = indexPath;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DS_FriendCricleModel *model = self.dataSourceArray[indexPath.row];
    return [tableView fd_heightForCellWithIdentifier:KCellIndentifier(model.feedType) cacheByIndexPath:indexPath configuration:^(DS_FriendCricleCell *cell) {
        cell.model = model;
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = self.tableView.contentOffset;
    //Drag and drop down
    if (point.y < 0) {
        CGRect bgRect = self.bgBottomView.frame;
        bgRect.origin.y = ceil(UISCREENHEIGHT * 0.3) - point.y;
        self.bgBottomView.frame = bgRect;
    }else if(self.bgBottomView.frame.origin.y > 10){
        self.bgBottomView.frame = CGRectMake(0, 0, UISCREENWIDTH, UISCREENHEIGHT);
    }
    //header scoroll follow tableview
    CGRect rect = self.headerView.frame;
    rect.origin = CGPointMake(0, -point.y - ceil(UISCREENHEIGHT * 0.3) + 70);
    self.headerView.frame = rect;
}

#pragma mark - cellDelegate
- (void)DS_FriendCricleCellClickedTitleOpen:(DS_FriendCricleCell *)cell
                            withCricleModel:(DS_FriendCricleModel *)model
{
    [self.tableView reloadData];
}

- (void)DS_FriendCricleCellClickedPraiseAndCommentOpen:(DS_FriendCricleCell *)cell withModel:(DS_FriendCricleModel *)model withCilckedIndexPath:(NSIndexPath *)indexPath
{
    CGRect rect  = [self.tableView rectForRowAtIndexPath:indexPath];
    NSLog(@"点击了%ldcell,cell的位置frame：%@",indexPath.row,NSStringFromCGRect(rect));
}

void praiseAndCommentCilcked(int index, bool praiseState) {
    
};

- (void)friednCricleCellClickedComment:(DS_FriendCricleCell *)cell
                         withCellIndex:(NSInteger)cellIndex
                      withCommentIndex:(NSInteger)commentIndex
                           withComment:(DS_FriendCricleCommentModel *)comment
{
    
}

#pragma mark - setter and getter
- (DS_FriendCricleHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[DS_FriendCricleHeaderView alloc] initWithFrame:CGRectMake(0, -ceil(UISCREENHEIGHT * 0.2) + 1, UISCREENWIDTH, ceil(UISCREENHEIGHT * 0.5))];
    }
    return _headerView;
}

- (UIView *)bgBottomView
{
    if (!_bgBottomView) {
        _bgBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, UISCREENWIDTH, UISCREENHEIGHT)];
    }
    _bgBottomView.backgroundColor = [UIColor whiteColor];
    return _bgBottomView;
}

- (DS_FriendCriclePraiseAndCommentView *)commentView
{
    if (!_commentView) {
        _commentView = [[DS_FriendCriclePraiseAndCommentView alloc] init];
        _commentView.cilckedAcion = ^(NSInteger index,BOOL praiseState){
            praiseAndCommentCilcked((int)index, praiseState);
        };
    }
    return _commentView;
}

@end
