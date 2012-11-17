//
//  Place.h
//  Cities
//
//  Created by Kevin Scott on 11/14/12.
//  Copyright (c) 2012 Kevin Scott. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Place : NSObject

@property (strong, nonatomic) NSString *place_id;
@property (strong, nonatomic) NSString *woeid;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSString *place_url;
@property (strong, nonatomic) NSString *place_type;
@property (strong, nonatomic) NSString *place_type_id;
@property (strong, nonatomic) NSString *timezone;
@property (strong, nonatomic) NSString *woe_name;


@end
