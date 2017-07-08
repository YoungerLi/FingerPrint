//
//  AppDelegate.m
//  FingerPrint
//
//  Created by Kosien on 17/2/28.
//  Copyright © 2017年 kosienDGL. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //MARK:创建根控制器
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    ViewController *vc = [[ViewController alloc] init];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nc;
    [self.window makeKeyAndVisible];
    
    return YES;
}




#pragma mark - 系统方法
- (void)applicationWillResignActive:(UIApplication *)application {
//    NSLog(@"程序中断");
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
//    NSLog(@"程序进入后台");
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
//    NSLog(@"程序将要从后台进入前台");
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
//    NSLog(@"程序重新激活");
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
//    NSLog(@"结束程序");
}

@end
