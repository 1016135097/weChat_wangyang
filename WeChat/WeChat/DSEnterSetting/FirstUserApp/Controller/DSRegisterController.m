//
//  DSRegisterController.m
//  WeChat
//
//  Created by wangyang on 15/11/4.
//  Copyright © 2015年 wangyang. All rights reserved.
//

#import "DSRegisterController.h"
#import "DSGlobal.h"
#import "DSRegisterView.h"

@interface DSRegisterController ()
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@end

@implementation DSRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)cancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
