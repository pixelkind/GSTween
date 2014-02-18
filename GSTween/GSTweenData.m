//
//  GSTweenData.m
//  GSTween
//
//  Created by Garrit Schaap on 06.02.14.
//  Copyright (c) 2014 Garrit Schaap. All rights reserved.
//

#import "GSTweenData.h"

@implementation GSTweenData

+ (id)tweenDataWithValue:(NSObject*)value key:(NSString*)key target:(NSObject*)target
{
    NSArray* reserved = @[ @"x", @"y", @"width", @"height", @"frameOrigin", @"frameSize" ];
    const char* type = "";
    SEL getter = NSSelectorFromString(key);
    SEL setter = NSSelectorFromString([NSString stringWithFormat:@"set%@:", [[[key substringToIndex:1] uppercaseString] stringByAppendingString:[key substringFromIndex:1]]]);
    NSInvocation* getterInvocation;
    NSInvocation* setterInvocation;
    
    
    if ((![target respondsToSelector:getter] || ![target respondsToSelector:setter]) && [reserved indexOfObject:key] != NSNotFound)
    {
        if ([key isEqualToString:@"frameOrigin"])
        {
            key = @"frame";
            CGRect frame = [(id)target frame];
            value = [NSString stringWithFormat:@"{%@,{%f,%f}}", value, frame.size.width, frame.size.height];
        }
        else if ([key isEqualToString:@"x"])
        {
            key = @"frame";
            CGRect frame = [(id)target frame];
            value = [NSString stringWithFormat:@"{{%f,%f},{%f,%f}}", [(NSNumber*)value floatValue], frame.origin.y, frame.size.width, frame.size.height];
        }
        else if ([key isEqualToString:@"y"])
        {
            key = @"frame";
            CGRect frame = [(id)target frame];
            value = [NSString stringWithFormat:@"{{%f,%f},{%f,%f}}", frame.origin.x, [(NSNumber*)value floatValue], frame.size.width, frame.size.height];
        }
        else if ([key isEqualToString:@"width"])
        {
            key = @"frame";
            CGRect frame = [(id)target frame];
            value = [NSString stringWithFormat:@"{{%f,%f},{%f,%f}}", frame.origin.x, frame.origin.y, [(NSNumber*)value floatValue], frame.size.height];
        }
        else if ([key isEqualToString:@"height"])
        {
            key = @"frame";
            CGRect frame = [(id)target frame];
            value = [NSString stringWithFormat:@"{{%f,%f},{%f,%f}}", frame.origin.x, frame.origin.y, frame.size.width, [(NSNumber*)value floatValue]];
        }
        else if ([key isEqualToString:@"frameSize"])
        {
            key = @"frame";
            CGRect frame = [(id)target frame];
            value = [NSString stringWithFormat:@"{{%f,%f},%@}", frame.origin.x, frame.origin.y, value];
        }
        getter = NSSelectorFromString(key);
        setter = NSSelectorFromString([NSString stringWithFormat:@"set%@:", [[[key substringToIndex:1] uppercaseString] stringByAppendingString:[key substringFromIndex:1]]]);
    }
    
    if ([target respondsToSelector:getter] && [target respondsToSelector:setter])
    {
        NSMethodSignature* getterSignature = [target methodSignatureForSelector:getter];
        NSMethodSignature* setterSignature = [target methodSignatureForSelector:setter];
        
        getterInvocation = [NSInvocation invocationWithMethodSignature:getterSignature];
        [getterInvocation setSelector:getter];
        [getterInvocation setTarget:target];
        
        setterInvocation = [NSInvocation invocationWithMethodSignature:setterSignature];
        [setterInvocation setSelector:setter];
        [setterInvocation setTarget:target];
        
        type = [[getterInvocation methodSignature] methodReturnType];
    }
    else
    {
        NSLog(@"GSTween Warning: Property was not found on target!");
    }
    
    if (strcmp(type, "d") == 0 || strcmp(type, "f") == 0)
    {
        return [[GSTweenDataFloat alloc] initWithValue:value getter:getterInvocation setter:setterInvocation];
    }
    else if (strcmp(type, "{CGRect={CGPoint=dd}{CGSize=dd}}") == 0 || strcmp(type, "{CGRect={CGPoint=ff}{CGSize=ff}}") == 0)
    {
        return [[GSTweenDataRect alloc] initWithValue:value getter:getterInvocation setter:setterInvocation];
    }
    else if (strcmp(type, "{CGPoint=dd}") == 0 || strcmp(type, "{CGPoint=dd}") == 0)
    {
        return [[GSTweenDataPoint alloc] initWithValue:value getter:getterInvocation setter:setterInvocation];
    }
    else if (strcmp(type, "{CGSize=dd}") == 0 || strcmp(type, "{CGSize=dd}") == 0)
    {
        return [[GSTweenDataSize alloc] initWithValue:value getter:getterInvocation setter:setterInvocation];
    }
    else if (strcmp(type, "i") == 0 || strcmp(type, "q") == 0)
    {
        return [[GSTweenDataInteger alloc] initWithValue:value getter:getterInvocation setter:setterInvocation];
    }
    
    return nil;
}

- (id)initWithValue:(NSObject*)value andKey:(NSString*)key andTarget:(NSObject*)target
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (void)setup
{
    
}

- (void)updateWithValue:(CGFloat)value
{
    
}

@end


@implementation GSTweenDataFloat

- (id)initWithValue:(NSObject *)value getter:(NSInvocation *)getter setter:(NSInvocation *)setter
{
    self = [super init];
    if (self)
    {
        _to = [(NSNumber*)value floatValue];
        _getter = getter;
        _setter = setter;
        [self setup];
    }
    return self;
}

- (void)setup
{
    [_getter invoke];
    [_getter getReturnValue:&_from];
    _change = _to - _from;
}

- (void)updateWithValue:(CGFloat)value
{
    value = _from + _change * value;
    [_setter setArgument:&value atIndex:2];
    [_setter invoke];
}

@end


@implementation GSTweenDataRect

- (id)initWithValue:(NSObject *)value getter:(NSInvocation *)getter setter:(NSInvocation *)setter
{
    self = [super init];
    if (self)
    {
        _to = CGRectFromString((NSString*)value);
        _getter = getter;
        _setter = setter;
        [self setup];
    }
    return self;
}

- (void)setup
{
    [_getter invoke];
    [_getter getReturnValue:&_from];
    _change = CGRectMake(_to.origin.x - _from.origin.x, _to.origin.y - _from.origin.y, _to.size.width - _from.size.width, _to.size.height - _from.size.height);
}

- (void)updateWithValue:(CGFloat)value
{
    CGRect rectValue = CGRectMake(_from.origin.x + _change.origin.x * value, _from.origin.y + _change.origin.y * value, _from.size.width + _change.size.width * value, _from.size.height + _change.size.height * value);
    [_setter setArgument:&rectValue atIndex:2];
    [_setter invoke];
}

@end


@implementation GSTweenDataInteger

- (id)initWithValue:(NSObject *)value getter:(NSInvocation *)getter setter:(NSInvocation *)setter
{
    self = [super init];
    if (self)
    {
        _to = [(NSNumber*)value integerValue];
        _getter = getter;
        _setter = setter;
        [self setup];
    }
    return self;
}

- (void)setup
{
    [_getter invoke];
    [_getter getReturnValue:&_from];
    _change = _to - _from;
}

- (void)updateWithValue:(CGFloat)value
{
    NSInteger intValue = _from + _change * value;
    [_setter setArgument:&intValue atIndex:2];
    [_setter invoke];
}

@end


@implementation GSTweenDataPoint

- (id)initWithValue:(NSObject *)value getter:(NSInvocation *)getter setter:(NSInvocation *)setter
{
    self = [super init];
    if (self)
    {
        _to = CGPointFromString((NSString*)value);
        _getter = getter;
        _setter = setter;
        [self setup];
    }
    return self;
}

- (void)setup
{
    [_getter invoke];
    [_getter getReturnValue:&_from];
    _change = CGPointMake(_to.x - _from.x, _to.y - _from.y);
}

- (void)updateWithValue:(CGFloat)value
{
    CGPoint pointValue = CGPointMake(_from.x + _change.x * value, _from.y + _change.y * value);
    [_setter setArgument:&pointValue atIndex:2];
    [_setter invoke];
}

@end


@implementation GSTweenDataSize

- (id)initWithValue:(NSObject *)value getter:(NSInvocation *)getter setter:(NSInvocation *)setter
{
    self = [super init];
    if (self)
    {
        _to = CGSizeFromString((NSString*)value);
        _getter = getter;
        _setter = setter;
        [self setup];
    }
    return self;
}

- (void)setup
{
    [_getter invoke];
    [_getter getReturnValue:&_from];
    _change = CGSizeMake(_to.width - _from.width, _to.height - _from.height);
}

- (void)updateWithValue:(CGFloat)value
{
    CGSize sizeValue = CGSizeMake(_from.width + _change.width * value, _from.height + _change.height * value);
    [_setter setArgument:&sizeValue atIndex:2];
    [_setter invoke];
}

@end
