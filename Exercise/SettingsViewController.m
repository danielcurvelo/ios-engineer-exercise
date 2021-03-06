//
//  SettingsViewController.m
//  Exercise
//
//  Created by Donald Hays on 2/24/15.
//  Copyright (c) 2015 Ender Labs. All rights reserved.
//

#import "SettingsViewController.h"
#import "AlarmManager.h"
#import "Alarm.h"

@interface SettingsViewController()
@property (nonatomic, weak) IBOutlet UISlider *alarmThresholdSlider;
@property (nonatomic, weak) IBOutlet UISwitch *alarmEnabledSwitch;
@end

@implementation SettingsViewController
#pragma mark -
#pragma mark Actions

-(void)viewDidLoad
{
    // MARK: Setting minimum/maximun values and defaults.
    [super viewDidLoad];
    
    self.alarmThresholdSlider.minimumValue = 0.0;
    self.alarmThresholdSlider.maximumValue = 1.0;
    self.alarmThresholdSlider.continuous = YES;
    self.alarmThresholdSlider.value = [AlarmManager sharedInstance].thresholdValue;
    self.alarmEnabledSwitch.on = [AlarmManager sharedInstance].isAlarmEnabled;
}

- (IBAction)done:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)alarmThresholdSliderValueChanged:(UISlider *)sender
{
    // TODO: Change the alarm activation threshold.
    [[NSNotificationCenter defaultCenter] postNotificationName:thresholdNote object:nil userInfo:@{valueKey:@(sender.value)}];
    // MARK: Done.
}

- (IBAction)alarmEnabledSwitchValueChanged:(UISwitch *)sender
{
    // TODO: Toggle whether the alarm is enabled.
    [[NSNotificationCenter defaultCenter] postNotificationName:toggleNote object:nil userInfo:@{onKey:@(sender.on)}];
    // MARK: Done.
}
@end
