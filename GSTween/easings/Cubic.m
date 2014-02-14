//
//  Cubic.m
//  GSTween
//
//  Created by Garrit Schaap on 13.02.14.
//  Copyright (c) 2014 Garrit Schaap. All rights reserved.
//

#import "Cubic.h"

@implementation Cubic

+ (easeBlock)easeIn
{
    return ^CGFloat(CGFloat time) {
        return time * time * time;
    };
}

+ (easeBlock)easeOut
{
    return ^CGFloat(CGFloat time) {
        time -= 1.0f;
        return time * time * time + 1.0f;
    };
}

+ (easeBlock)easeInOut
{
    return ^CGFloat(CGFloat time) {
        time *= 2.0f;
        if (time < 1.0f)
            return 0.5f * time * time * time;
        
        time -= 2.0f;
        return 0.5f * (time * time * time + 2.0f);
    };
}

@end
