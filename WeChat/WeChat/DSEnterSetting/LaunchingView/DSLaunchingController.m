//
//  DSLaunchingController.m
//  WeiChat
//
//  Created by wangyang on 15/11/3.
//  Copyright © 2015年 wangyang. All rights reserved.
//

#import "DSLaunchingController.h"
#import "DSGlobal.h"
#import "DSParameter.h"
@interface DSLaunchingController ()
@property (nonatomic,strong)UIImageView *launchImageView;
@end

@implementation DSLaunchingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.launchImageView];
    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints
{
    __weak typeof(self)weakSelf = self;
    [self.launchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

- (BOOL)downLoadSource
{
    if ([self checkSourceIsLocal]) {
        //直接加载本地资源
        return YES;
    }else {
        //从网络上获取资源
        return YES;
    }
}

- (BOOL)checkSourceIsLocal
{
    //延时
    [NSThread sleepForTimeInterval:2.];
    //此处可以加载应用进入广告推广界面
    return YES;
}

- (UIImageView *)launchImageView
{
    if (!_launchImageView) {
        _launchImageView = [[UIImageView alloc] init];
        if (INCH35) {
            _launchImageView.image = [UIImage imageNamed:@"LaunchImagelnch35"];
        }else if (INCH4) {
            _launchImageView.image = [UIImage imageNamed:@"LaunchImagelnch55"];
        }else if (INCH47) {
            _launchImageView.image = [UIImage imageNamed:@"LaunchImagelnch47"];
        }else {
            _launchImageView.image = [UIImage imageNamed:@"LaunchImagelnch55"];
        }
    }
    return _launchImageView;
}


@end
