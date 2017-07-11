//
//  ViewController.h
//  FingerPrint
//
//  Created by Kosien on 17/2/28.
//  Copyright © 2017年 kosienDGL. All rights reserved.
//  代码地址：https://github.com/YoungerLi/FingerPrint

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end

/*
 LAErrorAuthenticationFailed
 连续三次指纹验证失败，可能指纹模糊或用错手指
 
 LAErrorUserCancel
 用户取消验证，点击了取消按钮
 
 LAErrorUserFallback
 用户取消验证，点击了输入密码按钮
 
 LAErrorSystemCancel
 系统取消授权，如其他APP切入
 
 LAErrorPasscodeNotSet
 指纹验证无法启动/失败，因为设备没有设置密码
 
 LAErrorTouchIDNotAvailable
 设备TouchID不可用，例如未打开
 
 LAErrorTouchIDNotEnrolled
 指纹验证无法启动，因为没有录入指纹(设置密码了)
 
 LAErrorTouchIDLockout   NS_ENUM_AVAILABLE(10_11, 9_0)
 设备TouchID被锁定，因为失败的次数太多了
 
 LAErrorAppCancel        NS_ENUM_AVAILABLE(10_11, 9_0)
 应用程序取消了身份验证，APP调用了-(void)invalidate方法使LAContext失效
 
 LAErrorInvalidContext   NS_ENUM_AVAILABLE(10_11, 9_0)
 实例化的LAContext对象失效，再次调用evaluation...方法则会弹出此错误信息
 */
