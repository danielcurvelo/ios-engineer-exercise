//
//  AppDelegate.m
//  Exercise
//
//  Created by Donald Hays on 2/24/15.
//  Copyright (c) 2015 Ender Labs. All rights reserved.
//

#import "AppDelegate.h"
#import "AlarmManager.h"

@interface AppDelegate ()
@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // MARK: Tracking Launches
    NSInteger launches = [AlarmManager sharedInstance].launches;
    [[AlarmManager sharedInstance] incrementAppLaunches:launches];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
}
@end
