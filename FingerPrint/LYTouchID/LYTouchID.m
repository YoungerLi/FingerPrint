//
//  LYTouchID.m
//  FingerPrint
//
//  Created by liyang on 17/2/28.
//  Copyright © 2017年 kosienDGL. All rights reserved.
//

#import "LYTouchID.h"

@implementation LYTouchID

+ (void)ly_touchIDWithFallBackTitle:(NSString *)fallBackTitle
                        cancelTitle:(NSString *)cancelTitle
                    localizedReason:(NSString *)localizedReason
                              reply:(ReplyBlock)block
{
    //iOS 8以上才支持指纹识别接口
    if ([[UIDevice currentDevice].systemVersion floatValue] < 8) {
        NSLog(@"不支持TouchID (版本必须高于iOS 8.0才能使用)");
        block(LYTReplyVersionNotSupport, nil);
        return;
    }
    //
    LAContext *context = [[LAContext alloc] init];
    context.localizedFallbackTitle = fallBackTitle == nil ? @"输入密码" : fallBackTitle;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10) {
        context.localizedCancelTitle = cancelTitle == nil ? @"取消" : cancelTitle;
    }
    
    NSError *Error = nil;
    NSString *reason = localizedReason == nil ? @"通过Home键验证已有手机指纹" : localizedReason;
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&Error]) {
        //该设备支持TouchID
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:reason reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    NSLog(@"指纹验证成功");
                    block(LYTReplyAuthenticationSuccess, error);
                }];
            } else {
                switch (error.code) {
                    case LAErrorSystemCancel:{
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            NSLog(@"系统取消授权，如其他APP切入");
                            block(LYTReplySystemCancel, error);
                        }];
                    }
                        break;
                    case LAErrorUserCancel:{
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            NSLog(@"用户取消验证，点击了取消按钮");
                            block(LYTReplyUserCancel, error);
                        }];
                    }
                        break;
                    case LAErrorUserFallback:{
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            NSLog(@"用户取消验证，点击了输入密码按钮");
                            block(LYTReplyUserFallback, error);
                        }];
                    }
                        break;
                    case LAErrorAuthenticationFailed:{
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            NSLog(@"连续三次指纹验证失败，可能指纹模糊或用错手指");
                            block(LYTReplyAuthenticationFailed, error);
                        }];
                    }
                        break;
                    case LAErrorTouchIDLockout:{
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            NSLog(@"设备TouchID被锁定，因为失败的次数太多了");
                            block(LYTReplyTouchIDLockout, error);
                        }];
                    }
                        break;
                    default:{
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            NSLog(@"设备TouchID不可用。。。");
                            block(LYTReplyTouchIDNotAvailable, Error);
                        }];
                    }
                        break;
                }
            }
        }];
        
    } else {
        //该设备不支持TouchID
        switch (Error.code) {
            case LAErrorTouchIDNotEnrolled:{
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    NSLog(@"指纹验证无法启动，因为没有录入指纹");
                    block(LYTReplyTouchIDNotEnrolled, Error);
                }];
            }
                break;
            case LAErrorPasscodeNotSet:{
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    NSLog(@"指纹验证无法启动，因为设备没有设置密码");
                    block(LYTReplyPasscodeNotSet, Error);
                }];
            }
                break;
            case LAErrorTouchIDLockout:{
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    NSLog(@"设备TouchID被锁定，因为失败的次数太多了");
                    block(LYTReplyTouchIDLockout, Error);
                }];
            }
                break;
            default:{
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    NSLog(@"设备TouchID不可用。。。");
                    block(LYTReplyTouchIDNotAvailable, Error);
                }];
            }
                break;
        }
    }
    
    //ps:以上只是写出了常用的几种情况，没有写全
}

@end
