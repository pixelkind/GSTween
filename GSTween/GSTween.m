//
//  GSTween.m
//  GSTween
//
//  Created by Garrit Schaap on 06.02.14.
//  Copyright (c) 2014 Garrit Schaap. All rights reserved.
//

#import "GSTween.h"

@implementation GSTween

- (id)initWithTarget:(NSObject*)target time:(CGFloat)time ease:(easeBlock)ease to:(NSDictionary*)to
{
    return [self initWithTarget:target time:time ease:ease to:to delay:0.0f];
}

- (id)initWithTarget:(NSObject*)target time:(CGFloat)time ease:(easeBlock)ease to:(NSDictionary*)to delay:(CGFloat)delay
{
    self = [super init];
    if (self)
    {
        _time = time;
        _target = target;
        _currentTime = 0.0f;
        _delay = delay;
        _totalTime = _time + _delay;
        _ease = ease;
        _values = [NSMutableArray array];
        _isYoyo = NO;
        _speed = 1.0f;
        
        [self parseKeys:to];
        /*
        [to enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
        {
            GSTweenData* tweenData = [GSTweenData tweenDataWithValue:obj andKey:key andTarget:target];
            if (tweenData != nil)
            {
                [_values addObject:tweenData];
            }
        }];
        */
        
        [self start];
    }
    return self;
}

- (void)parseKeys:(NSDictionary*)keys
{
    NSArray* reserved = @[ @"yoyo", @"speed" ];
    
    [keys enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
    {
        NSInteger index = [reserved indexOfObject:key];
        if (index == NSNotFound)
        {
            GSTweenData* tweenData = [GSTweenData tweenDataWithValue:obj andKey:key andTarget:_target];
            if (tweenData != nil)
            {
                [_values addObject:tweenData];
            }
        }
        else
        {
            NSLog(@"Index found");
            if ([key isEqualToString:@"yoyo"])
            {
                _isYoyo = [obj boolValue];
            }
            else if ([key isEqualToString:@"speed"])
            {
                _speed = [obj floatValue];
            }
        }
    }];
}

- (void)setupDisplayLink
{
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update:)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)update:(CADisplayLink*)displayLink
{
    if ((_currentTime >= _delay && _speed > 0) || (_speed < 0))// && _currentTime <= _totalTime))
    {
        CGFloat value;
        CGFloat time = (_currentTime - _delay) / _time;
        //make this nicer!
        time = fminf(1.0f, fmaxf(0.0f, time));
        
        value = _ease(time);
        
        //make this nicer!
        value = fminf(1.0f, fmaxf(0.0f, value));
        
        [_values enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
        {
            [(GSTweenData*)obj updateWithValue:value];
        }];
        
        if (value == 1.0f && !_isYoyo)
        {
            [self stop];
            //stop this...
        }
        else if (value == 1.0f)
        {
            _currentTime = _totalTime;
            _speed *= - 1.0f;
        }
        else if (_isYoyo && _speed < 0 && value == 0.0f)
        {
            _currentTime = 0.0f;
            _speed *= - 1.0f;
        }
    }
    _currentTime += [displayLink duration] * _speed;
}

- (void)start
{
    [self setupDisplayLink];
}

- (void)stop
{
    [_displayLink invalidate];
}

@end
