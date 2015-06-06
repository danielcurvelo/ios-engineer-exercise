//
//  AlarmController.h
//  Exercise
//
//  Created by Mac User on 6/5/15.
//  Copyright (c) 2015 Ender Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AlarmController;
@import UIKit;

extern NSString *thresholdNote;
extern NSString *toggleNote;
extern NSString *value;
extern NSString *on;

@interface AlarmController : NSObject

+(AlarmController *)sharedInstance;

@property (nonatomic, assign) CGFloat thresholdValue;
@property (nonatomic, assign) CGFloat sliderValue;
@property (nonatomic, assign) BOOL toogleValue;

@end
