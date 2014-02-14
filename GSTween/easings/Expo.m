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
        return time == 0.0f ? 0.0f : pow(2, 10 * (time - 1));
    };
}

+ (easeBlock)easeOut
{
    return ^CGFloat(CGFloat time) {
        return time == 1.0f ? 1.0f : - pow(2, -10.0f * time) + 1.0f;
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
        if (time < 1.0f)
            return 0.5f * pow(2, 10.0f * (time - 1));
        
        return 0.5f * (-pow(2, -10.0f * --time) + 2.0f);
    };
}

@end
