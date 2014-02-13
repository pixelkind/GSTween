//
//  Expo.m
//  GSTween
//
//  Created by Garrit Schaap on 06.02.14.
//  Copyright (c) 2014 Garrit Schaap. All rights reserved.
//

#import "Expo.h"

@implementation Expo

+ (easeBlock)easeIn
{
    return ^CGFloat(CGFloat time) {
        return time == 0.0f ? 0.0f : pow(2, 10 * (time - 1)) - 0.001;
    };
}
/*
 
 return t == 0 ? b : c * Math.pow(2, 10 * (t / d - 1)) + b;
 */

+ (easeBlock)easeOut
{
    return ^CGFloat(CGFloat time) {
        return 1.001 * (-pow(2, -10 * time) + 1);
    };
}

/*
 return t == d ? b + c : c * (-Math.pow(2, -10 * t / d) + 1) + b;
 */

+ (easeBlock)easeInOut
{
    return ^CGFloat(CGFloat time) {
        if (time == 0)
            return 0;
        if (time >= 1)
            return 1;
        
        time *= 2.0f;
        if (time < 1)
            return 0.5f * pow(2, 10.0f * (time - 1)) - 0.0005f;
        
        return 0.5f * 1.0005f * (-pow(2, -10.0f * --time) + 2.0f);
    };
}

/*
 
 if (t == 0)
 return b;
 
 if (t == d)
 return b + c;
 
 if ((t /= d / 2) < 1)
 return c / 2 * Math.pow(2, 10 * (t - 1)) + b;
 
 return c / 2 * (-Math.pow(2, -10 * --t) + 2) + b;
 */

@end
