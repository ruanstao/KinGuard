//
//  AppDelegate.m
//  KinGuard
//
//  Created by RuanSTao on 16/4/27.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import "AppDelegate.h"
#import "UserModel.h"
#import "JPUSHService.h"

#define GaoDeDiTu_Key @"60bc8e854afef14a5500863c1f409263"
#define KinGuardAppKey @"a6b0c023c373971a6523b1960ede0031"
#define KinGuardAppSecret @"0be4f5e95593a4d65d6734942b4617e740090527becaf0d3f46d50be179d6933"

#define JpushAppKey @"2c01be14342a43fd42064719"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [MAMapServices sharedServices].apiKey = GaoDeDiTu_Key;
    //注册服务器识别key
    [KinGuartApi sharedKinGuard].appKey = KinGuardAppKey;
    [KinGuartApi sharedKinGuard].appSecret = KinGuardAppSecret;
    
    //🐔光推送
    [JPUSHService setupWithOption:launchOptions appKey:JpushAppKey channel:@"星联守护" apsForProduction:NO];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //       categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound |
            UIUserNotificationTypeAlert) categories:nil];
    } else {
        //categories    nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert) categories:nil];
    }
    
    [JJSUtil getDataWithKey:KinGuard_UserInfo Completion:^(BOOL finish, id obj) {
        if (obj) {
            NSData *userData = obj;
            UserModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
            if (!model.isLogined) { //非登录状态
                self.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
            }
        }else{//未取到登录数据
            self.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
        }
        
    }];
    
    
    return YES;
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
