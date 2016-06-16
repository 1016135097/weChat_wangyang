//
//  DSAddressBookManager.m
//  WeChat
//
//  Created by wangyang on 16/5/23.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DSAddressBookManager.h"
#import "DS_AddressBookModel.h"
#import "DS_AddressBookGroupModel.h"
#import "DS_AddressBookAPi.h"
#import "DS_AddressBookTool.h"

@implementation DSAddressBookManager
+ (BOOL)showAddressBook
{
    BOOL state = [[DS_AddressBookAPi defaultManager] checkAddressBookAuthorization];
    if (state) {return YES;};
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请到“设置->隐私->通讯录”中将weChat设置为允许访问通讯录！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    return NO;
}

+ (void)readAddressBookWithList:(void(^)(NSArray *listArray, NSArray *alphabetArray,NSInteger totoal))block
{
    
    DS_AddressBookGroupModel *model = [[DS_AddressBookGroupModel alloc] init];
    model.title = @"A";
    
    DS_AddressBookModel *person1 = [[DS_AddressBookModel alloc] init];
    person1.name = @"王阳";
    person1.icon = @"icon1.jpg";
    person1.number = @"18515064875";
    person1.weixinNumber = @"Descore";
    person1.userId = @"123461";
    person1.area = @"北京";
    person1.socialContact = @"你知道早晨四点的太阳吗？知道啊，那个时候我才下班啊";
    
    DS_AddressBookModel *person2 = [[DS_AddressBookModel alloc] init];
    person2.name = @"王五";
    person2.icon = @"icon2.jpg";
    person2.number = @"18515064876";
    person2.weixinNumber = @"隔壁老王";
    person2.userId = @"123462";
    person2.area = @"陕西 西安";
    person2.socialContact = @"何必以喜欢之名自我绑架！";
    model.contacts = @[person1,person2];
    
    
    DS_AddressBookGroupModel *model1 = [[DS_AddressBookGroupModel alloc] init];
    model1.title = @"L";
    
    DS_AddressBookModel *person11 = [[DS_AddressBookModel alloc] init];
    person11.name = @"李四";
    person11.icon = @"user1.png";
    person11.number = @"18515064877";
    person11.weixinNumber = @"我家住在黄土高原";
    person11.userId = @"123463";
    person11.area = @"非洲 毛里求斯";
    model1.contacts = @[person11];
    
    
    DS_AddressBookGroupModel *model2 = [[DS_AddressBookGroupModel alloc] init];
    model2.title = @"Z";
    
    DS_AddressBookModel *person21 = [[DS_AddressBookModel alloc] init];
    person21.name = @"赵六";
    person21.icon = @"user2.png";
    person21.number = @"18515064877";
    person21.weixinNumber = @"说话不说完";
    person21.area = @"美国 纽约";
    person21.userId = @"123464";
    model2.contacts = @[person21];
    NSArray *modelArray = @[model,model1,model2];
    block([DSAddressBookManager configAddressBookList:modelArray],[DSAddressBookManager configAlphabetArrayWithArray:modelArray],[DSAddressBookManager calculatePersonNumsWithArray:modelArray]);
//    [[DS_AddressBookAPi defaultManager] readAddressBookList:^(NSArray *bookList) {
//        block([DS_AddressBookTool sortArrayWithDataArray:bookList]);
//    }];
}

+ (NSArray *)configAlphabetArrayWithArray:(NSArray *)array
{
    NSMutableArray *alphabet = [NSMutableArray arrayWithCapacity:array.count + 2];
    [alphabet addObject:UITableViewIndexSearch];
    for (DS_AddressBookGroupModel *model in array) {
        [alphabet addObject:model.title];
    }
    [alphabet addObject:@"#"];
    return alphabet;
}

+ (NSArray *)configAddressBookList:(NSArray *)array
{
    NSMutableArray *dataSource = [NSMutableArray arrayWithCapacity:array.count + 4];
    DS_AddressBookModel *model1 = [[DS_AddressBookModel alloc] init];
    model1.name = DS_CustomLocalizedString(@"newFriends", nil);
    model1.type = DS_AddressBookTypeAddFriends;
    model1.icon = @"plugins_FriendNotify.png";
    
    DS_AddressBookModel *model2 = [[DS_AddressBookModel alloc] init];
    model2.name = DS_CustomLocalizedString(@"GroupChat", nil);
    model2.type = DS_AddressBookTypeGroupChat;
    model2.icon = @"add_friend_icon_addgroup.png";
    
    DS_AddressBookModel *model3 = [[DS_AddressBookModel alloc] init];
    model3.name = DS_CustomLocalizedString(@"AddressBookTag", nil);
    model3.type = DS_AddressBookTypeTag;
    model3.icon = @"Contact_icon_ContactTag.png";
    
    DS_AddressBookModel *model4 = [[DS_AddressBookModel alloc] init];
    model4.name = DS_CustomLocalizedString(@"PublicNumber", nil);
    model4.type = DS_AddressBookTypePiblicNumber;
    model4.icon = @"add_friend_icon_offical.png";
    
    DS_AddressBookGroupModel *models = [[DS_AddressBookGroupModel alloc] init];
    models.title = @"";
    models.contacts = @[model1,model2,model3,model4];
    [dataSource addObject:models];
    [dataSource addObjectsFromArray:array];
    return dataSource;
}

+ (NSInteger)calculatePersonNumsWithArray:(NSArray *)array
{
    NSInteger num = 0;
    for (DS_AddressBookGroupModel *model in array) {
        num += model.contacts.count;
    }
    return num;
}


@end
