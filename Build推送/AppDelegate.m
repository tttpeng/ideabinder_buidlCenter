//
//  AppDelegate.m
//  Build推送
//
//  Created by Peng Tao on 15/9/10.
//  Copyright (c) 2015年 Peng Tao. All rights reserved.
//

#import "AppDelegate.h"

#import "APService.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
    
    NSMutableSet *categories = [NSMutableSet set];
    
    UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc] init];
    
    category.identifier = @"identifier";
    
    UIMutableUserNotificationAction *action = [[UIMutableUserNotificationAction alloc] init];
    
    action.identifier = @"test2";
    
    action.title = @"test";
    
    action.activationMode = UIUserNotificationActivationModeBackground;
    
    action.authenticationRequired = YES;
    
    //YES显示为红色，NO显示为蓝色
    action.destructive = NO;
    
    NSArray *actions = @[ action ];
    
    [category setActions:actions forContext:UIUserNotificationActionContextMinimal];
    
    [categories addObject:category];
    [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)                      categories:categories];

  }
  
  if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
  }else{
    [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)                      categories:nil];
  }
  
  
  
  
  
  
  return YES;
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


- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
  

  NSLog(@"推送啦啦啦啦");
  
}




- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
  
  // Required
  [APService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
  
  // Required
  [APService handleRemoteNotification:userInfo];
      NSLog(@"UserInfo:%@",userInfo);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
  
  
  // IOS 7 Support Required
  [APService handleRemoteNotification:userInfo];
      NSLog(@"UserInfo:%@",userInfo);
  completionHandler(UIBackgroundFetchResultNewData);
}


@end
