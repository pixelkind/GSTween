//
//  Back.m
//  GSTween
//
//  Created by Garrit Schaap on 13.02.14.
//  Copyright (c) 2014 Garrit Schaap. All rights reserved.
//

#import "Back.h"

@implementation Back

static CGFloat _sValue = 1.70158f;

+ (easeBlock)easeIn
{
    return ^CGFloat(CGFloat time) {
        return time * time * ((_sValue + 1) * time - _sValue);
    };
}

+ (easeBlock)easeOut
{
    return ^CGFloat(CGFloat time) {
        time -= 1.0f;
        return time * time * ((_sValue + 1) * time + _sValue) + 1;
    };
}

+ (easeBlock)easeInOut
{
    return ^CGFloat(CGFloat time) {
        time *= 2.0f;
        CGFloat s = _sValue * 1.525f;
        if (time < 1)
            return 0.5f * (time * time * ((s + 1) * time - s));
        
        time -= 2.0f;
        return 0.5f * (time * time * ((s + 1) * time + s) + 2);
    };
}

+ (CGFloat)sValue
{
    return _sValue;
}

+ (void)setSValue:(CGFloat)sValue
{
    _sValue = sValue;
}

@end
