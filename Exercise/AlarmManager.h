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

static NSString * const thresholdNote;
static NSString * const toggleNote;
static NSString * const value;
static NSString * const on;
static NSString * const appLaunchesKey;
static NSString * const switchStatusKey;
static NSString * const thresholdStatusKey;

@interface AlarmManager : NSObject

+(AlarmManager *)sharedInstance;

@property (nonatomic, assign) CGFloat thresholdValue;
@property (nonatomic, assign) CGFloat sliderValue;
@property (nonatomic, assign) BOOL isAlarmEnabled;
@property (nonatomic, assign) NSNumber *launches;

-(void)incrementAppLaunches:(int)launch;

@end
