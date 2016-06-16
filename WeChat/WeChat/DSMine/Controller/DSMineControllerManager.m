//
//  DSMineControllerManager.m
//  WeChat
//
//  Created by wangyang on 16/5/29.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DSMineControllerManager.h"
#import "DS_FindCellModel.h"

@implementation DSMineControllerManager
+ (NSArray *)dataSources
{
    DS_FindCellModel *model = [[DS_FindCellModel alloc] init];
    NSArray *array = @[model];
    
    DS_FindCellModel *model00 = [[DS_FindCellModel alloc] init];
    model00.icon = @"MoreMyAlbum.png";
    model00.title = DS_CustomLocalizedString(@"photo", nil);
    
    DS_FindCellModel *model01 = [[DS_FindCellModel alloc] init];
    model01.icon = @"MoreMyFavorites.png";
    model01.title = DS_CustomLocalizedString(@"collect", nil);
    
    DS_FindCellModel *model02 = [[DS_FindCellModel alloc] init];
    model02.icon = @"MoreMyBankCard.png";
    model02.title = DS_CustomLocalizedString(@"wallet", nil);
    
    DS_FindCellModel *model03 = [[DS_FindCellModel alloc] init];
    model03.icon = @"MoreMyBankCard.png";
    model03.title = DS_CustomLocalizedString(@"card", nil);
    NSArray *array0 = @[model00,model01,model02,model03];
    
    DS_FindCellModel *model10 = [[DS_FindCellModel alloc] init];
    model10.icon = @"MoreExpressionShops.png";
    model10.title = DS_CustomLocalizedString(@"expression", nil);
    NSArray *array1 = @[model10];
    
    DS_FindCellModel *model20 = [[DS_FindCellModel alloc] init];
    model20.icon = @"MoreSetting.png";
    model20.title = DS_CustomLocalizedString(@"setting", nil);
    NSArray *array2 = @[model20];
    
    return @[array,array0,array1,array2];
}
@end
