//
//  DS_KeyboardView.h
//  WeChat
//
//  Created by wangyang on 16/6/10.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DS_KeyboardView;

extern const CGFloat KBoardInputBgHeight;

typedef NS_ENUM(NSInteger,DS_KeyboardViewFuncItemType) {
    DS_KeyboardViewFuncItemTypePhoto = 0,   //照片
    DS_KeyboardViewFuncItemTypeTakePhoto,   //拍摄
    DS_KeyboardViewFuncItemTypeSmallVideo,  //小视频
    DS_KeyboardViewFuncItemTypeVideoChat,   //视频聊天
    DS_KeyboardViewFuncItemTypeRedEnvelope, //红包
    DS_KeyboardViewFuncItemTypeTransfer,    //转账
    DS_KeyboardViewFuncItemTypeLocation,    //位置
    DS_KeyboardViewFuncItemTypeCollection,  //收藏
    DS_KeyboardViewFuncItemTypePersonCard,  //个人名片
    DS_KeyboardViewFuncItemTypeVoiceInput,  //语音输入
    DS_KeyboardViewFuncItemTypeWallet       //卡券
};

@protocol DS_KeyboardViewDelegate <NSObject>
@optional

- (void)keyBoardInputWillShow:(DS_KeyboardView *)view;
- (void)keyBoardInputDidShow:(DS_KeyboardView *)view;
- (void)keyBoardInputWillDismiss:(DS_KeyboardView *)view;
- (void)keyBoardInputDidDismiss:(DS_KeyboardView *)view;

/**
 * pagePanel 点击的item在当前 面板处于第几个面板
 * index     点击的item在当前 面板的位置
 */
- (void)keyBoardFunsItemCell:(DS_KeyboardView *)view currentPanelPage:(NSInteger)pagePanel currentPanelIndex:(NSInteger)index;
/**
 * 文字 send
 */
- (void)keyBoardSendMsgTextView:(DS_KeyboardView *)view sendMsgText:(NSString *)text;
//- (void)keyBoardInputClear:(DS_KeyboardView *)view;

@end

@interface DS_KeyboardView : UIView

@property (nonatomic,weak)id <DS_KeyboardViewDelegate> delegate;
@property (nonatomic,assign)DS_KeyboardViewFuncItemType itemType;
- (void)dismiss;
@end
