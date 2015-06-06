//
//  AlarmController.m
//  Exercise
//
//  Created by Mac User on 6/5/15.
//  Copyright (c) 2015 Ender Labs. All rights reserved.
//

#import "AlarmController.h"
#import "Alarm.h"

NSString * thresholdNote = @"threshold";
NSString * toggleNote = @"toggle";
NSString * value = @"value";
NSString * on = @"on";

@implementation AlarmController

+(instancetype)sharedInstance
{
    static AlarmController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [AlarmController new];
        sharedInstance.thresholdValue = 0.9;
        sharedInstance.sliderValue = 0.5;
        sharedInstance.toogleValue = YES;
        [sharedInstance registerNotifications];
    });
    return sharedInstance;
    
}

-(void)registerNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(thresholdValueDidChange:) name:thresholdNote object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toggleValueDidChange:) name:toggleNote object:nil];

}

- (void)thresholdValueDidChange:(NSNotification *)note
{
    self.thresholdValue = [note.userInfo[value] floatValue];
    //    NSLog(@"new value: %f",self.thresholdValue);
    
}

- (void)toggleValueDidChange:(NSNotification *)note
{
    self.toogleValue = [note.userInfo[on] boolValue];
    
    NSNumber *alarmSwitchConvertion = [[NSNumber alloc]initWithBool:self.toogleValue];
    [[NSUserDefaults standardUserDefaults] setObject:alarmSwitchConvertion forKey:@"isActivated"];

    if (self.toogleValue == YES) {
        [[NSNotificationCenter defaultCenter] postNotificationName:AlarmDidActivateNotification object:nil];

    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:AlarmDidDeactivateNotification object:nil];

    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:thresholdNote object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:toggleNote object:nil];
}

@end
