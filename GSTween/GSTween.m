//
//  GSTween.m
//  GSTween
//
//  Created by Garrit Schaap on 06.02.14.
//  Copyright (c) 2014 Garrit Schaap. All rights reserved.
//

#import "GSTween.h"
#import "GSTweenData.h"

NSString *const kGSTweenDelay = @"delay";
NSString *const kGSTweenYoYo = @"yoyo";
NSString *const kGSTweenAutoStart = @"autoStart";
NSString *const kGSTweenRepeat = @"repeat";
NSString *const kGSTweenOnStart = @"onStart";
NSString *const kGSTweenOnComplete = @"onComplete";
NSString *const kGSTweenOnUpdate = @"onUpdate";
NSString *const kGSTweenSpeed = @"speed";

@implementation GSTween

+ (id)tweenWithTarget:(NSObject*)target time:(CGFloat)time ease:(easeBlock)ease params:(NSDictionary*)params
{
	return [[self alloc] initWithTarget:target time:time ease:ease params:params];
}

- (id)initWithTarget:(NSObject*)target time:(CGFloat)time ease:(easeBlock)ease params:(NSDictionary*)params
{
	self = [super init];
	if (self)
	{
		_version = @"0.1.1";
		_time = time;
		_target = target;
		_currentTime = 0.0f;
		_delay = 0.0f;
		_totalTime = _time;
		_ease = ease;
		_values = [NSMutableArray array];
		_isYoyo = NO;
		_speed = 1.0f;
		_repeat = 0;
		_repeatCount = 0;
		_autoStart = YES;
		_init = NO;
		_isPaused = NO;
		
		[self parseKeys:params];
		
		if (_autoStart)
		{
			[self start];
			if (!_displayLink)
			{
				return nil;
			}
		}
	}
	return self;
}

- (void)parseKeys:(NSDictionary*)keys
{
	NSArray* reserved = @[ @"yoyo", @"speed", @"delay", @"repeat", @"onStart", @"onComplete", @"onUpdate", @"autoStart" ];
	
	[keys enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
	 {
		 NSInteger index = [reserved indexOfObject:key];
		 if (index == NSNotFound)
		 {
			 GSTweenData* tweenData = [GSTweenData tweenDataWithValue:obj key:key target:_target];
			 if (tweenData != nil)
			 {
				 [_values addObject:tweenData];
			 }
		 }
		 else
		 {
			 if ([key isEqualToString:@"delay"])
			 {
				 _delay = [obj floatValue];
				 _totalTime = _time + _delay;
			 }
			 else if ([key isEqualToString:@"repeat"])
			 {
				 _repeat = [obj integerValue];
			 }
			 else if ([key isEqualToString:@"yoyo"])
			 {
				 _isYoyo = [obj boolValue];
			 }
			 else if ([key isEqualToString:@"speed"])
			 {
				 _speed = [obj floatValue];
			 }
			 else if ([key isEqualToString:@"onUpdate"])
			 {
				 _updateBlock = obj;
			 }
			 else if ([key isEqualToString:@"onComplete"])
			 {
				 _completeBlock = obj;
			 }
			 else if ([key isEqualToString:@"onStart"])
			 {
				 _startBlock = obj;
			 }
			 else if ([key isEqualToString:@"autoStart"])
			 {
				 _autoStart = [obj boolValue];
			 }
		 }
	 }];
}

#if !TARGET_OS_IOS
// http://stackoverflow.com/questions/18643225/should-my-cvdisplaylinkoutputcallback-method-be-used-to-update-as-well-as-render
CVReturn displayLinkOutputCallback(CVDisplayLinkRef displayLink, const CVTimeStamp *now, const CVTimeStamp *outputTime, CVOptionFlags flagsIn, CVOptionFlags *flagsOut, void *displayLinkContext) {
	NSTimeInterval deltaTime = 1.0 / (outputTime->rateScalar * (double)outputTime->videoTimeScale / (double)outputTime->videoRefreshPeriod);
	[(__bridge GSTween*)displayLinkContext update:deltaTime];
	return kCVReturnSuccess;
}
#endif

- (BOOL)setupDisplayLink
{
#if !TARGET_OS_IOS
	CVReturn error;
	error = CVDisplayLinkCreateWithActiveCGDisplays(&(_displayLink));
	if (error) {
		NSLog(@"UNABLE TO CREATE DISPLAY LINK WITH ACTIVE CG DISPLAYS");
		_displayLink = nil;
	} else {
		error = CVDisplayLinkSetCurrentCGDisplay(_displayLink, CGMainDisplayID());
		if (error) {
			_displayLink = nil;
			NSLog(@"UNABLE TO CONNECT TO MAIN CG DISPLAY ID");
		} else {
			CVDisplayLinkSetOutputCallback(_displayLink, displayLinkOutputCallback, (__bridge void*)self);
			CVDisplayLinkStart(_displayLink);
			return YES;
		}
	}
#else
	_displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update:)];
	[_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	return YES;
#endif
	return NO;
}



#if !TARGET_OS_IOS
- (void)update:(float)duration {
# else
- (void)update:(CADisplayLink*)displayLink {
		CFTimeInterval duration = [_displayLink duration];
#endif
		
		if ((_currentTime >= _delay && _speed > 0) || (_speed < 0))// && _currentTime <= _totalTime))
		{
			CGFloat value;
			CGFloat time = (_currentTime - _delay) / _time;
			//make this nicer!
			time = fminf(1.0f, fmaxf(0.0f, time));
			
			value = _ease(time);
			
			[_values enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
			 {
				 [(GSTweenData*)obj updateWithValue:value];
			 }];
			
			if (_startBlock && !_init)
			{
				_startBlock();
				_init = YES;
			}
			if (_updateBlock)
			{
				_updateBlock(time, value);
			}
			
			if (time == 1.0f)
			{
				if (!_isYoyo)
				{
					if (_repeat == 0 || _repeatCount == _repeat)
					{
						[self stop];
					}
					else
					{
						_currentTime = 0.0f;
						_repeatCount++;
					}
				}
				else
				{
					_currentTime = _totalTime;
					_speed *= - 1.0f;
				}
			}
			else if (time == 0.0f && _speed < 0)
			{
				if (_repeat == 0 || _repeatCount == _repeat)
				{
					[self stop];
				}
				else
				{
					_currentTime = 0.0f;
					_speed *= - 1.0f;
					_repeatCount++;
				}
			}
		}
		_currentTime += duration * _speed;
	}
	
	- (void)start
	{
		if(![self setupDisplayLink]) {
			[self stop];
		}
	}
	
	- (void)stop
	{
		id retained = self;
		if (_completeBlock)
		{
			_completeBlock();
		}
#if !TARGET_OS_IOS
		if (_displayLink) {
			CVDisplayLinkRelease(_displayLink);
			_displayLink = nil;
		}
#else
		[_displayLink invalidate];
#endif
		[retained reset];
	}
	
- (void)pause
{
	if (!_isPaused)
	{
#if !TARGET_OS_IOS
		CVDisplayLinkRelease(_displayLink);
		_displayLink = nil;
#else
		[_displayLink invalidate];
#endif
		_isPaused = YES;
	}
}

- (void)resume
{
	if (_isPaused)
	{
		if (![self setupDisplayLink]) {
			[self stop];
			return;
		}
		_isPaused = NO;
	}
}

- (void)reset
{
	
}

@end
