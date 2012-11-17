//
//  MapController.m
//  Cities
//
//  Created by Kevin Scott on 11/13/12.
//  Copyright (c) 2012 Kevin Scott. All rights reserved.
//

#import "MapController.h"

@interface MapController ()

@end

@implementation MapController

@synthesize mapView;

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
    
    CityFeedController *cityFeedController = [[CityFeedController alloc] init];
    [self.navigationController pushViewController:cityFeedController animated:YES];
    return;
    self.mapView.mapType = MKMapTypeStandard;   // also MKMapTypeSatellite or MKMapTypeHybrid
    self.view.backgroundColor = [UIColor yellowColor];
    mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];

    //NSLog(@"%@",city);
    

    [self.view addSubview:mapView];
    [self.mapView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    mapView.delegate = self; 
    
    CLLocationCoordinate2D annotationCoord = {.latitude =  47.640071, .longitude =  -122.129598};
    
//    annotationCoord.latitude = 47.640071;
//    annotationCoord.longitude = -122.129598;
    AddressAnnotation *city = [[AddressAnnotation alloc] initWithCoordinate:annotationCoord andTitle:@"Seattle"];
    
    
    [self.mapView addAnnotation:city];
	// Do any additional setup after loading the view.
}


///// This is code to use a custom image for the pin
- (MKAnnotationView *) mapView:(MKMapView *) mapView viewForAnnotation:(id ) annotation {
    
    MKAnnotationView *customAnnotationView=[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
    UIImage *pinImage = [UIImage imageNamed:@"cityIcon.png"];
    [customAnnotationView setImage:pinImage];
    customAnnotationView.canShowCallout = YES;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [rightButton addTarget:self action:@selector(annotationViewClick:) forControlEvents:UIControlEventTouchUpInside];
    customAnnotationView.rightCalloutAccessoryView = rightButton;
    
    return customAnnotationView;
}

- (void) annotationViewClick
{
    //[_parentViewController showCityFeed];
    CityFeedController *cityFeedController = [[CityFeedController alloc] init];
    [self.navigationController pushViewController:cityFeedController animated:YES];
}




/*
- (MKAnnotationView *) mapView:(MKMapView *)theMapView viewForAnnotation: (id<MKAnnotation>) annotation {
    MKPinAnnotationView *pin = (MKPinAnnotationView *) [theMapView dequeueReusableAnnotationViewWithIdentifier: annotation.title];
    if (pin == nil) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier: annotation.title];
        
    } else {
        pin.annotation = annotation;
    }
    
    pin.pinColor = MKPinAnnotationColorRed;
    pin.animatesDrop = YES;
    pin.canShowCallout = YES;
    return pin;
}
*/


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
