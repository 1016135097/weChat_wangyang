//
//  DSMainController.m
//  WeChat
//
//  Created by wangyang on 15/11/3.
//  Copyright © 2015年 wangyang. All rights reserved.
//

#import "DSMainController.h"
#import "DSTabBar.h"
#import "DSWeChatController.h"
#import "DSAddressBookController.h"
#import "DSFindController.h"
#import "DSMineController.h"
#import "DS_BaseNavController.h"

@interface DSMainController ()<DSTabBarDeletate>
@property (nonatomic,strong)DSTabBar *customerTabBar;
@end

@implementation DSMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBar addSubview:self.customerTabBar];
    [self loadSubViewControllers];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (UIView * view in self.tabBar.subviews) {
        if ([view isKindOfClass:[UIControl class]]) {
            [view removeFromSuperview];
        }
    }
}

- (void)loadSubViewControllers
{
    DSWeChatController *weChat = [[DSWeChatController alloc] init];
    [self addTabBarItemWithController:weChat
                            WithTitle:DS_CustomLocalizedString(@"weChat", @"微信")
                            withImage:@"tabbar_mainframe.png"
                   withHighlightImage:@"tabbar_mainframeHL.png"];
    
    DSAddressBookController *addressBook = [[DSAddressBookController alloc] init];
    [self addTabBarItemWithController:addressBook
                            WithTitle:DS_CustomLocalizedString(@"address", @"通讯录")
                            withImage:@"tabbar_contacts.png"
                   withHighlightImage:@"tabbar_contactsHL.png"];
    
    DSFindController *find = [[DSFindController alloc] init];
    [self addTabBarItemWithController:find
                            WithTitle:DS_CustomLocalizedString(@"find", @"发现")
                            withImage:@"tabbar_discover.png"
                   withHighlightImage:@"tabbar_discoverHL.png"];
    
    DSMineController *mine = [[DSMineController alloc] init];
    [self addTabBarItemWithController:mine
                            WithTitle:DS_CustomLocalizedString(@"mine", @"我")
                            withImage:@"tabbar_me.png"
                   withHighlightImage:@"tabbar_meHL.png"];
}

- (void)tabBarItemWithTabBar:(DSTabBar *)tabBar withSelectedItem:(NSUInteger)selectedIndex
{
    self.selectedIndex = selectedIndex;
}

- (void)addTabBarItemWithController:(UIViewController *)controller WithTitle:(NSString *)title withImage:(NSString *)image withHighlightImage:(NSString *)highlightImage
{
    controller.title = title;
    controller.tabBarItem.image = [UIImage imageNamed:image];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:highlightImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *naController = [[DS_BaseNavController alloc] initWithRootViewController:controller];
    [self addChildViewController:naController];
    [self.customerTabBar tabBarWithTabBarItem:controller.tabBarItem];
}

- (DSTabBar *)customerTabBar
{
    if (!_customerTabBar) {
        _customerTabBar = [[DSTabBar alloc] init];
        _customerTabBar.frame = self.tabBar.bounds;
        _customerTabBar.deletgate = self;
    }
    return _customerTabBar;
}

@end
