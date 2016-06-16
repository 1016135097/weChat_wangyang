//
//  DS_KeyboardView.m
//  WeChat
//
//  Created by wangyang on 16/6/10.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_KeyboardView.h"
#import "DS_KeyBoardEmjView.h"
#import "DS_KeyBoardFunsView.h"
#import "DS_KeyboardHeader.h"

//功能键宽度/高度
const CGFloat KBoardVoiceWidth = 35.f;
//功能面板高度
const CGFloat KFunsPanelHeight = 210.f;
//上面功能键高度
const CGFloat KBoardInputBgHeight = 49.f;
//输入框文字偏差调整
const CGFloat KInputTextViewMargin = 15.5f;
//输入框文字最多显示的行数
const NSInteger KInputTextViewMaxNumbers = 5;

typedef NS_ENUM(NSInteger,KBoardFunsType) {
    KBoardFunsTypeNone,
    KBoardFunsTypeEmj,
    KBoardFunsTypeFuns
};

@interface DS_KeyboardView ()<UITextViewDelegate> {
    //键盘高度
    CGFloat _keyboardHeight;
    //键盘弹出动画
    CGFloat _keyboardAnimationDuration;
    //键盘弹出动画轨迹时间轴
    UIViewAnimationCurve _keyboardAnimationCurve;
    //是否处于发送语音中
    BOOL _voiceState;
    struct KeyBoardDelegate {
        unsigned int KeyBoardWillShow : 1;
        unsigned int keyBoardDidShow  : 1;
        unsigned int keyBoardWillDismiss : 1;
        unsigned int keyBoardDidDismiss  : 1;
        unsigned int keyBoardItemCellClick : 1;
        unsigned int keyBoardSendMsg  : 1;
//        unsigned int keyBoradInputClear : 1;
    }KeyBoardDelegate;
    
    //记录inputView文字行数
    NSInteger _recordTextNums;
    //记录inputView文字偏差状态
    BOOL _recordTextMarginState;
    //记录inputView行数是增加还是减少
    BOOL _recordTextLengthChangeState;
    //当输入文字超过一行时，DS_KeyboardView高度发生变化，在退回到下面时需要更新
    CGFloat _recordInputTextHeight;
    
}

@property (nonatomic,strong)UIView *funcBackGroudView;
@property (nonatomic,strong)UITextView *inputView;
@property (nonatomic,strong)UIButton *voiceButton;
@property (nonatomic,strong)UIButton *emjButton;
@property (nonatomic,strong)UIButton *addButton;
@property (nonatomic,strong)UIButton *pressButton;
//emj 视图
@property (nonatomic,strong)DS_KeyBoardEmjView *emjView;
// 功能 视图
@property (nonatomic,strong)DS_KeyBoardFunsView *funsView;
//emj/功能 切换 当前处于哪个视图
@property (nonatomic,assign)KBoardFunsType funsType;

@end

@implementation DS_KeyboardView

- (instancetype)init
{
    if (self = [super init]) {
        _recordInputTextHeight = KBoardInputBgHeight;
        self.frame = CGRectMake(0, UISCREENHEIGHT - _recordInputTextHeight - 64, UISCREENWIDTH, _recordInputTextHeight);
        [self addSubview:self.funcBackGroudView];
        [self.funcBackGroudView addSubview:self.inputView];
        [self.funcBackGroudView addSubview:self.voiceButton];
        [self.funcBackGroudView addSubview:self.emjButton];
        [self.funcBackGroudView addSubview:self.addButton];
        _recordTextNums = 1;
        [self noticeKeyBoardFrame];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%s",__func__);
}

- (void)updateConstraints
{
    WEAKSELF;
    [self.funcBackGroudView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.and.top.and.left.mas_equalTo(weakSelf);
        make.height.mas_equalTo(_recordInputTextHeight).priorityLow();
    }];
    
    [self.voiceButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(KBoardVoiceWidth, KBoardVoiceWidth));
        make.left.mas_equalTo(weakSelf.funcBackGroudView);
        make.bottom.mas_equalTo(weakSelf.funcBackGroudView.mas_bottom).offset(-7);
    }];
    
    [self.addButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(KBoardVoiceWidth, KBoardVoiceWidth));
        make.right.mas_equalTo(weakSelf.funcBackGroudView.mas_right);
        make.top.mas_equalTo(weakSelf.voiceButton);
    }];
    
    [self.emjButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(KBoardVoiceWidth, KBoardVoiceWidth));
        make.right.mas_equalTo(weakSelf.addButton.mas_left).offset(-5);
        make.top.mas_equalTo(weakSelf.voiceButton);
    }];
    
    [self.inputView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.voiceButton.mas_right).offset(5);
        make.top.mas_equalTo(weakSelf.funcBackGroudView.mas_top).offset(7);
        make.bottom.mas_equalTo(weakSelf.funcBackGroudView.mas_bottom).offset(-7);
        make.right.mas_equalTo(weakSelf.emjButton.mas_left).offset(-5);
    }];
    [super updateConstraints];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    _voiceState = YES;
}

- (CGFloat)calculateInputTextViewHeightWithText:(NSString *)text
{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(self.inputView.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.]} context:nil];
    return ceil(rect.size.height / self.inputView.font.lineHeight);
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        if (KeyBoardDelegate.keyBoardSendMsg) {
            [self.delegate keyBoardSendMsgTextView:self sendMsgText:textView.text];
        }
        textView.text = @"";
        __block CGRect rect = self.frame;
        //需要重新修改funcBackGroudView的高度和自身的高度
        rect.origin.y = UISCREENHEIGHT - 64 - KBoardInputBgHeight - _keyboardHeight;
        //重置记录行数
        _recordTextNums = 1;
        _recordTextMarginState = NO;
        self.frame = rect;
        _recordInputTextHeight = KBoardInputBgHeight;
        if (rect.size.height != KBoardInputBgHeight) {
            rect.size.height = _recordInputTextHeight;
            WEAKSELF;
            [self.funcBackGroudView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.and.top.and.left.mas_equalTo(weakSelf);
                make.height.mas_equalTo(_recordInputTextHeight);
            }];
        }
        if (KeyBoardDelegate.KeyBoardWillShow) {
            [self.delegate keyBoardInputWillShow:self];
        }
//        if (KeyBoardDelegate.keyBoradInputClear) {
//            [self.delegate keyBoardInputClear:self];
//        }
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger row = [self calculateInputTextViewHeightWithText:textView.text];
    CGRect rect = self.frame;
    if (row > KInputTextViewMaxNumbers) {
//        textView.scrollEnabled = YES;
        return;
    }
    //必须更新动画transform基准值，否则在输入超过2行时，滑动页面输入框 CGAffineTransformIdentity失效
    if (row != _recordTextNums) {
        [self showSources:YES];
        if (_recordTextNums < row) {
            //行数增加
            _recordTextLengthChangeState = YES;
        }else {
            //行数减少
            _recordTextLengthChangeState = NO;
        }
        _recordTextNums = row;
        if(!_recordTextMarginState){
            _recordTextMarginState = YES;
            rect.origin.y += KInputTextViewMargin;
            rect.size.height -= KInputTextViewMargin;
        }
        if(_recordTextLengthChangeState){
            rect.origin.y -= self.inputView.font.lineHeight;
            rect.size.height += self.inputView.font.lineHeight;
        }else {
            rect.origin.y += self.inputView.font.lineHeight;
            rect.size.height -= self.inputView.font.lineHeight;
        }
        //记录funcBackGroudView 真实高度
        _recordInputTextHeight = KBoardInputBgHeight + self.inputView.font.lineHeight * (row - 1) - KInputTextViewMargin;
        self.frame = rect;
        if (KeyBoardDelegate.KeyBoardWillShow) {
            [self.delegate keyBoardInputWillShow:self];
        }
        WEAKSELF;
        [self.funcBackGroudView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.and.top.and.left.mas_equalTo(weakSelf);
            make.height.mas_equalTo(_recordInputTextHeight);
        }];
        [textView scrollRangeToVisible:NSRangeFromString(textView.text)];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    NSLog(@"%@",textView.text);
}

#pragma mark - keyBoard Frame change notice
- (void)noticeKeyBoardFrame
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(funcPanelEvent:) name:KFunsItemCellIndexPathNoti object:nil];
}

#pragma mark - keyBoardObserver Funs
- (void)keyboardWillShow:(NSNotification *)noti
{
    BOOL state = [self keyFrameWithNoti:noti];
    //在键盘弹出的时候回多次接受到通知的frame变化信息，过滤掉第一次消除键盘和功能键切换中变化过程
    if (!state) {
        return;
    }
    [self show];
}

- (void)keyboardDidShow:(NSNotification *)noti
{
}

- (void)keyboardWillHide:(NSNotification *)noti
{
    [self keyFrameWithNoti:noti];
}

- (void)keyboardDidHide:(NSNotification *)noti
{
}

- (void)funcPanelEvent:(NSNotification *)noti
{
    if (KeyBoardDelegate.keyBoardItemCellClick) {
        NSIndexPath *indexPath = noti.object;
        [self.delegate keyBoardFunsItemCell:self currentPanelPage:indexPath.section currentPanelIndex:indexPath.row];
    }
}

#pragma mark - public funs
- (BOOL)keyFrameWithNoti:(NSNotification *)noti
{
    NSNumber *duration = [[noti userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    if (duration!=nil && [duration isKindOfClass:[NSNumber class]])
        _keyboardAnimationDuration = [duration floatValue];
    duration = [[noti userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    if (duration!=nil && [duration isKindOfClass:[NSNumber class]])
        _keyboardAnimationCurve = [duration integerValue];
    NSValue *value = [[noti userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    if ([value isKindOfClass:[NSValue class]])
    {
        CGRect rect = [value CGRectValue];
        _keyboardHeight = rect.size.height;
    }
    if (_keyboardHeight == 0) {
        return NO;
    }
    return YES;
}

- (void)show
{
    [self showSources:YES];
}

/**
 * 视图出现 sources: YES 文字出现  NO 表情+功能按钮出现
 */
- (void)showSources:(BOOL)sources
{
    CGRect rect = self.frame;
    CGFloat height = _keyboardHeight;
    if (sources) {
        rect.size.height = _recordInputTextHeight + _keyboardHeight;
    }else {
        rect.size.height = _recordInputTextHeight + KFunsPanelHeight;
        height = KFunsPanelHeight;
    }
//    if (_recordTextNums > 1) {
//        //需要重置inputView在多行显示的高度
//        rect.origin.y = UISCREENHEIGHT - _recordInputTextHeight - 64;
//        WEAKSELF;
//        [self.funcBackGroudView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.right.and.top.and.left.mas_equalTo(weakSelf);
//            make.height.mas_equalTo(_recordInputTextHeight);
//        }];
//    }
    
    self.frame = rect;
    UIViewAnimationOptions opt = animationOptionsWithCurve(_keyboardAnimationCurve);
    if (_keyboardAnimationDuration == 0) {
        _keyboardAnimationDuration = 0.25;
    }
    [UIView animateWithDuration:_keyboardAnimationDuration delay:0 options:opt animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -height);
        if (KeyBoardDelegate.KeyBoardWillShow) {
            [self.delegate keyBoardInputWillShow:self];
        }
        
    } completion:^(BOOL finished) {
        if (KeyBoardDelegate.keyBoardDidShow) {
            [self.delegate keyBoardInputDidShow:self];
        }
        if (sources) {
            if ([self.emjView superview] || [self.funsView superview]) {
                [self keyBoardFunsPanelDismiss];
            }
        }
        if ([self.pressButton superview] && self.frame.size.height != _recordInputTextHeight) {
            [self.pressButton removeFromSuperview];
            [self.voiceButton setImage:[UIImage imageNamed:@"ToolViewInputVoice.png"] forState:UIControlStateNormal];
        }
    }];
}

- (void)dismiss
{
    if ([self.inputView isFirstResponder]) {
        [self.inputView resignFirstResponder];
    }
    UIViewAnimationOptions opt = animationOptionsWithCurve(_keyboardAnimationCurve);
    [UIView animateWithDuration:_keyboardAnimationDuration delay:0 options:opt animations:^{
        self.transform = CGAffineTransformIdentity;
        if (KeyBoardDelegate.keyBoardWillDismiss) {
            [self.delegate keyBoardInputWillDismiss:self];
        }
    } completion:^(BOOL finished) {
        if (KeyBoardDelegate.keyBoardDidDismiss) {
            [self.delegate keyBoardInputDidDismiss:self];
        }
        CGRect rect = self.frame;
        if (_recordTextNums > 1) {
//            //需要重置pressButton按钮的高度为原始高度
//            rect.size.height = KBoardInputBgHeight;
//            rect.origin.y = UISCREENHEIGHT - KBoardInputBgHeight - 64;
//            WEAKSELF;
//            [self.funcBackGroudView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.right.and.top.and.left.mas_equalTo(weakSelf);
//                make.height.mas_equalTo(KBoardInputBgHeight);
//            }];
        }else {
            rect.size.height = _recordInputTextHeight;
        }
        self.frame = rect;
        if (self.funsType == KBoardFunsTypeEmj && [self.emjView superview]) {
            [self.emjView removeFromSuperview];
        }
        if(self.funsType == KBoardFunsTypeFuns && [self.funsView superview]){
            [self.funsView removeFromSuperview];
        }
    }];
}

/**
 * emj/funs emj/功能面板出现动画
 */
- (void)keyBoardFunsPanelShow
{
    if (self.funsType == KBoardFunsTypeEmj) {
        [self addSubview:self.emjView];
        self.emjView.frame = CGRectMake(0, _recordInputTextHeight, UISCREENWIDTH, KFunsPanelHeight);
    }
    if(self.funsType == KBoardFunsTypeFuns){
        [self addSubview:self.funsView];
        self.funsView.frame = CGRectMake(0, _recordInputTextHeight, UISCREENWIDTH, KFunsPanelHeight);
    }
    
    [self showSources:NO];
}

/**
 * emj/funs emj/功能面板消失动画
 */
- (void)keyBoardFunsPanelDismiss
{
    UIViewAnimationOptions opt = animationOptionsWithCurve(_keyboardAnimationCurve);
    [UIView animateWithDuration:_keyboardAnimationDuration delay:0.01 options:opt animations:^{
        if (self.funsType == KBoardFunsTypeEmj) {
            self.emjView.frame = CGRectMake(0, self.frame.size.height, UISCREENWIDTH, KFunsPanelHeight);
        }
        if (self.funsType == KBoardFunsTypeFuns){
            self.funsView.frame = CGRectMake(0, self.frame.size.height, UISCREENWIDTH, KFunsPanelHeight);
        }
    } completion:^(BOOL finished) {
        if (self.funsType == KBoardFunsTypeEmj && [self.emjView superview]) {
            [self.emjView removeFromSuperview];
        }
        if (self.funsType == KBoardFunsTypeFuns && [self.funsView superview]){
            [self.funsView removeFromSuperview];
        }
    }];
}

#pragma mark - pravite funs
static inline UIViewAnimationOptions animationOptionsWithCurve(UIViewAnimationCurve curve)
{
    UIViewAnimationOptions opt = (UIViewAnimationOptions)curve;
    return opt << 16;
}

- (void)voiceAction:(UIButton *)btn
{
    if ([btn.currentImage isEqual:[UIImage imageNamed:@"ToolViewInputVoice.png"]]) {
        WEAKSELF;
        [self.voiceButton setImage:[UIImage imageNamed:@"ToolViewKeyboard.png"] forState:UIControlStateNormal];
        [self addSubview:self.pressButton];
        [self.pressButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.inputView);
        }];
        if (_voiceState) {
            [self.inputView resignFirstResponder];
            [self dismiss];
        }
        _voiceState = YES;
    }else {
        [self.inputView becomeFirstResponder];
        [self.pressButton removeFromSuperview];
        [self.voiceButton setImage:[UIImage imageNamed:@"ToolViewInputVoice.png"] forState:UIControlStateNormal];
    }
}

- (void)emjAction:(UIButton *)btn
{
    if ([self.funsView superview]) {
        //不涉及到键盘切换，不需要模拟键盘弹出的过程
//        UIViewAnimationOptions opt = animationOptionsWithCurve(_keyboardAnimationCurve);
        [UIView animateWithDuration:_keyboardAnimationDuration animations:^{
            self.funsView.frame = CGRectMake(0, self.frame.size.height, UISCREENWIDTH, KFunsPanelHeight);
        } completion:^(BOOL finished) {
            [self.funsView removeFromSuperview];
            [self emjViewShow];
        }];
    }else {
        [self emjViewShow];
    }
}

- (void)emjViewShow
{
    self.funsType = KBoardFunsTypeEmj;
    //切换到表情键
    if (![self.emjView superview]) {
        [self.inputView endEditing:YES];
        [self keyBoardFunsPanelShow];
    }else {
        [self.inputView becomeFirstResponder];
    }
}

- (void)addAction:(UIButton *)btn
{
    if ([self.emjView superview]) {
        //不涉及到键盘切换，不需要模拟键盘弹出的过程
        [UIView animateWithDuration:_keyboardAnimationDuration animations:^{
            self.emjView.frame = CGRectMake(0, self.frame.size.height, UISCREENWIDTH, KFunsPanelHeight);
        } completion:^(BOOL finished) {
            [self.emjView removeFromSuperview];
            [self funsViewShow];
        }];
    }else{
        [self funsViewShow];
    }
}

- (void)funsViewShow
{
    //切换到功能键
    self.funsType = KBoardFunsTypeFuns;
    if (![self.funsView superview]) {
        [self.inputView endEditing:YES];
        [self keyBoardFunsPanelShow];
    }else {
        [self.inputView becomeFirstResponder];
    }
}

- (void)pressButton:(UIButton *)btn
{
}

#pragma mark - setter 赋值
 - (void)setDelegate:(id<DS_KeyboardViewDelegate>)delegate
{
    _delegate = delegate;
    KeyBoardDelegate.KeyBoardWillShow = [_delegate respondsToSelector:@selector(keyBoardInputWillShow:)];
    KeyBoardDelegate.keyBoardDidShow = [_delegate respondsToSelector:@selector(keyBoardInputDidShow:)];
    KeyBoardDelegate.keyBoardWillDismiss = [_delegate respondsToSelector:@selector(keyBoardInputWillDismiss:)];
    KeyBoardDelegate.keyBoardDidDismiss = [_delegate respondsToSelector:@selector(keyBoardInputDidDismiss:)];
    KeyBoardDelegate.keyBoardItemCellClick = [_delegate respondsToSelector:@selector(keyBoardFunsItemCell:currentPanelPage:currentPanelIndex:)];
    KeyBoardDelegate.keyBoardSendMsg = [_delegate respondsToSelector:@selector(keyBoardSendMsgTextView:sendMsgText:)];
//    KeyBoardDelegate.keyBoradInputClear = [_delegate respondsToSelector:@selector(keyBoardInputClear:)];
}

#pragma mark - getter
- (UIView *)funcBackGroudView
{
    if (!_funcBackGroudView) {
        _funcBackGroudView = [[UIView alloc] init];
        _funcBackGroudView.backgroundColor = UIColorFromRGB(0xf4f4f6);
    }
    return _funcBackGroudView;
}

- (UITextView *)inputView
{
    if (!_inputView) {
        _inputView = [[UITextView alloc] init];
        _inputView.layer.masksToBounds = YES;
        _inputView.layer.cornerRadius = 3.;
        _inputView.delegate = self;
        _inputView.font = [UIFont systemFontOfSize:16.];
        _inputView.returnKeyType = UIReturnKeySend;
        _inputView.enablesReturnKeyAutomatically = YES;
        _inputView.layoutManager.allowsNonContiguousLayout = NO;
        _inputView.textAlignment = NSTextAlignmentNatural;
//        _inputView.alwaysBounceVertical = YES;
//        _inputView.bounces = NO;
    }
    return _inputView;
}

- (UIButton *)voiceButton
{
    if (!_voiceButton) {
        _voiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_voiceButton setImage:[UIImage imageNamed:@"ToolViewInputVoice.png"] forState:UIControlStateNormal];
        [_voiceButton addTarget:self action:@selector(voiceAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _voiceButton;
}

- (UIButton *)emjButton
{
    if (!_emjButton) {
        _emjButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_emjButton setImage:[UIImage imageNamed:@"ToolViewEmotion.png"] forState:UIControlStateNormal];
        [_emjButton setImage:[UIImage imageNamed:@"ToolViewEmotionHL.png"] forState:UIControlStateHighlighted];
        [_emjButton addTarget:self action:@selector(emjAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _emjButton;
}

- (UIButton *)addButton
{
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setImage:[UIImage imageNamed:@"ToolViewMedia.png"] forState:UIControlStateNormal];
        [_addButton setImage:[UIImage imageNamed:@"ToolViewMediaHL.png"] forState:UIControlStateHighlighted];
        [_addButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

- (UIButton *)pressButton
{
    if (!_pressButton) {
        _pressButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pressButton addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
        [_pressButton setTitle:DS_CustomLocalizedString(@"pressVocie", nil) forState:UIControlStateNormal];
        [_pressButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_pressButton setBackgroundColor:UIColorFromRGB(0xf4f4f6)];
        [_pressButton.layer setMasksToBounds:YES];
        [_pressButton.layer setCornerRadius:3.0];
        [_pressButton.layer setBorderWidth:1.0];
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 221/255.,221/255. ,221/255., 1 });
        [_pressButton.layer setBorderColor:colorref];
    }
    return _pressButton;
}

- (DS_KeyBoardEmjView *)emjView
{
    if (!_emjView) {
        _emjView = [[DS_KeyBoardEmjView alloc] init];
    }
    return _emjView;
}

- (DS_KeyBoardFunsView *)funsView
{
    if (!_funsView) {
        _funsView = [[DS_KeyBoardFunsView alloc] init];
    }
    return _funsView;
}

@end
