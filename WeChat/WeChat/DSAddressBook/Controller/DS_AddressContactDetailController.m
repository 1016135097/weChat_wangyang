//
//  DS_AddressContactDetailController.m
//  WeChat
//
//  Created by wangyang on 16/5/28.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_AddressContactDetailController.h"
#import "DS_AddressContactDetailCell.h"
#import "DS_AddressBookModel.h"
#import "DS_AddressContactDetailManager.h"
#import "DS_AddressContactDetainCellModel.h"
#import "DS_AddressChatButtonView.h"
#import "DS_SingleChatController.h"
#import "DS_ActionSheetView.h"
#import "DS_WeChatControllerManager.h"
#import "DS_SocialContactController.h"
#import "DS_FriendCricleController.h"

static NSString *identifier = @"DS_AddressContactDetailCell";
@interface DS_AddressContactDetailController ()<DS_ActionSheetViewDelegate>
@property (nonatomic,strong)DS_AddressChatButtonView *bottomView;
@end

@implementation DS_AddressContactDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = DS_CustomLocalizedString(@"deatinMeans", nil);
    self.dataSourceArray = [DS_AddressContactDetailManager cellDataSoources];
    [self blockCallBack];
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

#pragma mark - overwrite
- (UITableView *)allocTableView
{
    return [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
}

- (CGFloat)footerHeight
{
    return 0.f;
}

- (void)registerTableViewCellClass
{
    [self.tableView registerClass:[DS_AddressContactDetailCell class] forCellReuseIdentifier:identifier];
    [self.tableView setTableFooterView:self.bottomView];
}

#pragma mark - UITableViewDataSource and UItableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSourceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSourceArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DS_AddressContactDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.cellModel = self.dataSourceArray[indexPath.section][indexPath.row];
    cell.model = self.model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0 ? CGFLOAT_MIN:20.;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DS_AddressContactDetainCellModel *cellModel = self.dataSourceArray[indexPath.section][indexPath.row];
    return cellModel.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DS_AddressContactDetainCellModel *cellModel = self.dataSourceArray[indexPath.section][indexPath.row];
    if (cellModel.arrow) {
        if ([cellModel.comments isEqualToString:DS_CustomLocalizedString(@"more", nil)]) {
            DS_SocialContactController *vc = [[DS_SocialContactController alloc] init];
            vc.model = self.model;
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([cellModel.comments isEqualToString:DS_CustomLocalizedString(@"personPhoto", nil)]){
            DS_FriendCricleController *vc = [[DS_FriendCricleController alloc] init];
            vc.model = self.model;
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:cellModel.comments message:@"正在开发中，敬请期待" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
}

#pragma mark -  DS_ActionSheetViewDelegate
- (void)ActionSheetView:(DS_ActionSheetView *)actionSheetView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    DS_SingleChatController *signVC = [[DS_SingleChatController alloc] init];
    signVC.roomModel = [DS_AddressContactDetailManager creatSingChatRoomWithContactModel:self.model];
    if (buttonIndex == 0) {
        //视频聊天
        signVC.joinType = DS_ChatRoomJoinTypeVideoChat;
    }else {//语音聊天
        signVC.joinType = DS_ChatRoomJoinTypeSoundChat;
    }
    [self.navigationController pushMyViewController:signVC animated:YES index:0];
}

#pragma mark - blockCallBack
- (void)blockCallBack
{
    WEAKSELF;
    self.bottomView.sendMsgBlock = ^(){
        DS_SingleChatController *signVC = [[DS_SingleChatController alloc] init];
        signVC.roomModel = [DS_AddressContactDetailManager creatSingChatRoomWithContactModel:weakSelf.model];
        [weakSelf.navigationController pushMyViewController:signVC animated:YES index:0];
    };
    
    self.bottomView.videoChatBlock = ^(){
        DS_ActionSheetView *action = [[DS_ActionSheetView alloc] initWithTitles:@[@"视频聊天",@"语音聊天"] delegate:weakSelf cancelButtonTitle:@"取消"];
        action.backgroundColor = [UIColor redColor];
        [action showInView:weakSelf.view];
    };
}

#pragma mark - setter and getter
- (DS_AddressChatButtonView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[DS_AddressChatButtonView alloc] initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, 140)];
    }
    return _bottomView;
}

@end
