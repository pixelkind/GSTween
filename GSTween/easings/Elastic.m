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
        if (time >= 1)
            return 1;
        
        return -(pow(2, 10 * (time -= 1)) * sin((time - _sValue)*(2 * M_PI) / _pValue));
    };
}

+ (easeBlock)easeOut
{
    return ^CGFloat(CGFloat time) {
        if (time == 0.0f)
            return 0.0f;
        if (time >= 1.0f)
            return 1.0f;
        
        return (pow(2, (-20.0f * time)) * sin( (time - _sValue) * (2 * M_PI) / _pValue ) + 1);
    };
}

+ (easeBlock)easeInOut
{
    return ^CGFloat(CGFloat time) {
        //Need to implement
        return time;
    };
}

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
