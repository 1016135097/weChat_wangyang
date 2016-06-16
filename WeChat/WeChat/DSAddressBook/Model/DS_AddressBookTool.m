//
//  DS_AddressBookTool.m
//  WeChat
//
//  Created by wangyang on 16/5/24.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_AddressBookTool.h"
#import "DS_AddressBookModel.h"
#import "DS_AddressBookGroupModel.h"
#define Alphabet @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"]
@implementation DS_AddressBookTool
+ (NSArray *)sortArrayWithDataArray:(NSArray *)dataArray
{
    NSMutableArray *sortArray = [NSMutableArray array];
    [dataArray enumerateObjectsUsingBlock:^(DS_AddressBookModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.namePrefix = [[DS_AddressBookTool indexValue:obj.name] substringToIndex:1];
    }];
    return sortArray;
}

+ (NSString *)indexValue:(NSString *)name
{
    NSString *titleStr = name;
    CFStringRef strRef = (__bridge CFStringRef)titleStr;
    CFMutableStringRef string = CFStringCreateMutableCopy(NULL, 0, strRef);
    CFRange range = CFRangeMake(0, name.length);
    CFStringTransform(string,&range, kCFStringTransformMandarinLatin, NO);
    CFStringTransform(string,&range,kCFStringTransformStripDiacritics, NO);
    NSString *strNS = (__bridge NSString *)string;
    NSString *strNS1;
    if (strNS.length > 0)
    {
        strNS1 = [strNS stringByReplacingOccurrencesOfString:@" " withString:@";"];
        NSSet *set1 = [NSSet setWithObject:[[strNS substringToIndex:1] uppercaseString]];
        NSSet *set = [NSSet setWithArray:Alphabet];
        if (![set1 isSubsetOfSet:set])//过滤非字母的字符
        {
            CFRelease(string);
            return @"#";
        }
    }
    else
    {
        strNS1 = @"#";
    }
    CFRelease(string);
    return strNS1;
}
@end
