//
//  WYLabel.m
//  TextKitDemo
//
//  Created by wangyang on 15/9/23.
//  Copyright (c) 2015年 wangyang. All rights reserved.
//

#import "WYLabel.h"

@interface WYLabel ()<NSLayoutManagerDelegate> {
    
    NSMutableDictionary *_linkStyleAttributes;
    UIColor *_linkColor;
    NSDictionary *_linkBackGourdColorDict;
    //标记点击link下标
    NSUInteger _index;
    //需要处理的字符串内容
    NSAttributedString *_attributeString;
    
}

@property (nonatomic,strong)NSTextStorage *textStorage;
@property (nonatomic,strong)NSLayoutManager *layoutManager;
@property (nonatomic,strong)NSTextContainer *textContainer;
@property (nonatomic,strong)NSArray *webArray;
@property (nonatomic,strong)NSArray *phoneArray;
@property (nonatomic,strong)NSMutableArray *selectedClickArray;
//自定义文本链接数组
@property (nonatomic,strong)NSArray *userLinkArray;

//link  array
@property (nonatomic,strong)NSArray *linkArray;
@end

@implementation WYLabel
- (instancetype)init
{
    if (self = [super init]) {
        [self setConetntAttribute];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setConetntAttribute];
    }
    return self;
}

- (void)setConetntAttribute
{
    //textContainer
    _textContainer = [[NSTextContainer alloc] init];
    _textContainer.lineFragmentPadding = 0;
    _textContainer.lineBreakMode = self.lineBreakMode;
    _textContainer.maximumNumberOfLines = 0;
    _textContainer.size = self.frame.size;
    
    //layoutManager
    _layoutManager = [[NSLayoutManager alloc] init];
    [_layoutManager addTextContainer:_textContainer];
    [_textContainer setLayoutManager:_layoutManager];
    _layoutManager.delegate = self;
    
    self.userInteractionEnabled = YES;
    _automaticLinkClicked = YES;
    _linkBackGroudColor = YES;
    _labelLinkStyle = WYLabelLinkStyleWeb;
    _linkColor = [UIColor blueColor];
    _allTextLink = NO;
    _linkUnderLine = YES;
    _linkTextWidth = 0;
    _selectedLinkBackGroudColor = [UIColor grayColor];
    
    _linkStyleAttributes = [NSMutableDictionary dictionary];
    
    [self updataTextWithCurrentText];
}


- (void)updataTextWithCurrentText
{
    if (self.attributedText) {
        [self updataTextStorageWithAttributedString:(NSMutableAttributedString *)self.attributedText];
    }else if (self.text) {
        [self updataTextStorageWithAttributedString:[[NSMutableAttributedString alloc] initWithString:self.text attributes:[self attributesFromProperties]]];
    }else {
        [self updataTextStorageWithAttributedString:[[NSMutableAttributedString alloc] initWithString:@"" attributes:[self attributesFromProperties]]];
    }
    [self setNeedsDisplay];
}

/**
 *  处理内容
 *
 *  @param attributedString 需要处理的NSAttributedString
 */
- (void)updataTextStorageWithAttributedString:(NSMutableAttributedString *)attributedString
{
    _attributeString = attributedString;
    if (attributedString.length != 0) {//美化
        attributedString = [WYLabel processAttributedString:attributedString];
    }
    
    //处理link
    if (attributedString.length != 0) {
//        WYRegularExpressionManager *manager = [[WYRegularExpressionManager alloc] init];
        self.linkArray = [self regularExpressionManagerWithStr:attributedString.string];
        attributedString = [self replaceAttributeLinkToOldAttributedString:attributedString withLinkArray:self.linkArray];
    }else {
        self.linkArray = nil;
    }
    
    if (_textStorage) {
        [_textStorage setAttributedString:attributedString];
    }else {
        _textStorage = [[NSTextStorage alloc] initWithAttributedString:attributedString];
        [_textStorage addLayoutManager:_layoutManager];
        [_layoutManager setTextStorage:_textStorage];
    }
}

/**
 *  set NSAttributedString 属性
 *
 *  @param attributedString Attribute
 *  @param linkArray        link array
 *
 *  @return Attribute include link
 */
- (NSMutableAttributedString *)replaceAttributeLinkToOldAttributedString:(NSMutableAttributedString *)attributedString withLinkArray:(NSArray *)linkArray
{
    for (int i = 0; i < linkArray.count; i++) {
        NSArray *rangeArray = [linkArray[i] allKeys];
        NSString *rangeString = [rangeArray firstObject];
        NSRange range = NSRangeFromString(rangeString);
        NSDictionary *attributes = @{NSForegroundColorAttributeName :_linkColor,NSStrokeWidthAttributeName:@(_linkTextWidth)};
        [attributedString addAttributes:attributes range:range];
        if (_linkBackGourdColorDict) {//点击需要背景色
            NSArray *CilckedRangeArray = [linkArray[_index] allKeys];
            NSString *CilckedRangeString = [CilckedRangeArray firstObject];
            NSRange CilckedRange = NSRangeFromString(CilckedRangeString);
            [attributedString addAttributes:_linkBackGourdColorDict range:CilckedRange];
        }
        if (_linkUnderLine) {//link需要下划线
            NSDictionary *dict = @{NSUnderlineStyleAttributeName:@1};
            [attributedString addAttributes:dict range:range];
        }
    }
    return attributedString;
}

/**
 *  加工美化NSAttributedString
 *
 *  @param attributeString old NSAttributedString
 *
 *  @return process NSAttributedString
 */
+ (NSMutableAttributedString *)processAttributedString:(NSMutableAttributedString *)attributeString
{
    NSRange range;
    NSMutableParagraphStyle *paragraph = [attributeString attribute:NSParagraphStyleAttributeName atIndex:0 effectiveRange:&range];
    if (!paragraph) {
        return attributeString;
    }
    NSMutableParagraphStyle *mutableParagraph = [paragraph mutableCopy];
    mutableParagraph.lineBreakMode = NSLineBreakByCharWrapping;
    //当属性文字遭遇到换行模式
    NSMutableAttributedString *restyled = [[NSMutableAttributedString alloc] initWithAttributedString:attributeString];
    [restyled addAttribute:NSParagraphStyleAttributeName value:mutableParagraph range:NSMakeRange(0, restyled.length)];
    return restyled;
}

/**
 *  设置 text Properties
 *
 *  @return 属性字典
 */
- (NSDictionary *)attributesFromProperties
{
    //set properties
    //shadow
    NSShadow *shadow = [[NSShadow alloc] init];
    if (self.shadowColor) {
        shadow.shadowOffset = self.shadowOffset;
        shadow.shadowColor = self.shadowColor;
    }else {
        shadow.shadowColor = nil;
        shadow.shadowOffset = CGSizeMake(0, -1);
    }
    
    //color
    UIColor *color = self.textColor;
    if (!self.isEnabled) {
        color = [UIColor grayColor];
    }else if (self.highlighted) {
        color = self.highlightedTextColor;
    }
    
    //paragraph
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = self.textAlignment;
    
    return @{           NSFontAttributeName:self.font,
                      NSShadowAttributeName:shadow,
             NSForegroundColorAttributeName:color,
              NSParagraphStyleAttributeName:paragraph,
             };
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    
    CGSize savedTextContainerSize = _textContainer.size;
    NSInteger savedTextContainerNumberOfLines = _textContainer.maximumNumberOfLines;
    
    _textContainer.size = bounds.size;
    _textContainer.maximumNumberOfLines = numberOfLines;
    
    CGRect textBounds = [_layoutManager usedRectForTextContainer:_textContainer];
    
    textBounds.origin = bounds.origin;
    textBounds.size.width = ceil(textBounds.size.width);
    textBounds.size.height = ceil(textBounds.size.height+_sapcingTop);
    
    _textContainer.size = savedTextContainerSize;
    _textContainer.maximumNumberOfLines = savedTextContainerNumberOfLines;
    return textBounds;
}

- (void)drawTextInRect:(CGRect)rect
{
    //重载原始图布局，需要调用super，自己绘制不需要调用super
    //    [super drawTextInRect:rect];
    //返回截取的范围
    rect = [self textRectForBounds:rect limitedToNumberOfLines:self.numberOfLines];
    //返回文本约束范围
    NSRange glyphRange = [_layoutManager glyphRangeForTextContainer:_textContainer];
    CGPoint glyphsPosition = [self calcGlyphsPositionInView];
    
    [_layoutManager drawBackgroundForGlyphRange:glyphRange atPoint:glyphsPosition];
    [_layoutManager drawGlyphsForGlyphRange:glyphRange atPoint:glyphsPosition];
}

- (CGPoint)calcGlyphsPositionInView
{
    //返回绘制文字的实际范围
    CGRect textBounds = [_layoutManager usedRectForTextContainer:_textContainer];
    if (_sapcingTop!=0) {
        textBounds.origin.y = _sapcingTop;
    }else
    {
        switch (self.labelVerticalAlignment) {
            case WYLabelVerticalAlignmentTop:
                textBounds.origin.y = self.bounds.origin.y;
                break;
            case WYLabelVerticalAlignmentBottom:
                textBounds.origin.y = self.bounds.origin.y + self.bounds.size.height - textBounds.size.height;
                break;
            case WYLabelVerticalAlignmentMiddle:
            default:
                textBounds.origin.y = self.bounds.origin.y + (self.bounds.size.height - textBounds.size.height) / 2.0;
        }
    }
    return textBounds.origin;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!_automaticLinkClicked&&_allTextLink == NO) {
        return;
    }
    CGPoint touchLocation = [[touches anyObject] locationInView:self];
    BOOL linkCilcked = [self calculateTouchesRange:touchLocation];
    if (!linkCilcked) {
        if (_allTextLink) {
            touchLocation.y -= _sapcingTop;
            NSUInteger touchedChar = [_layoutManager glyphIndexForPoint:touchLocation inTextContainer:_textContainer];
            NSString *string = _attributeString.string;
            NSString *charString = [string substringWithRange:NSMakeRange(touchedChar, 1)];
            if ([self.delegate respondsToSelector:@selector(labelLinkClickedWithLabel:withCilckedText: withLinkStyle:)]) {
                [_delegate labelLinkClickedWithLabel:self withCilckedText:charString withLinkStyle:WYLabelLinkStyleOther];
            }
        }
        
    }
    if (_linkBackGroudColor&&linkCilcked) {//允许点击link有背景颜色
        
        _linkBackGourdColorDict = @{NSBackgroundColorAttributeName  :_selectedLinkBackGroudColor};
        [self updataTextWithCurrentText];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    _linkBackGourdColorDict = nil;
    [self updataTextWithCurrentText];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    _linkBackGourdColorDict = nil;
    [self updataTextWithCurrentText];
}

//计算点击是否在link range内
- (BOOL)calculateTouchesRange:(CGPoint)location
{
    //获取触摸点字符位置
    location.y -= _sapcingTop;
    NSUInteger touchedChar = [_layoutManager glyphIndexForPoint:location inTextContainer:_textContainer];
    for (int i = 0; i < self.linkArray.count; i++) {
        NSArray *rangeArray = [self.linkArray[i] allKeys];
        NSString *rangeString = [rangeArray firstObject];
        NSRange range = NSRangeFromString(rangeString);
        if (touchedChar>=range.location && touchedChar<=range.location+range.length) {
            NSArray *valueArray = [self.linkArray[i] allValues];
            _index = i;
            WYLabelLinkStyle linkStyle = WYLabelLinkStyleALL;
            if (i<_webArray.count&&i>-1) {//点击的是网址
                linkStyle = WYLabelLinkStyleWeb;
            }else if (i<_phoneArray.count+_webArray.count&&i>-1) {//点击的是手机号码
                linkStyle = WYLabelLinkStyleIphoneNumber;
            }else if (i>-1)//点击用户自定义文字
            {
                linkStyle = WYLabelLinkStyleUserText;
            }
            NSString *valueString = [valueArray firstObject];
            if ([self.delegate respondsToSelector:@selector(labelLinkClickedWithLabel:withCilckedText: withLinkStyle:)]) {
                
                [_delegate labelLinkClickedWithLabel:self withCilckedText:valueString withLinkStyle:linkStyle];
            }
            return YES;
        }
    }
    return NO;
}

- (void)setAutomaticLinkClicked:(BOOL)automaticLinkClicked
{
    _automaticLinkClicked = automaticLinkClicked;
    [self updataTextWithCurrentText];
}

- (void)setSelectedLinkBackGroudColor:(UIColor *)selectedLinkBackGroudColor
{
    _selectedLinkBackGroudColor = selectedLinkBackGroudColor;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    if (!text) {
        text = @"";
    }
    
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:text attributes:[self attributesFromProperties]];
    [self updataTextStorageWithAttributedString:attribute];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self updataTextStorageWithAttributedString:(NSMutableAttributedString *)attributedText];
}

- (void)setSelectedLinkTextColor:(UIColor *)selectedLinkTextColor
{
    _linkColor = selectedLinkTextColor;
    
    [self updataTextWithCurrentText];
}

- (void)setLinkUnderLine:(BOOL)linkUnderLine
{
    _linkUnderLine = linkUnderLine;
    
    [self updataTextWithCurrentText];
}

- (void)setLinkTextWidth:(NSUInteger)linkTextWidth
{
    _linkTextWidth = linkTextWidth;
    
    [self updataTextWithCurrentText];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _textContainer.size = self.bounds.size;
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    _textContainer.size = self.bounds.size;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _textContainer.size = self.bounds.size;
}

- (void)setLabelLinkStyle:(WYLabelLinkStyle)labelLinkStyle
{
    _labelLinkStyle = labelLinkStyle;
    [self updataTextWithCurrentText];
}

- (void)setSapcingTop:(NSInteger)sapcingTop
{
    _sapcingTop = sapcingTop;
}

/**
 *  含有特殊可点击的字符数组link
 *
 *  @param str 未处理的数据(网址、手机号码)
 *
 *  @return 处理之后含有特殊字符(link)的数组
 */
- (NSArray *)regularExpressionManagerWithStr:(NSString *)str
{
    self.webArray = [WYLabel matchStringWithWebLink:str];
    self.phoneArray = [WYLabel matchStringWithPhoneLink:str];
    self.userLinkArray = [self matchStringWithLinkText:str];
    [self.selectedClickArray addObjectsFromArray:self.webArray];
    [self.selectedClickArray addObjectsFromArray:self.phoneArray];
    [self.selectedClickArray addObjectsFromArray:self.userLinkArray];
    if (_labelLinkStyle == WYLabelLinkStyleWeb) {
        return self.webArray;
    }else if (_labelLinkStyle == WYLabelLinkStyleIphoneNumber) {
        return self.phoneArray;
    }else if (_labelLinkStyle == WYLabelLinkStyleUserText) {
        return self.userLinkArray;
    }else {
        return self.selectedClickArray;
    }
}

/**
 *  匹配电话号码
 *
 *  @param oldString
 */
+ (NSArray *)matchStringWithPhoneLink:(NSString *)oldString
{
    NSMutableArray *linkArr = [NSMutableArray array];
    NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:@"(\\(86\\))?(13[0-9]|15[0-35-9]|18[0125-9])\\d{8}" options:NSRegularExpressionDotMatchesLineSeparators|NSRegularExpressionCaseInsensitive error:nil];
    NSArray *array = [regExp matchesInString:oldString options:0 range:NSMakeRange(0, oldString.length)];
    for (NSTextCheckingResult *result in array) {
        NSString *string = [oldString substringWithRange:result.range];
        NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:string,NSStringFromRange(result.range), nil];
        [linkArr addObject:dic];
    }
    return linkArr;
}

/**
 *  匹配Web网址
 *
 *  @param oldString oldString
 */
+ (NSArray *)matchStringWithWebLink:(NSString *)oldString
{
    NSMutableArray *linkArr = [NSMutableArray array];
    
    NSRegularExpression*regular=[[NSRegularExpression alloc]initWithPattern:@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"options:NSRegularExpressionDotMatchesLineSeparators|NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray* array=[regular matchesInString:oldString options:0 range:NSMakeRange(0, [oldString length])];
    
    for( NSTextCheckingResult * result in array){
        
        NSString *string = [oldString substringWithRange:result.range];
        NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:string,NSStringFromRange(result.range), nil];
        
        [linkArr addObject:dic];
    }
    return linkArr;
}

/**
 *  匹配用户自定义link文本
 *
 *  @param linkText
 */
- (NSArray *)matchStringWithLinkText:(NSString *)oldString
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < self.linkTextArray.count; i++) {
        NSRange range = [oldString rangeOfString:_linkTextArray[i]];
        NSDictionary *dict = @{NSStringFromRange(range):_linkTextArray[i]};
        [array addObject:dict];
    }
    return array;
}

- (void)setLinkTextArray:(NSArray *)linkTextArray
{
    _linkTextArray = linkTextArray;
    [self updataTextWithCurrentText];
}

- (NSMutableArray *)selectedClickArray
{
    if (!_selectedClickArray) {
        _selectedClickArray = [NSMutableArray array];
    }
    return _selectedClickArray;
}

@end
