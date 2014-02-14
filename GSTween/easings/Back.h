//
//  Back.h
//  GSTween
//
//  Created by Garrit Schaap on 13.02.14.
//  Copyright (c) 2014 Garrit Schaap. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef CGFloat (^easeBlock)(CGFloat time);

@interface Back : NSObject

+ (easeBlock)easeIn;
+ (easeBlock)easeOut;
+ (easeBlock)easeInOut;
+ (CGFloat)sValue;
+ (void)setSValue:(CGFloat)sValue;

@end
