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
        //Need to implement
        return time;
    };
}

+ (easeBlock)easeOut
{
    return ^CGFloat(CGFloat time) {
        if (time < 1.0 / 2.75)
        {
            return (7.5625f * time * time);
        }
        else if (time < 2.0 / 2.75)
        {
            return (7.5625f * (time -= (1.5f / 2.75f)) * time + 0.75f);
        }
        else if (time < 2.5 / 2.75)
        {
            return (7.5625f * (time -= (2.25f / 2.75f)) * time + 0.9375f);
        }
        else
        {
            return (7.5625f * (time -= (2.625f / 2.75f)) * time + 0.984375f);
        }
    };
}

+ (easeBlock)easeInOut
{
    return ^CGFloat(CGFloat time) {
        //Need to implement
        return time;
    };
}

@end
