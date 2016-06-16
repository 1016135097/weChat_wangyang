//
//  DS_AddressBookAPi.m
//  WeChat
//
//  Created by wangyang on 16/5/23.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_AddressBookAPi.h"
#import <AddressBook/AddressBook.h>
#import "DS_AddressBookModel.h"

@interface DS_AddressBookAPi ()

@property (nonatomic,assign)ABAddressBookRef addressBookRef;
@property (nonatomic,assign)CFArrayRef people;

@end

@implementation DS_AddressBookAPi

+ (instancetype)defaultManager
{
    static DS_AddressBookAPi *addressBook = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        addressBook = [[DS_AddressBookAPi alloc] init];
    });
    return addressBook;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
        self.people = ABAddressBookCopyArrayOfAllPeople(self.addressBookRef);
        ABAddressBookRequestAccessWithCompletion(self.addressBookRef, ^(bool greanted, CFErrorRef error){
        });
        ABAddressBookRegisterExternalChangeCallback(self.addressBookRef, addressBookChanged,(__bridge void *)self);
    }
    return self;
}

- (BOOL)checkAddressBookAuthorization
{
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied)
    {
        return NO;
    }
    return YES;
}

void addressBookChanged(ABAddressBookRef addressBook, CFDictionaryRef info, void* context)
{
    if (context)
    {
        
    }
}

- (NSString *)getFullNameByRecordId:(CFIndex)recordId
{
    ABRecordRef person = CFArrayGetValueAtIndex(self.people, recordId);
    NSString *firstName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
    NSString *midName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonMiddleNameProperty));
    NSString *lastName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));
    if(firstName == nil) { firstName = @""; }
    if(midName == nil) { midName = @""; }
    if(lastName == nil) {lastName = @""; }
    return [NSString stringWithFormat:@"%@%@",lastName,firstName];
}

- (NSString *)getNumberByRecordId:(CFIndex)recordId
{
    ABRecordRef person = CFArrayGetValueAtIndex(self.people, recordId);
     ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
//    for (int k = 0; k<ABMultiValueGetCount(phone); k++)
//    {
//        NSString * personPhoneName = CFBridgingRelease (ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phone, k)));
//        //获取該Label下的电话值
//        NSString * personPhone = CFBridgingRelease(ABMultiValueCopyValueAtIndex(phone, k));
//    }
//    NSString * personPhoneName = CFBridgingRelease (ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phone, k)));
    //获取該Label下的电话值
    NSMutableString * personPhone = [CFBridgingRelease(ABMultiValueCopyValueAtIndex(phone, 0)) mutableCopy];
    return [personPhone stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

- (NSString *)getNamePhoneticProperty:(CFIndex)recordId
{
    ABRecordRef person = CFArrayGetValueAtIndex(self.people, recordId);
    NSString *naemHasPrefix = CFBridgingRelease(ABRecordCopyValue(person, kABPersonMiddleNamePhoneticProperty));
    
    //读取organization公司
    return naemHasPrefix;
}

- (void)readAddressBookList:(void (^)(NSArray *))block
{
    CFIndex numberOfPeople = ABAddressBookGetPersonCount(self.addressBookRef);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSMutableArray *listArray = [NSMutableArray array];
        for (int i = 0; i < numberOfPeople; i++) {
            DS_AddressBookModel *model = [[DS_AddressBookModel alloc] init];
            model.name = [self getFullNameByRecordId:i];
            model.number = [self getNumberByRecordId:i];
            model.namePrefix = [self getNamePhoneticProperty:i];
            [listArray addObject:model];
        }
        block(listArray);
    });
}

- (void)dealloc
{
    if (self.addressBookRef)
    {
        ABAddressBookUnregisterExternalChangeCallback(self.addressBookRef, addressBookChanged, (__bridge void *)self);
        CFRelease(self.addressBookRef);
    }
}

@end
