//
//  Photo.h
//  Cities
//
//  Created by Kevin Scott on 11/14/12.
//  Copyright (c) 2012 Kevin Scott. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *owner;
@property (strong, nonatomic) NSString *secret;
@property (strong, nonatomic) NSString *server;
@property (strong, nonatomic) NSString *farm;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *ispublic;
@property (strong, nonatomic) NSString *isfriend;
@property (strong, nonatomic) NSString *isfamily;


@end
