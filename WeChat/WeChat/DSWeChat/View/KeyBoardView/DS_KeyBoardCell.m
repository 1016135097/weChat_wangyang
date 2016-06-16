//
//  DS_KeyBoardCell.m
//  WeChat
//
//  Created by wangyang on 16/6/13.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_KeyBoardCell.h"
#import "UIImage+DSImage.h"
#import "DS_KeyboardHeader.h"

#define KSizeWidth (UISCREENWIDTH - 30 * 5)/4

@interface DS_KeyBoardCell (){
    DS_KeyBoardCellItemView *_itemView0,*_itemView1,*_itemView2,*_itemView3,*_itemView4,*_itemView5,*_itemView6,*_itemView7;
    
    struct keyBoardCellDelegate {
        unsigned int cellDelegate : 1;
    }keyBoardCellDelegate;
}
@property (nonatomic,strong)NSMutableArray *itemArray;
@end

@implementation DS_KeyBoardCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColorFromRGB(0xf2f2f4);
        for (int i = 0; i < 8; i++) {
            DS_KeyBoardCellItemView *itemView = [[DS_KeyBoardCellItemView alloc] init];
            itemView.tag = i;
            [self.contentView addSubview:itemView];
            [self.itemArray addObject:itemView];
        }
        _itemView0 = self.itemArray[0];
        _itemView1 = self.itemArray[1];
        _itemView2 = self.itemArray[2];
        _itemView3 = self.itemArray[3];
        _itemView4 = self.itemArray[4];
        _itemView5 = self.itemArray[5];
        _itemView6 = self.itemArray[6];
        _itemView7 = self.itemArray[7];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    WEAKSELF;
    __block int i = 0;
    [self.itemArray mas_updateConstraints:^(MASConstraintMaker *make) {
        NSInteger line = i / 4;
        NSInteger row = i % 4;
        make.size.mas_equalTo(CGSizeMake(KSizeWidth, 70));
        make.left.mas_equalTo(weakSelf).offset(30+row *(KSizeWidth+30));
        make.top.mas_equalTo(weakSelf).offset(line*90);
        i++;
    }];
    [super updateConstraints];
}

#pragma mark - 赋值
- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    for (int i = 0; i < self.itemArray.count; i++) {
        DS_KeyBoardCellItemView *itemView = self.itemArray[i];
        itemView.indexPath = [NSIndexPath indexPathForItem:i inSection:_index];
        if (i < dataArray.count) {
            DS_KeyBoardCellItemModel *model = dataArray[i];
            [itemView.iconIamge setImage:[UIImage imageNamed:model.icon] forState:UIControlStateNormal];
            itemView.titleLabel.text = DS_CustomLocalizedString(model.name, nil);
        }
        if (i < dataArray.count) {
            itemView.hidden = NO;
        }else {
            itemView.hidden = YES;
        }
    }
}

#pragma mark - alloc
- (NSMutableArray *)itemArray
{
    if (!_itemArray) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

@end

@implementation DS_KeyBoardCellItemView

- (instancetype)init
{
    if (self = [super init]) {
        [self addSubview:self.iconIamge];
        [self addSubview:self.titleLabel];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    WEAKSELF;
    [self.iconIamge mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(KSizeWidth, KSizeWidth));
        make.top.mas_equalTo(weakSelf).offset(10);
        make.centerX.mas_equalTo(weakSelf);
    }];
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(weakSelf);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(weakSelf.iconIamge.mas_bottom).offset(5);
    }];
    [super updateConstraints];
}

- (void)clickButtonIndex:(UIButton *)btn
{
    [[NSNotificationCenter defaultCenter] postNotificationName:KFunsItemCellIndexPathNoti object:self.indexPath];
}

- (UIButton *)iconIamge
{
    if (!_iconIamge) {
        _iconIamge = [UIButton buttonWithType:UIButtonTypeCustom];
        [_iconIamge setBackgroundColor:UIColorFromRGB(0xffffff)];
        _iconIamge.layer.masksToBounds = YES;
        _iconIamge.layer.cornerRadius = 10.f;
        [_iconIamge setBackgroundImage:[UIImage imageWithColor:[UIColor grayColor]] forState:UIControlStateHighlighted];
        [_iconIamge addTarget:self action:@selector(clickButtonIndex:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _iconIamge;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:14.];
        _titleLabel.textColor = [UIColor grayColor];
    }
    return _titleLabel;
}

@end

@implementation DS_KeyBoardCellItemModel


@end