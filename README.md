# FingerPrint
iOS指纹解锁，a demo with TouchID.
此demo是我封装好的一个项目，直接用就可以。

# 使用方法
1、首先，将LYTouchID文件夹拖入你的工程中，引入头文件
```objective-c
#import "LYTouchID.h"
```
2、然后在你需要启用指纹的地方直接调用这个类方法就行了
```objective-c
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
```
### ps:以上的情况，需要哪些就写哪些就行！
