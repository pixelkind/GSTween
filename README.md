GSTween
=======

A Tweening Library for Objective-C

Please excuse the actual README. The documentation is currently being created and will be updated in the next days.


## Installation

### Source files


### Static library


## Requirements

* Xcode 5
* Tested on iOS 6.1 and higher
* ARC


## Usage


### Basics

As a first simple example, we want to tween the value of a `UIView` fram to `CGRectMake(0, 0, 320, 568)` with a bouncing ease out.

1. Add this import to the top of your file:
   
   ```objc
   #import <GSTween/GSTween.h>
   #import <GSTween/Bounce.h>
   ```
   
2. Create a GSTween Object to create the simplest animation:
   
   ```objc
   [[GSTween alloc] initWithTarget:self time:3.0f ease:[Bounce easeOut] params:@{ @"frame": @"{{0,0},{320,568}}" }];
   ```
   
   In this case we create a tween inside a `UIView`. We set the target to self, the animation time to 3 seconds and adding a bouncing ease out. Next we set the parameters in the `NSDictionary`. We want to tween the property frame, so we name the key of the dictionary the same and than we add the value we want to tween to. What you see in this example is the string representation for a CGRect.
   
Currently you can tween any property that is not readonly of the type `CGFloat`, `NSInteger`, `CGRect`, `CGSize` or `CGPoint`.


### Special properties

There are some special properties to use: `x`, `y`, `width`, `height`, `frameOrigin`, `frameSize`. If you have a `UIView` and you haven't a property named like one of these, GSTween will automatically create a tween of the frame property for you.


### Easings

You can choose between the following easings:
* Back (easeIn, easeOut, easeInOut, here you also have some parameters)
* Bounce (easeIn, easeOut, easeInOut)
* Circular (easeIn, easeOut, easeInOut)
* Cubic (easeIn, easeOut, easeInOut)
* Elastic (easeIn, easeOut, easeInOut, here you also have some parameters)
* Expo (easeIn, easeOut, easeInOut)
* Linear (easeNone)
* Quadratic (easeIn, easeOut, easeInOut)
* Quintic (easeIn, easeOut, easeInOut)
* Sine (easeIn, easeOut, easeInOut)

The easings based on the equations of Robert Penner and they are licensed under the BSD License. For more information, go here: http://www.robertpenner.com/easing_terms_of_use.html

But you can also create your own easings or use this easings in your own project. They are block-based and you can easily replace them, or create new ones:

```objc
typedef CGFloat (^easeBlock)(CGFloat time);
```


### Optional parameters

You can use the following optional parameters in the params-dictionary:

* kGSTweenDelay (CGFloat, default 0.0f)
    * Add a delay to the beginning of the tween
* kGSTweenYoYo (BOOL, default NO)
    * Add a YoYo-effect to your tween, playing the tween forward and afterwards backward
* kGSTweenAutoStart (BOOL, default YES)
    * Prevent the tween from auto-start, you can control with `[tween start]` when you want to start your tween
* kGSTweenRepeat (NSInteger, default 0)
    * Control the number of repeats for a tween, -1 is an endless repeat
* kGSTweenSpeed (CGFloat, default 1.0f)
    * Control the playback speed of your tween or play it backwards
* kGSTweenOnStart
    * A block that is fired when the tween starts
* kGSTweenOnUpdate
    * A block that is fired when the tween is updated, where progress is the current time elapsed (from 0.0f - 1.0f) and value the easing value (from 0.0f - 1.0f) `typedef void (^updateTweenBlock)(CGFloat progress, CGFloat value);`
* kGSTweenOnComplete
    * A block that is fired when the tween stops


## License

This Library is licensed under the MIT License. Please refer to the LICENSE.txt for more information.
