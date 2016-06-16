//
//  DS_SearchBarView.h
//  WeChat
//
//  Created by wangyang on 16/5/20.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,DS_searchBarVoiceState){
    DS_searchBarVoiceStateNomal = 0,
    DS_searchBarVoiceStateTop
};
@interface DS_SearchBarView : UIView
@property (nonatomic,strong)UISearchBar *searchBar;
@property (nonatomic,strong)UIImageView *voiceImageView;
- (void)updateVoiceMarginWithState:(DS_searchBarVoiceState)state;
@property (nonatomic,copy)void(^voiceClicked)(void);
@property (nonatomic,assign)DS_searchBarVoiceState searchBarState;
@end
