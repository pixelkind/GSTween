//
//  Linear.m
//  GSTween
//
//  Created by Garrit Schaap on 06.02.14.
//  Copyright (c) 2014 Garrit Schaap. All rights reserved.
//

#import "Linear.h"

@implementation Linear

+ (easeBlock)easeNone
{
    return ^CGFloat(CGFloat time) {
        return fminf(1.0f, fmaxf(0.0f, time));
    };
}

@end
