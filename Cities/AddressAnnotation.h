//
//  AddressAnnotation.h
//  Cities
//
//  Created by Kevin Scott on 11/13/12.
//  Copyright (c) 2012 Kevin Scott. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface AddressAnnotation : NSObject<MKAnnotation> {
	CLLocationCoordinate2D coordinate;
    NSNumber *geonameid;
	NSString *_title;
	NSString *_subtitle;
    
}

@property (nonatomic, retain) NSNumber * geonameid;
- (id) initWithCoordinate:(CLLocationCoordinate2D)c;
- (id) initWithCoordinate:(CLLocationCoordinate2D)c andTitle:(NSString*)title;
- (id) initWithCoordinate:(CLLocationCoordinate2D)c andTitle:(NSString*)title andGeonameid:(NSNumber *)theGeonameid;
@end
