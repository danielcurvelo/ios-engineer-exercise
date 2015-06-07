//
//  AlarmController.m
//  Exercise
//
//  Created by Mac User on 6/5/15.
//  Copyright (c) 2015 Ender Labs. All rights reserved.
//

#import "AlarmManager.h"
#import "Alarm.h"



@implementation AlarmManager

#pragma mark -
#pragma mark Initializing SharedInstance

+(instancetype)sharedInstance
{
    static AlarmManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [AlarmManager new];
        [sharedInstance registerNotifications];
        [sharedInstance setDefaultValues];
    });
    return sharedInstance;
}

#pragma mark -
#pragma mark Setting Defaults

-(void)incrementAppLaunches:(NSInteger)launch
{
    // MARK: Keeping track of App Launches.
    self.launches++;
    [[NSUserDefaults standardUserDefaults] setInteger:self.launches forKey:appLaunchesKey];
}

-(void)setDefaultValues
{
    // MARK: Using the app launches to know which default values to set.
    self.sliderValue = 0.5;
    self.launches = [[NSUserDefaults standardUserDefaults] integerForKey:appLaunchesKey];
    if (self.launches > 0) {
        self.isAlarmEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:switchStatusKey];
        self.thresholdValue = [[NSUserDefaults standardUserDefaults] floatForKey:thresholdStatusKey];
;
    }
    else
    {
        // This will only get called on the first app launch.
        self.isAlarmEnabled = YES;
        [[NSUserDefaults standardUserDefaults] setBool:self.isAlarmEnabled forKey:switchStatusKey];
        self.thresholdValue = 0.9;
        [[NSUserDefaults standardUserDefaults] setFloat:self.thresholdValue forKey:thresholdStatusKey];
    }
}

#pragma mark -
#pragma mark Data Manipulation

- (void)thresholdValueDidChange:(NSNotification *)note
{
    // MARK: Changing and saving the threshold value.
    self.thresholdValue = [note.userInfo[valueKey] floatValue];
    [[NSUserDefaults standardUserDefaults] setFloat:self.thresholdValue forKey:thresholdStatusKey];
}

- (void)toggleValueDidChange:(NSNotification *)note
{
    // MARK: Changing and saving the Switch valuee.
    self.isAlarmEnabled = [note.userInfo[onKey] boolValue];
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
