//
//  GradientView.h
//  Cities
//
//  Created by Kevin Scott on 11/18/12.
//  Copyright (c) 2012 Kevin Scott. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface GradientView : UIView {
    NSMutableArray *gradientsArray;
    float opacity;
    float degrees;
}

@property (nonatomic, retain) NSMutableArray *gradientsArray;
enum gradients
{
    OPAQUE_GRADIENT,
    BLUE_GRADIENT,
    METAL_GRADIENT
};
typedef NSInteger gradients;


- (id)initWithFrame:(CGRect)frame andGradient:(int)gradient andRotation:(float)_degrees;
- (id)initWithFrame:(CGRect)frame andGradient:(int)gradient andRotation:(float)_degrees andOpacity:(float)_opacity;
- (CAGradientLayer *) drawGradient:(NSArray *)_colors;
- (void)getGradients;
@end
