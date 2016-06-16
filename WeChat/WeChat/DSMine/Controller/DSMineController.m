//
//  DSMineController.m
//  WeChat
//
//  Created by wangyang on 15/11/5.
//  Copyright © 2015年 wangyang. All rights reserved.
//

#import "DSMineController.h"
#import "DS_FindCell.h"
#import "DSMineControllerManager.h"
#import "DS_FindCellModel.h"

static NSString *identifier = @"DS_FindCell";
@interface DSMineController ()

@end

@implementation DSMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSourceArray = [DSMineControllerManager dataSources];
}

#pragma mark  - overwrite
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
    [self.tableView registerClass:[DS_FindCell class] forCellReuseIdentifier:identifier];
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
    DS_FindCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.cellModel = self.dataSourceArray[indexPath.section][indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DS_FindCellModel *model = self.dataSourceArray[indexPath.section][indexPath.row];
    if (!model.icon) {
        return 90.f;
    }
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0 ? CGFLOAT_MIN:20.;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
