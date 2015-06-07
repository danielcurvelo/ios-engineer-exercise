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
#import "AlarmManager.h"
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
    // MARK: Setting dangerSlider's minimum/maximum values.
    [super viewDidLoad];
    self.dangerSlider.minimumValue = 0.0;
    self.dangerSlider.maximumValue = 1.0;
}

-(void)viewWillAppear:(BOOL)animated
{
    // MARK: Checking for threshold level.
    [super viewWillAppear:animated];
    [self checkForThresholdLevel:self.dangerSlider];
}

- (IBAction)dangerSliderValueChanged:(UISlider *)sender
{
    // TODO: Change the danger value.
    [self checkForThresholdLevel:sender];
}

- (void)checkForThresholdLevel:(UISlider *)sender
{
    // MARK: Checking the state of the alarm before activate/deactivate.
    if ([AlarmManager sharedInstance].isAlarmEnabled) {
        if (sender.value >= [AlarmManager sharedInstance].thresholdValue) {
            if (!isAlarmActive()) {
                activateAlarm();
            }
        }
        else
        {
            if (isAlarmActive()) {
                deactivateAlarm();
            }
        }
    }
    else
    {
        if (isAlarmActive()) {
            deactivateAlarm();
        }
    }
}


@end
