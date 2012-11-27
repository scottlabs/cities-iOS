//
//  Review.h
//  Cities
//
//  Created by Kevin Scott on 11/23/12.
//  Copyright (c) 2012 Kevin Scott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedItem.h"
#import "Photo.h"
@interface Review : FeedItem {
    UILabel *reviewText;
    Photo *photoObj;
    Photo *ratingObj;

}
@property (strong, nonatomic) Photo *photoObj;
@property (strong, nonatomic) Photo *ratingObj;
@property (strong, nonatomic) NSString *business;
@property (strong, nonatomic) UILabel *reviewText;
//@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) NSString *review_id;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *user_photo_url;
@property (strong, nonatomic) NSString *text_excerpt;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *rating;
@property (strong, nonatomic) NSString *rating_img_url;
@property (strong, nonatomic) NSString *user_photo_url_small;
@property (strong, nonatomic) NSString *rating_img_url_small;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *timestamp;

- (id) initWithItem:(NSDictionary *)item;
- (UIView *)getContentView:(float)_width;


@end
