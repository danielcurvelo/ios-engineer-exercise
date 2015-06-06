//
//  DangerViewController.m
//  Exercise
//
//  Created by Donald Hays on 2/24/15.
//  Copyright (c) 2015 Ender Labs. All rights reserved.
//

#import "DangerViewController.h"
#import "SettingsViewController.h"
#import "AlarmViewController.h"
#import "AlarmController.h"
#import "Alarm.h"

@interface DangerViewController()
@property (nonatomic, weak) IBOutlet UISlider *dangerSlider;
@property (nonatomic, assign) CGFloat thresholdValue;
@property (nonatomic, assign) BOOL isToggleOn;
@end

@implementation DangerViewController
#pragma mark -
#pragma mark Actions

-(void)viewDidLoad
{
    
    self.dangerSlider.minimumValue = 0.0;
    self.dangerSlider.maximumValue = 1.0;

}

- (IBAction)dangerSliderValueChanged:(UISlider *)sender
{
    
    NSLog(@"Slider Value: %f comparing to Threshold: %f",sender.value, [AlarmController sharedInstance].thresholdValue);
    
    // TODO: Change the danger value.
    if (sender.value >= [AlarmController sharedInstance].thresholdValue) {
        NSLog(@"You're in Danger!");
        [[NSNotificationCenter defaultCenter] postNotificationName:AlarmDidActivateNotification object:nil];
        if (!isAlarmActive()) {
            activateAlarm();
        }
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:AlarmDidDeactivateNotification object:nil];
        if (isAlarmActive()) {
            deactivateAlarm();
        }
    }
    
}


@end
