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

+ (easeBlock)easeIn
{
    return ^CGFloat(CGFloat time) {
        if (time == 0)
            return 0;
        if (time == 1)
            return 1;
        
        CGFloat postfix = pow(2, 10 * (time -= 1));
        return -(postfix * sin((time - _sValue)*(2 * M_PI) / _pValue));
    };
}

+ (easeBlock)easeOut
{
    return ^CGFloat(CGFloat time) {
        if (time == 0.0f)
            return 0.0f;
        if (time == 1.0f)
            return 1.0f;
        
        return pow(2, (-10.0f * time)) * sin( (time - _sValue) * (2 * M_PI) / _pValue ) + 1.0f;
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
            CGFloat postfix = pow(2, 10 * (time -= 1.0f));
            return -0.5f * (postfix * sin((time - _sValue) * (2.0f * M_PI) / _pValue));
        }
        CGFloat postfix = pow(2, - 10.0f * (time -= 1.0f));
        return postfix * sin((time - _sValue) * (2.0f * M_PI) / _pValue) * 0.5f + 1.0f;
    };
}

/*
 if (t == 0)
 return b;
 
 if ((t /= d / 2) == 2)
 return b + c;
 
 if (!p)
 p = d * (0.3 * 1.5);
 
 var s:Number;
 if (!a || a < Math.abs(c))
 {
 a = c;
 s = p / 4;
 }
 else
 {
 s = p / (2 * Math.PI) * Math.asin(c / a);
 }
 
 if (t < 1)
 {
 return -0.5 * (a * Math.pow(2, 10 * (t -= 1)) *
 Math.sin((t * d - s) * (2 * Math.PI) /p)) + b;
 }
 
 return a * Math.pow(2, -10 * (t -= 1)) *
 Math.sin((t * d - s) * (2 * Math.PI) / p ) * 0.5 + c + b;
 */

+ (CGFloat)pValue
{
    return _pValue;
}

+ (void)setPValue:(CGFloat)pValue
{
    _pValue = pValue;
    _sValue = _pValue / 4.0f;
}

@end
