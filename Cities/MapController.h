//
//  MapController.h
//  Cities
//
//  Created by Kevin Scott on 11/13/12.
//  Copyright (c) 2012 Kevin Scott. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "AddressAnnotation.h"
#import "CityFeedController.h"
#import "City.h"
@interface MapController : UIViewController <MKMapViewDelegate> {
    MKMapView *mapView;
    NSMutableArray *cities;
}

@property (nonatomic, retain) MKMapView *mapView;
- (void)loadCities;

@end
