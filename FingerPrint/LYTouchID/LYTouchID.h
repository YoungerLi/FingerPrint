//
//  LYTouchID.h
//  FingerPrint
//
//  Created by liyang on 17/2/28.
//  Copyright © 2017年 kosienDGL. All rights reserved.
//
//  此类封装了指纹解锁TouchID

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>

typedef NS_ENUM(NSUInteger, LYTReply)
{
    /// 系统版本不支持TouchID (必须高于iOS 8.0才能使用)
    LYTReplyVersionNotSupport,
    
    /// 验证成功
    LYTReplyAuthenticationSuccess,
    
    /// 指纹验证无法启动，因为没有录入指纹
    LYTReplyTouchIDNotEnrolled,
    
    /// 指纹验证无法启动，因为设备没有设置密码
    LYTReplyPasscodeNotSet,
    
    /// 设备TouchID被锁定，因为失败的次数太多了
    LYTReplyTouchIDLockout,
    
    /// 设备TouchID不可用，例如未打开
    LYTReplyTouchIDNotAvailable,
    
    /// 系统取消授权，如其他APP切入
    LYTReplySystemCancel,
    
    /// 用户取消验证，点击了取消按钮
    LYTReplyUserCancel,
    
    /// 用户取消验证，点击了输入密码按钮
    LYTReplyUserFallback,
    
    /// 连续三次指纹验证失败，可能指纹模糊或用错手指
    LYTReplyAuthenticationFailed,
    
    /// 当前软件被挂起并取消了授权 (如App进入了后台等)
    LYTReplyAppCancel,
    
    /// 当前软件被挂起并取消了授权 (LAContext对象无效)
    LYTReplyInvalidContext
};

typedef void(^ReplyBlock)(LYTReply reply, NSError *error);


@interface LYTouchID : NSObject

/**
 开始指纹验证
 
 @param fallBackTitle 输入密码标题自定制，默认是“输入密码”，如果为nil，代表使用默认
 @param cancelTitle 取消按钮标题自定制，默认是“取消”（iOS10以上才支持），如果为nil，代表使用默认
 @param localizedReason 提示信息，不能为空，默认是“通过Home键验证已有手机指纹”
 @param block 回调结果
 */
+ (void)ly_touchIDWithFallBackTitle:(NSString *)fallBackTitle
                        cancelTitle:(NSString *)cancelTitle
                    localizedReason:(NSString *)localizedReason
                              reply:(ReplyBlock)block;
@end
