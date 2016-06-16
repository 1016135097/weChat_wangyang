//
//  DS_FindControllerManager.m
//  WeChat
//
//  Created by wangyang on 16/5/29.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_FindControllerManager.h"
#import "DS_FindCellModel.h"

@implementation DS_FindControllerManager
+ (NSArray *)dataSources
{
    DS_FindCellModel *model00 = [[DS_FindCellModel alloc] init];
    model00.icon = @"ff_IconShowAlbum.png";
    model00.title = DS_CustomLocalizedString(@"friendCricle", nil);
    NSArray *array0 = @[model00];
    
    DS_FindCellModel *model10 = [[DS_FindCellModel alloc] init];
    model10.icon = @"ff_IconQRCode.png";
    model10.title = DS_CustomLocalizedString(@"scan", nil);
    
    DS_FindCellModel *model11 = [[DS_FindCellModel alloc] init];
    model11.icon = @"ff_IconShake.png";
    model11.title = DS_CustomLocalizedString(@"shake", nil);
    
    NSArray *array1 = @[model10,model11];
    
    DS_FindCellModel *model20 = [[DS_FindCellModel alloc] init];
    model20.icon = @"ff_IconLocationService.png";
    model20.title = DS_CustomLocalizedString(@"nearbyPerson", nil);
    
    DS_FindCellModel *model21 = [[DS_FindCellModel alloc] init];
    model21.icon = @"ff_IconBottle.png";
    model21.title = DS_CustomLocalizedString(@"driftBottle", nil);
    NSArray *array2 = @[model20,model21];
    
    DS_FindCellModel *model30 = [[DS_FindCellModel alloc] init];
    model30.icon = @"CreditCard_ShoppingBag.png";
    model30.title = DS_CustomLocalizedString(@"shopping", nil);
    
    DS_FindCellModel *model31 = [[DS_FindCellModel alloc] init];
    model31.icon = @"MoreGame.png";
    model31.title = DS_CustomLocalizedString(@"game", nil);
    NSArray *array3 = @[model30,model31];
    
    return @[array0,array1,array2,array3];
}
@end
