//
//  Sine.m
//  GSTween
//
//  Created by Garrit Schaap on 06.02.14.
//  Copyright (c) 2014 Garrit Schaap. All rights reserved.
//

#import "Sine.h"

@implementation Sine

+ (easeBlock)easeIn
{
    return ^CGFloat(CGFloat time) {
        return 1 - cos(time * M_PI_2);
    };
}

+ (easeBlock)easeOut
{
    return ^CGFloat(CGFloat time) {
        return sin(time * M_PI_2);
    };
}

+ (easeBlock)easeInOut
{
    return ^CGFloat(CGFloat time) {
        return - 0.5 * (cos(M_PI * time) - 1);
    };
}

@end
