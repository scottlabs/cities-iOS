//
//  City.m
//  Cities
//
//  Created by Kevin Scott on 11/16/12.
//  Copyright (c) 2012 Kevin Scott. All rights reserved.
//

#import "City.h"

@implementation City

@synthesize title, latitude, longitude, city_id, image;
- (id)initWithProperties:(NSDictionary *)_properties {
    if (self = [self init]) {
        properties = _properties;
        [self setValuesForKeysWithDictionary:properties];
    }
    if (latitude && longitude) {

        
        coord = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
    }
    return self;
}
- (NSDictionary * )getProperties {
    return properties;
}
/*
-(id)initWithDictionary:(NSDictionary *)dict {

    coord = CLLocationCoordinate2DMake(34.052200,-118.242800);
    title = [dict objectForKey:@"title"];
    return [self init];
}*/
-(CLLocationCoordinate2D)getCoord {
    return coord;
}
-(NSString *)getTitle {
    return title;
}
@end
