//
//  DS_BaseChatRoomController.m
//  WeChat
//
//  Created by wangyang on 16/5/17.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_BaseChatRoomController.h"
#import "DS_BaseChatRoomCell.h"
#import "DS_ChatRoomManager.h"
#import "NSTimer+ScheduleTimer.h"
#import "DS_BaseChatRoomControllerManager.h"

const NSTimeInterval KtimeDuration = 0.15f;
static NSString *identifier = @"DS_BaseChatRoomCell";

@interface DS_BaseChatRoomController () {
    //当弹出键盘时，内容会向上滚动，不应该让键盘dissmiss
    BOOL _scrollViewState;
}
@end

@implementation DS_BaseChatRoomController

#pragma mark - life cricle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, CGFLOAT_MIN)];
    self.dataSourceArray = [self.roomModel.msgArray mutableCopy];
    [self.view addSubview:self.keyBoardView];
    [self updateViewsConstraintsWithState:YES];
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

- (void)updateViewsConstraintsWithState:(BOOL)state
{
    CGFloat margin = 0.f;
    if (state) {
       margin = self.keyBoardView.frame.size.height;
    }
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, margin, 0));
    }];
}

#pragma mark - public funs
- (void)scrollToRow
{
    CGPoint currentPoint = self.tableView.contentOffset;
    if (_scrollIndex >= self.dataSourceArray.count || self.tableView.contentSize.height - self.tableView.contentOffset.y <= UISCREENHEIGHT + KBoardInputBgHeight) {
        CGRect rect = [self.tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataSourceArray.count - 1 inSection:0]];
        CGFloat marginHeight = rect.origin.y + rect.size.height - UISCREENHEIGHT - self.tableView.contentOffset.y - KBoardInputBgHeight;
        if (self.tableView.contentSize.height > UISCREENHEIGHT - KBoardInputBgHeight) {
            [self.tableView setContentOffset:(CGPoint){0,currentPoint.y - marginHeight} animated:NO];
        }
        [_timer invalidate];
        _timer = nil;
        return;
    }
    DS_WeChatMsgModel *msgModel = self.dataSourceArray[_scrollIndex];
    _scrollIndex++;
    currentPoint.y += msgModel.cacheMsgSize.height;
    [self.tableView setContentOffset:currentPoint animated:NO];
}

#pragma mark - pravite funs
- (void)setTableViewInsetsWithBottomValue:(CGFloat)bottom {
    UIEdgeInsets insets = [self tableViewInsetsWithBottomValue:bottom];
    self.tableView.contentInset = insets;
    self.tableView.scrollIndicatorInsets = insets;
}

- (UIEdgeInsets)tableViewInsetsWithBottomValue:(CGFloat)bottom {
    UIEdgeInsets insets = UIEdgeInsetsZero;
    if ([self respondsToSelector:@selector(topLayoutGuide)]) {
        insets.top = self.topLayoutGuide.length;
    }
    insets.bottom = bottom;
    return insets;
}

#pragma mark - overWrite
- (void)tableViewScrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!_scrollViewState && !_timer) {
        [self.keyBoardView dismiss];
    }
}

- (void)registerTableViewCellClass
{
    [self.tableView registerClass:[DS_BaseChatRoomCell class] forCellReuseIdentifier:identifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)scrollViewToBottom
{
    _scrollViewState = YES;
    NSInteger rows = [self.tableView numberOfRowsInSection:0];
    if (self.dataSourceArray.count != 0 && rows == 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataSourceArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        });
        return;
    }
    if (rows > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:rows - 1 inSection:0]
                              atScrollPosition:UITableViewScrollPositionBottom
                                      animated:NO];
    }
    _scrollViewState = NO;
}

#pragma mark - UITableViewDataSource and UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DS_BaseChatRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.msgModel = self.dataSourceArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DS_WeChatMsgModel *msg = self.dataSourceArray[indexPath.row];
    if (msg.cacheMsgSize.height <= 0.f) {
        return [DS_ChatRoomManager calculateCellHeightWithMsg:msg];
    }
    return msg.cacheMsgSize.height;
}

#pragma mark - DS_KeyboardViewDelegate
- (void)keyBoardInputWillShow:(DS_KeyboardView *)view
{
    _scrollViewState = YES;
    [self updateViewsConstraintsWithState:NO];
    [self setTableViewInsetsWithBottomValue:self.view.frame.size.height
     - self.keyBoardView.frame.origin.y];
    [self scrollViewToBottom];
}

- (void)keyBoardInputDidShow:(DS_KeyboardView *)view
{
    _scrollViewState = NO;
}

- (void)keyBoardInputWillDismiss:(DS_KeyboardView *)view
{
    [self updateViewsConstraintsWithState:NO];
    [self setTableViewInsetsWithBottomValue:self.view.frame.size.height
   - self.keyBoardView.frame.origin.y];
}

- (void)keyBoardInputDidDismiss:(DS_KeyboardView *)view
{
}

- (void)keyBoardInputClear:(DS_KeyboardView *)view
{
    _scrollViewState = YES;
    [self updateViewsConstraintsWithState:YES];
    [self setTableViewInsetsWithBottomValue:self.view.frame.size.height
     - self.keyBoardView.frame.origin.y];
    _scrollViewState = NO;
}

- (void)keyBoardFunsItemCell:(DS_KeyboardView *)view
            currentPanelPage:(NSInteger)pagePanel
           currentPanelIndex:(NSInteger)index
{
    switch (pagePanel * 8 + index) {
        case DS_KeyboardViewFuncItemTypePhoto:
        {
            [DS_BaseChatRoomControllerManager openPhotoWithSuccess:^(NSArray *photoPictures) {
                NSLog(@"%@",photoPictures);
            }];
        }
            break;
        case DS_KeyboardViewFuncItemTypeTakePhoto:
        {
            [DS_BaseChatRoomControllerManager takePictureWithSuccess:^(UIImage *picture) {
                
            }];
        }
            break;
        case DS_KeyboardViewFuncItemTypePersonCard:
            NSLog(@"个人名片");
            break;
            
        default:
            break;
    }
}

- (void)keyBoardSendMsgTextView:(DS_KeyboardView *)view sendMsgText:(NSString *)text
{
    NSLog(@"子类重写发送数据");
}


#pragma mark - getter
- (DS_KeyboardView *)keyBoardView
{
    if (!_keyBoardView) {
        _keyBoardView = [[DS_KeyboardView alloc] init];
        _keyBoardView.delegate = self;
    }
    return _keyBoardView;
}

@end
