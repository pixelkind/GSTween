//
//  Circular.m
//  GSTween
//
//  Created by Garrit Schaap on 13.02.14.
//  Copyright (c) 2014 Garrit Schaap. All rights reserved.
//

#import "Circular.h"

@implementation Circular

+ (easeBlock)easeIn
{
    return ^CGFloat(CGFloat time) {
        return -(sqrt(1 - time * time) - 1.0f);
    };
}

+ (easeBlock)easeOut
{
    return ^CGFloat(CGFloat time) {
        time -= 1.0f;
        return sqrt(1 - time * time);
    };
}

+ (easeBlock)easeInOut
{
    return ^CGFloat(CGFloat time) {
        time *= 2.0f;
        if (time < 1)
            return - 0.5f * (sqrt(1 - time * time) - 1);
        
        time -= 2.0f;
        return 0.5f * (sqrt(1 - time * time) + 1.0f);
    };
}

@end
