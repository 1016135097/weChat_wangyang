//
//  DS_FriendCricleFeedPicturesView.m
//  WeChat
//
//  Created by wangyang on 16/6/1.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_FriendCricleFeedPicturesView.h"
#import "DS_FriendCricleCellTools.h"

static const NSInteger KPictureMaxNums = 9;

@interface DS_FriendCricleFeedPicturesView (){
}
@property (nonatomic,strong)NSDictionary *pointOffSetDict;
@property (nonatomic,strong)NSMutableArray *imgArray;
@property (nonatomic,assign)CGFloat pictureWidth;
@property (nonatomic,strong)UIImageView *img0,*img1,*img2,*img3,*img4,*img5,*img6,*img7,*img8;
@end
@implementation DS_FriendCricleFeedPicturesView
- (instancetype)init;
{
    if (self = [super init]) {
        for (int i = 0; i < KPictureMaxNums; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            [self addSubview:imageView];
            [self.imgArray addObject:imageView];
        }
        self.img0 = self.imgArray[0];
        self.img1 = self.imgArray[1];
        self.img2 = self.imgArray[2];
        self.img3 = self.imgArray[3];
        self.img4 = self.imgArray[4];
        self.img5 = self.imgArray[5];
        self.img6 = self.imgArray[6];
        self.img7 = self.imgArray[7];
        self.img8 = self.imgArray[8];
    }
    return self;
}

- (void)setPictures:(NSArray *)pictures
{
    _pictures = pictures;
    NSInteger count = pictures.count;
    for (int i = 0; i < KPictureMaxNums; i++) {
        if (i >= count) {
            [self.imgArray[i] removeFromSuperview];
        }else {
            if (![self.imgArray[i] superview]) {
                [self addSubview:self.imgArray[i]];
            }
        }
    }
    switch (pictures.count) {
        case 1:
            [self layoutOnePicture];
            break;
        case 2:
        case 3:
            [self layoutThreePicture];
            break;
        case 4:
            [self layoutFourPicture];
            break;
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
            [self layoutNinePicture];
            break;
        default:
            break;
    }
}

#pragma mark - 图片布局种类
- (void)layoutOnePicture
{
    WEAKSELF;
    self.img0.image = [self.pictures firstObject];
    [self.img0 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.bottom.mas_equalTo(weakSelf);
        make.width.mas_equalTo(weakSelf.frame.size.height);
    }];
}

- (void)layoutThreePicture
{
    WEAKSELF;
    [self.pictures enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *imageView = weakSelf.imgArray[idx];
        imageView.image = [UIImage imageNamed:obj];
        [weakSelf.imgArray[idx] mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(weakSelf.pictureWidth, weakSelf.pictureWidth));
            make.top.mas_equalTo(weakSelf);
            make.left.mas_equalTo(weakSelf).offset((weakSelf.pictureWidth + KPictureMargin) * idx);
        }];
    }];
}

- (void)layoutFourPicture
{
    WEAKSELF;
    [self.pictures enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *imageView = weakSelf.imgArray[idx];
        imageView.image = [UIImage imageNamed:obj];
        [weakSelf.imgArray[idx] mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(weakSelf.pictureWidth, weakSelf.pictureWidth));
            if (idx >= 2) {
                make.top.mas_equalTo(weakSelf).mas_equalTo(weakSelf.pictureWidth + KPictureMargin);
                make.left.mas_equalTo(weakSelf).offset((weakSelf.pictureWidth + KPictureMargin) * (idx - 2));
            }else {
                make.top.mas_equalTo(weakSelf);
                make.left.mas_equalTo(weakSelf).offset((weakSelf.pictureWidth + KPictureMargin) * idx);
            }
        }];
    }];
}

- (void)layoutNinePicture
{
    WEAKSELF;
    [self.pictures enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSUInteger line = idx / 3;
        NSUInteger row = idx % 3;
        UIImageView *imageView = weakSelf.imgArray[idx];
        imageView.image = [UIImage imageNamed:obj];
        [weakSelf.imgArray[idx] mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(weakSelf.pictureWidth, weakSelf.pictureWidth));
            make.top.mas_equalTo(weakSelf).offset(line * (weakSelf.pictureWidth + KPictureMargin));
            make.left.mas_equalTo(weakSelf).offset((weakSelf.pictureWidth + KPictureMargin) * row);
        }];
    }];
}

- (NSMutableArray *)imgArray
{
    if (!_imgArray) {
        _imgArray = [NSMutableArray arrayWithCapacity:9];
    }
    return _imgArray;
}

- (CGFloat)pictureWidth
{
    return [DS_FriendCricleCellTools rssContentPictureSizeWidth];
}
@end
