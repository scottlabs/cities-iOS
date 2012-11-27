//
//  MapController.m
//  Cities
//
//  Created by Kevin Scott on 11/13/12.
//  Copyright (c) 2012 Kevin Scott. All rights reserved.
//

#import "MapController.h"
#include <stdlib.h>


@interface MapController ()

@end

@implementation MapController

@synthesize mapView;
- (id)init {
    self = [super init];
    if (self) {
        [self loadCities];
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self loadCities];
        
    }
    return self;
}
- (void)loadCities {

    [self.navigationController.navigationBar setHidden:TRUE];
    
    cities = [[NSMutableArray alloc] initWithObjects:
              [[City alloc] initWithProperties:[[NSDictionary alloc] initWithObjectsAndKeys:
                                                @"21",@"city_id",
                                                @"losangeles.jpg",@"image",
                                                @"Los Angeles", @"title",
                                                @"34.052200", @"latitude",
                                                @"-118.242800", @"longitude", nil]],
              [[City alloc] initWithProperties:[[NSDictionary alloc] initWithObjectsAndKeys:
                                                @"1",@"city_id",
                                                @"nyc.jpg",@"image",
                                                @"New York", @"title",
                                                @"40.714200", @"latitude",
                                                @"-74.006400", @"longitude", nil]],
              [[City alloc] initWithProperties:[[NSDictionary alloc] initWithObjectsAndKeys:
                                                @"31",@"city_id",
                                                @"chicago.jpg",@"image",
                                                @"Chicago", @"title",
                                                @"41.850000", @"latitude",
                                                @"-87.650000", @"longitude", nil]],
              [[City alloc] initWithProperties:[[NSDictionary alloc] initWithObjectsAndKeys:
                                                @"41",@"city_id",
                                                @"sanfrancisco.jpg",@"image",
                                                @"San Francisco", @"title",
                                                @"37.7750", @"latitude",
                                                @"-122.4183", @"longitude", nil]],
              [[City alloc] initWithProperties:[[NSDictionary alloc] initWithObjectsAndKeys:
                                                @"51",@"city_id",
                                                @"seattle.jpg",@"image",
                                                @"Seattle", @"title",
                                                @"47.640071", @"latitude",
                                                @"-122.129598", @"longitude", nil]],
              [[City alloc] initWithProperties:[[NSDictionary alloc] initWithObjectsAndKeys:
                                                @"61",@"city_id",
                                                @"pittsburgh.jpg",@"image",
                                                @"Pittsburgh", @"title",
                                                @"40.4406", @"latitude",
                                                @"-79.9961", @"longitude", nil]],
              [[City alloc] initWithProperties:[[NSDictionary alloc] initWithObjectsAndKeys:
                                                @"71",@"city_id",
                                                @"boston.jpg",@"image",
                                                @"Boston", @"title",
                                                @"42.3583", @"latitude",
                                                @"-71.0603", @"longitude", nil]],
              [[City alloc] initWithProperties:[[NSDictionary alloc] initWithObjectsAndKeys:
                                                @"81",@"city_id",
                                                @"denver.jpg",@"image",
                                                @"Denver", @"title",
                                                @"39.7392", @"latitude",
                                                @"-104.9842", @"longitude", nil]],
              [[City alloc] initWithProperties:[[NSDictionary alloc] initWithObjectsAndKeys:
                                                @"82",@"city_id",
                                                @"neworleans.jpg",@"image",
                                                @"New Orleans", @"title",
                                                @"29.9728", @"latitude",
                                                @"-90.059", @"longitude", nil]],
              nil];
    
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
    self.mapView.mapType = MKMapTypeStandard;   // also MKMapTypeSatellite or MKMapTypeHybrid
    //self.view.backgroundColor = [UIColor yellowColor];
    mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];

    //NSLog(@"%@",city);
    

    [self.view addSubview:mapView];
    [self.mapView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    mapView.delegate = self; 


    for (int i=0;i<[cities count];i++) {
  
        City *city = [cities objectAtIndex:i];
  
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];

        AddressAnnotation *addAnn = [[AddressAnnotation alloc] initWithCoordinate:[city getCoord] andTitle:[city getTitle] andGeonameid:[NSNumber numberWithInt:i]];
  
        [self.mapView addAnnotation:addAnn];
  
    }
    
    
    if (0) {    // skip to city
        int r = arc4random() % [cities count];
        r = 1;
        City *city = [cities objectAtIndex:r];
        NSLog(@"%@",city);
        CityFeedController *cityFeedController = [[CityFeedController alloc] initWithCity:[[City alloc] initWithProperties:[city getProperties]]];
        //CityFeedController *cityFeedController = [[CityFeedController alloc] initWithNavigatorURL:nil query:nil];
        [self.navigationController pushViewController:cityFeedController animated:YES];
        return;
    }

	// Do any additional setup after loading the view.
}


///// This is code to use a custom image for the pin
- (MKAnnotationView *) mapView:(MKMapView *) mapView viewForAnnotation:(id ) annotation {
    
    MKAnnotationView *customAnnotationView=[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
    
    //UIView *pinImageContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 67)];
    UIImage *pinImage = [UIImage imageNamed:@"pin.png"];
    //[pinImageContainer addSubview:pinImage];

    [customAnnotationView setImage:pinImage];
    customAnnotationView.canShowCallout = YES;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [rightButton addTarget:self action:@selector(annotationViewClick:) forControlEvents:UIControlEventTouchUpInside];
    customAnnotationView.rightCalloutAccessoryView = rightButton;
    //NSInteger tempInt = [annotation.geonameid integerValue];
    AddressAnnotation *ann = annotation;
    [rightButton setTag:[ann.geonameid intValue]];
    //rightButton.tag = tempInt;
    return customAnnotationView;
}

- (void) annotationViewClick:(id)sender
{
    //[_parentViewController showCityFeed];
    UIButton *temp = sender;
    int index = temp.tag;

    City *city = [cities objectAtIndex:index];

    CityFeedController *cityFeedController = [[CityFeedController alloc] initWithCity:city];
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
