//
//  AlarmController.m
//  Exercise
//
//  Created by Mac User on 6/5/15.
//  Copyright (c) 2015 Ender Labs. All rights reserved.
//

#import "AlarmController.h"
#import "Alarm.h"

static NSString * const thresholdNote = @"thresholdNote";
static NSString * const toggleNote = @"toggleNote";
static NSString * const value = @"value";
static NSString * const on = @"on";
static NSString * const appLaunchesKey = @"launches";
static NSString * const switchStatusKey = @"switchStatus";
static NSString * const thresholdStatusKey = @"thresholdStatus";

@implementation AlarmController

#pragma mark -
#pragma mark Initializing SharedInstance

+(instancetype)sharedInstance
{
    static AlarmController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [AlarmController new];
        sharedInstance.sliderValue = 0.5;
        [sharedInstance setDefaultValues];
        [sharedInstance registerNotifications];
    });
    return sharedInstance;
}

#pragma mark -
#pragma mark Setting Defaults

-(void)incrementAppLaunches:(int)launch
{
    // MARK: Keeping track of App Launches.
    self.launches = [NSNumber numberWithInt:launch + 1];
    [[NSUserDefaults standardUserDefaults] setObject:self.launches forKey:appLaunchesKey];
}

-(void)setDefaultValues
{
    // MARK: Using the app launches to know which default values to set.
    self.launches = [[NSUserDefaults standardUserDefaults] objectForKey:appLaunchesKey];
    if (self.launches > 0) {
        self.isAlarmEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:switchStatusKey];
        CGFloat savedThresholdValue = [[[NSUserDefaults standardUserDefaults] objectForKey:thresholdStatusKey] floatValue];
        self.thresholdValue = savedThresholdValue;
    }
    else
    {
        self.isAlarmEnabled = YES;
        self.thresholdValue = 0.9;
    }
}

#pragma mark -
#pragma mark Data Manipulation

- (void)thresholdValueDidChange:(NSNotification *)note
{
    // MARK: Changing and saving the threshold value.
    self.thresholdValue = [note.userInfo[value] floatValue];
    [[NSUserDefaults standardUserDefaults] setObject:note.userInfo[value] forKey:thresholdStatusKey];
}

- (void)toggleValueDidChange:(NSNotification *)note
{
    // MARK: Changing and saving the Switch valuee.
    self.isAlarmEnabled = [note.userInfo[on] boolValue];
    [[NSUserDefaults standardUserDefaults] setBool:self.isAlarmEnabled forKey:switchStatusKey];

    if (self.isAlarmEnabled) {
        [[NSNotificationCenter defaultCenter] postNotificationName:AlarmDidActivateNotification object:nil];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:AlarmDidDeactivateNotification object:nil];
    }
}

#pragma mark -
#pragma mark Notifications

-(void)registerNotifications
{
    // MARK: Adding Observers to track threshold and switch values.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(thresholdValueDidChange:) name:thresholdNote object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toggleValueDidChange:) name:toggleNote object:nil];
    
}

-(void)dealloc
{
    // MARK: Removing the Observers once the object has been deallocated from memory.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:thresholdNote object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:toggleNote object:nil];
}

@end
