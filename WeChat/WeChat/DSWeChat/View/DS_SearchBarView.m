//
//  DS_SearchBarView.m
//  WeChat
//
//  Created by wangyang on 16/5/20.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_SearchBarView.h"

@interface DS_SearchBarView ()
@end

@implementation DS_SearchBarView

@synthesize searchBarState;

- (instancetype)init
{
    if (self = [super init]) {
        
        [self addSubview:self.searchBar];
        [self addSubview:self.voiceImageView];
        self.backgroundColor = KBackgroundColor;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.searchBar];
        [self addSubview:self.voiceImageView];
        self.backgroundColor = KBackgroundColor;
    }
    return self;
}

- (void)updateConstraints
{
    WEAKSELF;
    [weakSelf.searchBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
    }];
    
    [weakSelf.voiceImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(22, 22));
        make.right.mas_equalTo(weakSelf).offset(-10);
    }];
    [super updateConstraints];
}

- (void)updateVoiceMarginWithState:(DS_searchBarVoiceState)state
{
    WEAKSELF;
    self.searchBarState = state;
    [weakSelf.voiceImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(22, 22));
        make.right.mas_equalTo(weakSelf).offset(state==0?-10:-52);
    }];
}

- (void)voiceImageTouch
{
    if (self.voiceClicked) {
        self.voiceClicked();
    }
}

- (UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        float version = [[[UIDevice currentDevice] systemVersion] floatValue];
        if ([_searchBar respondsToSelector:@selector(barTintColor)]){
            float  iosversion7_1 = 7.1 ;
            if (version >= iosversion7_1){
                //iOS7.1
                [[[[_searchBar.subviews firstObject] subviews] firstObject] removeFromSuperview];
                UIView *view = [[UIView alloc] init];
                view.frame = CGRectMake(0, -22, UISCREENWIDTH, 64);
                view.backgroundColor = KBackgroundColor;
                [_searchBar insertSubview:view atIndex:0];
                [_searchBar setBackgroundColor:KBackgroundColor];
            }else{
                //iOS7.0
                [_searchBar setBarTintColor:[UIColor clearColor]];
                [_searchBar setBackgroundColor:KBackgroundColor];
            }
        }else{
            //iOS7.0 以下
            [[ _searchBar.subviews firstObject] removeFromSuperview];
            [ _searchBar setBackgroundColor :KBackgroundColor];
        }
        _searchBar.searchBarStyle = UISearchBarStyleDefault;
        _searchBar.placeholder = DS_CustomLocalizedString(@"search", nil);
        _searchBar.translucent  = YES;
//        _searchBar.keyboardType = UIKeyboardTypeDefault;
    }
    return _searchBar;
}

- (UIImageView *)voiceImageView
{
    if (!_voiceImageView) {
        _voiceImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"VoiceSearchStartBtn.png"] highlightedImage:[UIImage imageNamed:@"VoiceSearchStartBtnHL.png"]];
        _voiceImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(voiceImageTouch)];
        [_voiceImageView addGestureRecognizer:tap];
    }
    return _voiceImageView;
}
@end
