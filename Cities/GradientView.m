//
//  GradientView.m
//  Cities
//
//  Created by Kevin Scott on 11/18/12.
//  Copyright (c) 2012 Kevin Scott. All rights reserved.
//

#import "GradientView.h"

@implementation GradientView

@synthesize gradientsArray;

- (void)getGradients {
            //NSLog(@"a");
    gradientsArray = [[NSMutableArray alloc] init];
          //  NSLog(@"b");
    if (! opacity) { opacity = 1.0; }
        //NSLog(@"c");
    [gradientsArray setObject:[[NSArray alloc] initWithObjects:
                               [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:(1.0*opacity)],
                               [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0)  alpha:(0.0*opacity)], nil] atIndexedSubscript:OPAQUE_GRADIENT];
            //NSLog(@"c1");
/*
    [gradientsArray setObject:[[NSArray alloc] initWithObjects:
                               [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:(1.0*opacity)],
                               [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0)  alpha:(0.0*opacity)], nil] atIndexedSubscript:METAL_GRADIENT];*/
          //  NSLog(@"c2");
    [gradientsArray setObject:[[NSArray alloc] initWithObjects:
                               [UIColor colorWithRed:(120/255.0) green:(135/255.0) blue:(150/255.0) alpha:(1.0*opacity)],
                               [UIColor colorWithRed:(57/255.0)  green:(79/255.0)  blue:(96/255.0)  alpha:(1.0*opacity)], nil] atIndexedSubscript:BLUE_GRADIENT];

          //  NSLog(@"d");
    
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame andGradient:(int)gradient andRotation:(float)_degrees {
    self = [self initWithFrame:frame];
    if (self) {
        degrees = _degrees;
        // Initialization code
        //NSLog(@"1");
        [self getGradients];
        //NSLog(@"2");
        CAGradientLayer *layer = [self drawGradient:[gradientsArray objectAtIndex:gradient]];
          //      NSLog(@"3");
        layer.frame = self.bounds;
        [self.layer insertSublayer:layer atIndex:0];
        
        //CGAffineTransform current = self.transform;
        

        //float radians = degrees * (M_PI/180);
        //[self setTransform:CGAffineTransformRotate(current,radians)];
    }
    return self;
    
}
- (id)initWithFrame:(CGRect)frame andGradient:(int)gradient andRotation:(float)_degrees andOpacity:(float)_opacity {
    opacity = _opacity;
    self = [self initWithFrame:frame andGradient:gradient andRotation:_degrees];
    return self;
}
- (CAGradientLayer *) drawGradient:(NSArray *)_colors {
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    UIColor *color;
    for (int i=0;i<[_colors count];i++) {
        color = [_colors objectAtIndex:i];
        [colors addObject:(id)color.CGColor];
    }
    
    
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    //NSLog(@"Degrees: %f",degrees);
    if (degrees==0) {
        layer.startPoint    = CGPointMake(0.5,0.0);
        layer.endPoint      = CGPointMake(0.5,1.0);
    } else if (degrees==90) {
        layer.startPoint    = CGPointMake(1.0,0.5);
        layer.endPoint      = CGPointMake(0.0,0.5);
    } else if (degrees==180) {
        layer.startPoint    = CGPointMake(0.5,1.0);
        layer.endPoint      = CGPointMake(0.5,0.0);
    } else if (degrees==270) {
        layer.startPoint    = CGPointMake(0.0,0.5);
        layer.endPoint      = CGPointMake(1.0,0.5);
    }
    
    layer.colors = colors;

    return layer;
}

@end
