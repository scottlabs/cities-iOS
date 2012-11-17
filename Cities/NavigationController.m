//
//  NavigationController.m
//  Cities
//
//  Created by Kevin Scott on 11/13/12.
//  Copyright (c) 2012 Kevin Scott. All rights reserved.
//

#import "NavigationController.h"



@interface NavigationController ()

@end


@implementation NavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self.navigationBar setTintColor:[UIColor brownColor]];
    	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
