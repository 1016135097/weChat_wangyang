//
//  AppDelegate.m
//  WeChat
//
//  Created by wangyang on 15/11/3.
//  Copyright © 2015年 wangyang. All rights reserved.
//

#import "AppDelegate.h"
#import "DSLaunchingController.h"
#import "DSFirstUseAppController.h"
#import "DSMainController.h"
#import "XMPPFramework.h"
#import "DS_CurrentSystemTool.h"

@interface AppDelegate ()<XMPPStreamDelegate>{
    XMPPStream *_xmppStream;
}
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
    
    if (![DS_CurrentSystemTool readCurrentAppLanguage]) {
        NSString *language = [DS_CurrentSystemTool currentSysTemLanguage];
        [DS_CurrentSystemTool saveSetLanguage:language];
    }
    
    [self xmppStream];
    [self connectSocket];
    if ([self launchView]) {
        if ([DS_AppLoginState isLoginState]) {//登录页
            self.window.rootViewController = [[DSFirstUseAppController alloc] init];
        }else {
            self.window.rootViewController = [[DSMainController alloc] init];
        }
    }
    [self loadFontStyle];
    return YES;
}

- (void)loadFontStyle
{
//    for(NSString *fontfamilyname in [UIFont familyNames])
//    {
//        NSLog(@"family:'%@'",fontfamilyname);
//        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
//        {
//            NSLog(@"\tfont:'%@'",fontName);
//        }
//        NSLog(@"-------------");
//    }
}

#pragma mark - xmpp open  user login
- (void)xmppStream
{
    _xmppStream = [[XMPPStream alloc] init];
    [_xmppStream addDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)];
}

- (void)connectSocket
{
    _xmppStream.hostName = @"wangyang.local";
    _xmppStream.hostPort = 5222;
    _xmppStream.myJID = [XMPPJID jidWithUser:@"wangwu" domain:@"wangyang.local" resource:nil];
    if ([_xmppStream connectWithTimeout:-1 error:nil]) {
        NSLog(@"socket success");
    }
}

- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
    if ([_xmppStream authenticateWithPassword:@"123456" error:nil]) {
        NSLog(@"login success");
    }
}

- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    [_xmppStream sendElement:[XMPPPresence presence]];
}

#pragma mark- app login state
- (BOOL)launchView
{
    DSLaunchingController *launchingViewController = [[DSLaunchingController alloc] init];
    self.window.rootViewController = launchingViewController;
   return  [launchingViewController downLoadSource];
}

@end
