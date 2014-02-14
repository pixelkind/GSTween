//
//  Bounce.m
//  GSTween
//
//  Created by Garrit Schaap on 06.02.14.
//  Copyright (c) 2014 Garrit Schaap. All rights reserved.
//

#import "Bounce.h"

@implementation Bounce

+ (easeBlock)easeIn
{
    return ^CGFloat(CGFloat time) {
        return 1.0f - self.easeOut(1.0f - time);
    };
}

+ (easeBlock)easeOut
{
    return ^CGFloat(CGFloat time) {
        if (time < 1.0f / 2.75f)
        {
            return (7.5625f * time * time);
        }
        else if (time < 2.0f / 2.75f)
        {
            CGFloat postfix = (time -= (1.5f / 2.75f));
            return 7.5625f * postfix * time + 0.75f;
        }
        else if (time < 2.5f / 2.75f)
        {
            CGFloat postfix = (time -= (2.25f / 2.75f));
            return 7.5625f * postfix * time + 0.9375f;
        }
        else
        {
            CGFloat postfix = (time -= (2.625f / 2.75f));
            return 7.5625f * postfix * time + 0.984375f;
        }
    };
}

+ (easeBlock)easeInOut
{
    return ^CGFloat(CGFloat time) {
        time *= 2.0f;
        if (time < 1.0f)
            return (1.0f - [self easeOutWithTime:1.0f - time duration:1.0f]) * 0.5f;
        else
            return [self easeOutWithTime:time - 1.0f duration:1.0f] * 0.5f + 0.5f;
    };
}

+ (CGFloat)easeOutWithTime:(CGFloat)time duration:(CGFloat)duration
{
    time /= duration;
    if (time < 1.0f / 2.75f)
    {
        return (7.5625f * time * time);
    }
    else if (time < 2.0f / 2.75f)
    {
        CGFloat postfix = (time -= (1.5f / 2.75f));
        return 7.5625f * postfix * time + 0.75f;
    }
    else if (time < 2.5f / 2.75f)
    {
        CGFloat postfix = (time -= (2.25f / 2.75f));
        return 7.5625f * postfix * time + 0.9375f;
    }
    else
    {
        CGFloat postfix = (time -= (2.625f / 2.75f));
        return 7.5625f * postfix * time + 0.984375f;
    }
}

@end
