//
//  Photo.h
//  Cities
//
//  Created by Kevin Scott on 11/14/12.
//  Copyright (c) 2012 Kevin Scott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedItem.h"
#import "AsynchronousImage.h"
//#import "Flickr.h"



@interface Photo : FeedItem {
    float width;
    float height;
    float scale;
    AsynchronousImage *async_image;
    UIImage *image;
    UIImageView *imageView;
}

//@property (strong, nonatomic) Flickr *flickr;
@property (strong, nonatomic) NSString *photo_id;
@property (strong, nonatomic) NSString *image_url;
@property (strong, nonatomic) NSString *original_width;
@property (strong, nonatomic) NSString *original_height;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *license;
//@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *author_url;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *point;
@property (strong, nonatomic) NSString *accuracy;

@property (strong, nonatomic) AsynchronousImage *async_image;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIImageView *imageView;

- (UIImageView *)getImageWithMaximumWidth:(int)width;


- (id)initWithImage:(UIImage *)_image;
- (id)initWithURL:(NSString *)url;
- (id) initWithItem:(NSDictionary *)item;

- (float)getWidth;
- (float)getHeight;

- (void)setWidth:(float)_width;

- (void)setImage:(UIImage *)loaded_image;

- (UIImageView *)getImage;

@end
