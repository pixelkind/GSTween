//
//  Quadratic.m
//  GSTween
//
//  Created by Garrit Schaap on 13.02.14.
//  Copyright (c) 2014 Garrit Schaap. All rights reserved.
//

#import "Quadratic.h"

@implementation Quadratic

+ (easeBlock)easeIn
{
    return ^CGFloat(CGFloat time) {
        return time * time;
    };
}

+ (easeBlock)easeOut
{
    return ^CGFloat(CGFloat time) {
        return - time * (time - 2.0f);
    };
}

+ (easeBlock)easeInOut
{
    return ^CGFloat(CGFloat time) {
        time *= 2.0f;
        if (time < 1)
            return 0.5f * time * time;
        
        --time;
        return -0.5f * (time * (time - 2.0f) - 1.0f);
    };
}

@end
