
//
//  DSFirstUseAppController.m
//  WeChat
//
//  Created by wangyang on 15/11/3.
//  Copyright © 2015年 wangyang. All rights reserved.
//

#import "DSFirstUseAppController.h"
#import "DSRegisterController.h"
#import "DS_LanguageController.h"
#import "AppDelegate.h"
#import "DSMainController.h"

const CGFloat margin = 30.f;
@interface DSFirstUseAppController ()
@property (nonatomic,strong)UIButton *loginButton;
@property (nonatomic,strong)UIButton *registerButton;
@property (nonatomic,strong)UIButton *languagesButton;
@end

@implementation DSFirstUseAppController

#pragma mark - life cricle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.registerButton];
    [self.view addSubview:self.languagesButton];
    [self.view setNeedsUpdateConstraints];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_loginButton setTitle:DS_CustomLocalizedString(@"login", nil) forState:UIControlStateNormal];
    [_registerButton setTitle:DS_CustomLocalizedString(@"signUp", nil) forState:UIControlStateNormal];
    [_languagesButton setTitle:DS_CustomLocalizedString(@"language", nil) forState:UIControlStateNormal];
}

- (void)updateViewConstraints
{
    WEAKSELF
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.view.mas_bottom).offset(-margin);
        make.left.mas_equalTo(weakSelf.view.mas_left).offset(margin);
        make.height.mas_equalTo(@45);
    }];
    
    [self.languagesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.view.mas_right).offset(-15);
        make.top.mas_equalTo(weakSelf.view.mas_top).offset(margin);
        make.height.mas_equalTo(25);
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_loginButton.mas_bottom);
        make.right.mas_equalTo(weakSelf.view.mas_right).offset(-margin);
        make.height.mas_equalTo(_loginButton);
        make.width.mas_equalTo(_loginButton);
        make.left.mas_equalTo(_loginButton.mas_right).offset(margin);
    }];
    [super updateViewConstraints];
}

#pragma mark - clik funs
- (void)loginAction
{
     AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.window.rootViewController = [[DSMainController alloc] init];
}

- (void)registerAction
{
    DSRegisterController *registerController = [[DSRegisterController alloc] initWithNibName:@"DSRegisterView" bundle:nil];
    [self presentViewController:registerController animated:YES completion:nil];
}

- (void)languageAction
{
    DS_LanguageController *lan = [[DS_LanguageController alloc] init];
    [self presentViewController:lan animated:YES completion:nil];
}

#pragma mark - setter and getter
- (UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setBackgroundColor:[UIColor whiteColor]];
        _loginButton.layer.masksToBounds = YES;
        _loginButton.layer.cornerRadius = 5;
        [_loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIButton *)registerButton
{
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setBackgroundColor:[UIColor greenColor]];
        _registerButton.layer.masksToBounds = YES;
        _registerButton.layer.cornerRadius = 5;
        [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

- (UIButton *)languagesButton
{
    if (!_languagesButton) {
        _languagesButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_languagesButton setTitle:DS_CustomLocalizedString(@"language", nil) forState:UIControlStateNormal];
        [_languagesButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_languagesButton addTarget:self action:@selector(languageAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _languagesButton;
}
@end
