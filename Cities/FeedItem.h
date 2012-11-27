//
//  FeedItem.h
//  Cities
//
//  Created by Kevin Scott on 11/17/12.
//  Copyright (c) 2012 Kevin Scott. All rights reserved.
//

#import "ExternalService.h"

@interface FeedItem : ExternalService {
    NSString *item_id;
    NSString *type;
    NSString *date;
    NSString *timestamp;
    NSString *body;

    NSString *author;
    NSString *author_thumb;

    UIView *contentView;
    
    NSDictionary *content;
    

    
}
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) NSDictionary *content;
@property (nonatomic, retain) NSString *item_id;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) NSString *timestamp;
@property (nonatomic, retain) NSString *body;

@property (nonatomic, retain) NSString *author;
@property (nonatomic, retain) NSString *author_thumb;

- (CGRect)getSize;
- (id) initWithItem:(NSDictionary *)item;

@end
