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
typedef void (^updateTweenBlock)(CGFloat progress, CGFloat value);
typedef void (^tweenBlock)();

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
    BOOL _isYoyo;
    NSInteger _repeat;
    NSInteger _repeatCount;
    updateTweenBlock _updateBlock;
    tweenBlock _startBlock;
    tweenBlock _completeBlock;
    BOOL _init;
}

@property (nonatomic) CGFloat speed;

- (id)initWithTarget:(NSObject*)target time:(CGFloat)time ease:(easeBlock)ease params:(NSDictionary*)params;

@end
