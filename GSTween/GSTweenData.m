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
    const char* type;
    SEL getter = NSSelectorFromString(key);
    SEL setter = NSSelectorFromString([NSString stringWithFormat:@"set%@:", [[[key substringToIndex:1] uppercaseString] stringByAppendingString:[key substringFromIndex:1]]]);
    NSInvocation* getterInvocation;
    NSInvocation* setterInvocation;
    
    if ([target respondsToSelector:getter] && [target respondsToSelector:setter])
    {
        NSLog(@"RESPONDS TO SELECTOR");
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
        //x, y, position, width, height, size, scale, backgroundColor
        if ([key isEqualToString:@"frameOrigin"])
        {
            type = "{CGPoint=ff}";
        }
        else if ([key isEqualToString:@"x"])
        {
            type = "f";
        }
        else if ([key isEqualToString:@"y"])
        {
            type = "f";
        }
        else if ([key isEqualToString:@"width"])
        {
            type = "f";
        }
        else if ([key isEqualToString:@"height"])
        {
            type = "f";
        }
        else if ([key isEqualToString:@"frameSize"])
        {
            type = "{CGSize=ff}";
        }
        else
        {
            type = "f";
        }
    }
    
    NSLog(@"TYPE: %s", type);
    if (strcmp(type, "d") == 0 || strcmp(type, "f") == 0)
    {
        return [[GSTweenDataFloat alloc] initWithValue:value getter:getterInvocation setter:setterInvocation];
    }
    else if (strcmp(type, "{CGRect={CGPoint=dd}{CGSize=dd}}") == 0 || strcmp(type, "{CGRect={CGPoint=ff}{CGSize=ff}}") == 0)
    {
        NSLog(@"RECT!!!!");
        return [[GSTweenDataRect alloc] initWithValue:value getter:getterInvocation setter:setterInvocation];
    }
    else if (strcmp(type, "{CGPoint=dd}") == 0 || strcmp(type, "{CGPoint=dd}") == 0)
    {
        
    }
    else if (strcmp(type, "{CGSize=dd}") == 0 || strcmp(type, "{CGSize=dd}") == 0)
    {
        
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

/*

- (void)setType:(const char*)type
{
    //hier festlegen welcher return type vorliegt:
    //float, CGRect, CGSize, CGPoint, UIColor, int
 
    else if (strcmp(type, "{CGPoint=ff}") == 0)
    {
        _type = PTweenDataTypePoint;
        
        CGPoint toPoint = CGPointFromString(_stringValue);
        _to = [NSValue valueWithCGPoint:toPoint];
        
        CGPoint fromPoint;
        [_getter invoke];
        [_getter getReturnValue:&fromPoint];
        _from = [NSValue valueWithCGPoint:fromPoint];
        
        CGPoint changePoint = CGPointMake(toPoint.x - fromPoint.x, toPoint.y - fromPoint.y);
        _change = [NSValue valueWithCGPoint:changePoint];
    }
    else if (strcmp(type, "{CGSize=ff}") == 0)
    {
        _type = PTweenDataTypeSize;
        
        CGSize toSize = CGSizeFromString(_stringValue);
        _to = [NSValue valueWithCGSize:toSize];
        
        CGSize fromSize;
        [_getter invoke];
        [_getter getReturnValue:&fromSize];
        _from = [NSValue valueWithCGSize:fromSize];
        
        CGSize changeSize = CGSizeMake(toSize.width - fromSize.width, toSize.height - fromSize.height);
        _change = [NSValue valueWithCGSize:changeSize];
    }
 
- (void)updateFloatValue
{
        case PTweenDataTypePoint:
        {
            CGPoint fromPoint = [_from CGPointValue];
            CGPoint changePoint = [_change CGPointValue];
            CGPoint pointValue = CGPointMake(fromPoint.x + changePoint.x * _value, fromPoint.y + changePoint.y * _value);
            [_setter setArgument:&pointValue atIndex:2];
            break;
        }
        case PTweenDataTypeSize:
        {
            CGSize fromSize = [_from CGSizeValue];
            CGSize changeSize = [_change CGSizeValue];
            CGSize sizeValue = CGSizeMake(fromSize.width + changeSize.width * _value, fromSize.height + changeSize.height * _value);
            [_setter setArgument:&sizeValue atIndex:2];
            break;
        }
*/

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