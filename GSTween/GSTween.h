//
//  GSTween.h
//  GSTween
//
//  Created by Garrit Schaap on 06.02.14.
//  Copyright (c) 2014 Garrit Schaap. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef CGFloat (^easeBlock)(CGFloat time);
typedef void (^updateTweenBlock)(CGFloat progress, CGFloat value);
typedef void (^tweenBlock)();

extern NSString *const kGSTweenDelay;
extern NSString *const kGSTweenYoYo;
extern NSString *const kGSTweenAutoStart;
extern NSString *const kGSTweenRepeat;
extern NSString *const kGSTweenOnStart;
extern NSString *const kGSTweenOnComplete;
extern NSString *const kGSTweenOnUpdate;
extern NSString *const kGSTweenSpeed;

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
    BOOL _autoStart;
    BOOL _init;
    BOOL _isPaused;
}

@property (nonatomic) CGFloat speed;
@property (nonatomic, readonly) NSString* version;

- (id)initWithTarget:(NSObject*)target time:(CGFloat)time ease:(easeBlock)ease params:(NSDictionary*)params;
- (void)start;
- (void)stop;
- (void)pause;
- (void)resume;
- (void)reset;

@end
