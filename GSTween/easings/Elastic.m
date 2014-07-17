//
//  Elastic.m
//  GSTween
//
//  Created by Garrit Schaap on 06.02.14.
//  Copyright (c) 2014 Garrit Schaap. All rights reserved.
//

#import "Elastic.h"

@implementation Elastic

static CGFloat _pValue = 0.3f;
static CGFloat _sValue = 0.3f / 4.0f;
static CGFloat _aValue = 1.0f;

+ (easeBlock)easeIn
{
    return ^CGFloat(CGFloat time) {
        if (time == 0.0f)
            return 0.0f;
        if (time == 1.0f)
            return 1.0f;
        
        CGFloat postfix = pow(2.0f, 10.0f * (time -= 1.0f));
        return -(postfix * sin((time - _sValue) * (M_PI * 2) / _pValue));
    };
}

+ (easeBlock)easeOut
{
    return ^CGFloat(CGFloat time) {
        if (time == 0.0f)
            return 0.0f;
        if (time == 1.0f)
            return 1.0f;
        
        return pow(2.0f, (-10.0f * time)) * sin( (time - _sValue) * (M_PI * 2) / _pValue ) + 1.0f;
    };
}

+ (easeBlock)easeInOut
{
    return ^CGFloat(CGFloat time) {
        if (time == 0.0f)
            return 0.0f;
        if (time >= 1.0f)
            return 1.0f;
        
        time *= 2.0f;
        if (time < 1)
        {
            CGFloat postfix = pow(2.0f, 10.0f * (time -= 1.0f));
            return -0.5f * (postfix * sin((time - _sValue) * (M_PI * 2) / _pValue));
        }
        CGFloat postfix = pow(2.0f, - 10.0f * (time -= 1.0f));
        return postfix * sin((time - _sValue) * (M_PI * 2) / _pValue) * 0.5f + 1.0f;
    };
}

+ (CGFloat)pValue
{
    return _pValue;
}

+ (void)setPValue:(CGFloat)pValue
{
    _pValue = pValue;
    if (_aValue < 1.0f)
    {
        _sValue = _pValue / 4.0f;
    }
    else
    {
        _sValue = _pValue / (M_PI * 2) * asin(1.0f / _aValue);
    }
}

+ (CGFloat)aValue
{
    return _aValue;
}

+ (void)setAValue:(CGFloat)aValue
{
    if (aValue >= 1.0f)
    {
        _aValue = aValue;
        _sValue = _pValue / (M_PI * 2) * asin(1.0f / _aValue);
    }
}

@end
