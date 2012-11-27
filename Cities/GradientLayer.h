//
//  GradientLayer.h
//  Cities
//
//  Created by Kevin Scott on 11/18/12.
//  Copyright (c) 2012 Kevin Scott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface GradientLayer : UIView

+(CAGradientLayer*) greyGradient;

+(CAGradientLayer*) blueGradient;

+(CAGradientLayer*) opaqueGradient;
//- (void)rotate:(float)degrees;
@end
