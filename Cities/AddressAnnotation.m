//
//  AddressAnnotation.m
//  Cities
//
//  Created by Kevin Scott on 11/13/12.
//  Copyright (c) 2012 Kevin Scott. All rights reserved.
//

#import "AddressAnnotation.h"


@implementation AddressAnnotation
@synthesize coordinate, geonameid;

- (id) initWithCoordinate:(CLLocationCoordinate2D)c {
    coordinate = c;
    return self;
}
- (id) initWithCoordinate:(CLLocationCoordinate2D) c andTitle:(NSString*)title {
    coordinate = c;
    _title = title;
    return self;
}
- (id) initWithCoordinate:(CLLocationCoordinate2D)c andTitle:(NSString*)title andGeonameid:(NSNumber *)theGeonameid
{
    geonameid = theGeonameid;
    coordinate = c;
    _title = title;
    return self;
}

- (NSString * )title
{
    return _title;
}

/*
- (CLLocationCoordinate2D)coordinate;
{
    CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude = 37.810000;
    theCoordinate.longitude = -122.477989;
    return theCoordinate;
}*/

// optional
- (NSString *)subtitle
{
    return @"Population: 4,000,000";
}
@end