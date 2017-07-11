//
//  ViewController.m
//  FingerPrint
//
//  Created by Kosien on 17/2/28.
//  Copyright © 2017年 kosienDGL. All rights reserved.
//  代码地址：https://github.com/YoungerLi/FingerPrint

#import "ViewController.h"
#import "RootViewController.h"
#import "LYTouchID.h"

//屏幕宽高
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"首页";
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2, (SCREEN_HEIGHT-100)/2, 100, 100)];
    [button setBackgroundImage:[UIImage imageNamed:@"touchID"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(evaluateAuthenticate) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

#pragma mark - 指纹验证
- (void)evaluateAuthenticate
{
    [LYTouchID ly_touchIDWithFallBackTitle:@"验证密码哈" cancelTitle:@"取消了" localizedReason:@"请验证已有手机指纹" reply:^(LYTReply reply, NSError *error) {
        NSLog(@"reply == %zd", reply);
        switch (reply) {
            case LYTReplyAuthenticationSuccess:{
                //验证成功
                [self pushRootView];
            }
                break;
            case LYTReplyUserFallback:{
                //用户取消验证，点击了输入密码按钮
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入密码" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
            }
                break;
            default:
                break;
        }
    }];
    
    //ps:以上的情况，需要哪些就写哪些就行！
}


//进入指纹页
- (void)pushRootView
{
    RootViewController *VC = [[RootViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}



@end
