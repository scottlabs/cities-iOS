//
//  FeedLabel.m
//  Cities
//
//  Created by Kevin Scott on 11/17/12.
//  Copyright (c) 2012 Kevin Scott. All rights reserved.
//

#import "FeedLabel.h"

@implementation FeedLabel
- (id) init {
    self = [super init];
    if (self) {
        [self setupStyling];
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupStyling];
    }
    return self;
}
- (id) initWithFrame:(CGRect)frame andColor:(UIColor *)color {
    self = [super initWithFrame:frame];
    if (self) {
        self.textColor = color;
        [self setupStyling];

    }
    return self;
}

- (void)setupStyling {
    self.backgroundColor = [UIColor clearColor];
    
    [self setFont: [UIFont fontWithName: @"HelveticaNeue-Light" size:16]];
    
    if ([UIColor whiteColor] == self.textColor) {
        //NSLog(@"make black shadow");
        self.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.35];
        self.shadowOffset = CGSizeMake(0, -1.0);
    } else if ([UIColor blackColor] == self.textColor) {
        //NSLog(@"make white shadow");
        self.shadowColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:.35];
        self.shadowOffset = CGSizeMake(0, 1.0);
    }
    
    
}
@end
