//
//  Elastic.h
//  GSTween
//
//  Created by Garrit Schaap on 06.02.14.
//  Copyright (c) 2014 Garrit Schaap. All rights reserved.
//

//#import <UIKit/UIKit.h>

typedef CGFloat (^easeBlock)(CGFloat time);

@interface Elastic : NSObject

+ (easeBlock)easeIn;
+ (easeBlock)easeOut;
+ (easeBlock)easeInOut;

+ (CGFloat)pValue;
+ (void)setPValue:(CGFloat)pValue;

+ (CGFloat)aValue;
+ (void)setAValue:(CGFloat)aValue;

@end
