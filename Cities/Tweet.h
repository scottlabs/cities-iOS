//
//  Tweet.h
//  Cities
//
//  Created by Kevin Scott on 11/17/12.
//  Copyright (c) 2012 Kevin Scott. All rights reserved.
//

#import "FeedItem.h"

@interface Tweet : FeedItem {
    NSString *tweet;
    
}


@property (strong, nonatomic) NSString *tweet_id;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *from_user_id;
@property (strong, nonatomic) NSString *from_user_name;
@property (strong, nonatomic) NSString *to_user;
@property (strong, nonatomic) NSString *to_user_id;
@property (strong, nonatomic) NSString *to_user_name;
@property (strong, nonatomic) NSString *geo;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *iso_language_code;
@property (strong, nonatomic) NSString *author_thumb;
@property (strong, nonatomic) NSString *text;


@end
