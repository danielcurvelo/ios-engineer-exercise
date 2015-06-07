//
//  AlarmController.h
//  Exercise
//
//  Created by Mac User on 6/5/15.
//  Copyright (c) 2015 Ender Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AlarmManager;
@import UIKit;

// =============================================================================
// This Class is going to handle any modification to the data inside the app.
// =============================================================================

static NSString * const thresholdNote = @"thresholdNote";
static NSString * const toggleNote = @"toggleNote";
static NSString * const valueKey = @"valueKey";
static NSString * const onKey = @"onKey";
static NSString * const appLaunchesKey = @"launches";
static NSString * const switchStatusKey = @"switchStatus";
static NSString * const thresholdStatusKey = @"thresholdStatus";

@interface AlarmManager : NSObject

+(AlarmManager *)sharedInstance;

@property (nonatomic, assign) CGFloat thresholdValue;
@property (nonatomic, assign) CGFloat sliderValue;
@property (nonatomic, assign) BOOL isAlarmEnabled;
@property (nonatomic, assign) NSInteger launches;

-(void)incrementAppLaunches:(NSInteger)launch;

@end
