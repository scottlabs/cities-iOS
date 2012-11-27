//
//  City.h
//  Cities
//
//  Created by Kevin Scott on 11/16/12.
//  Copyright (c) 2012 Kevin Scott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface City : NSObject {
    NSString *title;
    NSString *latitude;
    NSString *longitude;
    NSString *city_id;
    NSDictionary *properties;
    CLLocationCoordinate2D coord;
    NSString *image;
}

@property (nonatomic, retain) NSString *image;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *latitude;
@property (nonatomic, retain) NSString *longitude;
@property (nonatomic, retain) NSString *city_id;

- (id)initWithProperties:(NSDictionary *)_properties;
- (NSDictionary * )getProperties;
-(CLLocationCoordinate2D)getCoord;
-(NSString *)getTitle;
@end
