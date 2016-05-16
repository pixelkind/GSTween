//
//  GSTweenData.h
//  GSTween
//
//  Created by Garrit Schaap on 06.02.14.
//  Copyright (c) 2014 Garrit Schaap. All rights reserved.
//
#if TARGET_OS_IOS
#define GSTweenRectFromString CGRectFromString
#define GSTweenSizeFromString CGSizeFromString
#define GSTweenPointFromString CGPointFromString
#else
#define GSTweenRectFromString NSRectFromString
#define GSTweenSizeFromString NSSizeFromString
#define GSTweenPointFromString NSPointFromString
#endif

@interface GSTweenData : NSObject
{
    NSString* _key;
    NSObject* _target;
    NSInvocation* _getter;
    NSInvocation* _setter;
}

+ (id)tweenDataWithValue:(NSObject*)value key:(NSString*)key target:(NSObject*)target;
- (void)setup;
- (void)updateWithValue:(CGFloat)value;

@end


@interface GSTweenDataFloat : GSTweenData
{
    CGFloat _from;
    CGFloat _to;
    CGFloat _change;
}


- (id)initWithValue:(NSObject*)value getter:(NSInvocation*)getter setter:(NSInvocation*)setter;

@end

@interface GSTweenDataRect : GSTweenData
{
    CGRect _from;
    CGRect _to;
    CGRect _change;
}

- (id)initWithValue:(NSObject*)value getter:(NSInvocation*)getter setter:(NSInvocation*)setter;

@end


@interface GSTweenDataInteger : GSTweenData
{
    NSInteger _from;
    NSInteger _to;
    NSInteger _change;
}

- (id)initWithValue:(NSObject*)value getter:(NSInvocation*)getter setter:(NSInvocation*)setter;

@end


@interface GSTweenDataPoint : GSTweenData
{
    CGPoint _from;
    CGPoint _to;
    CGPoint _change;
}

- (id)initWithValue:(NSObject*)value getter:(NSInvocation*)getter setter:(NSInvocation*)setter;

@end


@interface GSTweenDataSize : GSTweenData
{
    CGSize _from;
    CGSize _to;
    CGSize _change;
}

- (id)initWithValue:(NSObject*)value getter:(NSInvocation*)getter setter:(NSInvocation*)setter;

@end
