//
//  Tweet.m
//  Cities
//
//  Created by Kevin Scott on 11/17/12.
//  Copyright (c) 2012 Kevin Scott. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

@synthesize tweet_id, from_user_id, from_user_name, to_user, to_user_id, to_user_name;
@synthesize geo, location, iso_language_code, text;

- (id) initWithItem:(NSDictionary *)item {
    self = [super init];
    if (self) {
        //tweet_id = item.item_id;
        tweet_id = [item objectForKey:@"id"];
        date = [item objectForKey:@"date"];
        timestamp = [item objectForKey:@"timestamp"];
        author = [item objectForKey:@"author"];
        from_user_id = [item objectForKey:@"from_user_id"];
        from_user_name = [item objectForKey:@"from_user_name"];
        to_user = [item objectForKey:@"to_user"];
        to_user_id = [item objectForKey:@"to_user_id"];
        to_user_name = [item objectForKey:@"to_user_name"];
        geo = [item objectForKey:@"geo"];
        location = [item objectForKey:@"location"];
        iso_language_code = [item objectForKey:@"iso_language_code"];
        author_thumb = [item objectForKey:@"author_thumb"];
        text = [item objectForKey:@"text"];
    }
    return self;
}

@end
