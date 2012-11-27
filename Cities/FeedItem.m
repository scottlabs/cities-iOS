//
//  FeedItem.m
//  Cities
//
//  Created by Kevin Scott on 11/17/12.
//  Copyright (c) 2012 Kevin Scott. All rights reserved.
//

#import "FeedItem.h"

@implementation FeedItem

@synthesize body, item_id, type, date, content, contentView, author, author_thumb, timestamp;

- (id) initWithItem:item {
    self = [super init];
    return self;
}

- (CGRect)getSize {
    if (content == nil) {
        return CGRectMake(0, 0, 0, 0);
    } else {
        return contentView.frame;
    }
}

@end
