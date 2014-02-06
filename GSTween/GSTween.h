//
//  GSTween.h
//  GSTween
//
//  Created by Garrit Schaap on 06.02.14.
//  Copyright (c) 2014 Garrit Schaap. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "GSTweenData.h"

typedef CGFloat (^easeBlock)(CGFloat time);

@interface GSTween : NSObject
{
    NSObject* _target;
    CGFloat _time;
    CGFloat _currentTime;
    CGFloat _totalTime;
    NSMutableArray* _values;
    easeBlock _ease;
    CGFloat _delay;
    CADisplayLink* _displayLink;
}

- (id)initWithTarget:(NSObject*)target andTime:(CGFloat)time andEase:(easeBlock)ease andTo:(NSDictionary*)to;

@end
