//
//  Photo.m
//  Cities
//
//  Created by Kevin Scott on 11/14/12.
//  Copyright (c) 2012 Kevin Scott. All rights reserved.
//

#import "Photo.h"
//#import "Flickr.h"

@implementation Photo

@synthesize image,photo_id, image_url, original_width, original_height, license;
@synthesize author_url, title, description, point, accuracy;
@synthesize async_image, imageView;


//@synthesize authorLabel, dateLabel, flickr, photo_id, owner, secret, server, farm, title, ispublic, isfriend, isfamily, image;

- (id)initWithImage:(UIImage *)_image {
    self = [super init];
    if (self) {
        image = _image;
        scale = 1.0;
    }
    
    return self;
}
-(id) initWithURL:(NSString *)url {
    self = [super init];
    if (self) {
        image_url = url;
    }


    return self;
}
////

- (UIImageView *)getImage {
    if (image) {
        imageView = [[UIImageView alloc] initWithImage:image];
    } else {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        if (async_image == nil) {
            async_image = [[AsynchronousImage alloc] initWithURL:image_url andDelegate:self];
            
            //image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:image_url]]];
        }
        
    }
    
    //imageView.layer.masksToBounds = YES;
    imageView.backgroundColor = [UIColor blackColor];
    return imageView;
}
- (UIImageView *)getImageWithMaximumWidth:(int)_width {
    [self setWidth:_width];
    

    if (image) {
        imageView = [[UIImageView alloc] initWithImage:image];
    } else {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        if (async_image == nil) {
            async_image = [[AsynchronousImage alloc] initWithURL:image_url andDelegate:self];

            //image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:image_url]]];
        }

    }
    
    //UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    if (imageView.frame.size.width > _width) {
        [imageView setFrame:CGRectMake(0, 0, _width, (_width/imageView.frame.size.width)*imageView.frame.size.height)];
    }
    //imageView.layer.masksToBounds = YES;
    imageView.backgroundColor = [UIColor grayColor];
    return imageView;
}
- (void)setImage:(UIImage *)loaded_image {
    image = loaded_image;
    NSLog(@"set image");
    imageView.backgroundColor = [UIColor greenColor];
    //imageView.image = image;
    [imageView setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    if (imageView.frame.size.width > width) {
        [imageView setFrame:CGRectMake(0, 0, [self getWidth], [self getHeight])];
    }
}

- (float)getWidth {
    return width*scale;
}
- (float)getHeight {
    return height*scale;
}

- (id) initWithItem:(NSDictionary *)item {
    self = [super init];
    if (self) {

        scale = 1.0;
        //photo_id = item.item_id;

        photo_id = [item objectForKey:@"id"];
        //date = [item objectForKey:@"date"];
        width = [[item objectForKey:@"width"] floatValue];
        height = [[item objectForKey:@"height"] floatValue];
        image_url = [item objectForKey:@"image_url"];
        //original_width = [item objectForKey:@"original_width"];
        //original_height = [item objectForKey:@"original_height"];
        //license = [item objectForKey:@"license"];
        timestamp = [item objectForKey:@"timestamp"];
        author = [item objectForKey:@"author"];
        author_thumb = [item objectForKey:@"author_thumb"];
        author_url = [author stringByReplacingOccurrencesOfString:@" " withString:@""];
        

        //author_id = [item objectForKey:@"author_id"];
        title = [item objectForKey:@"title"];
        description = [item objectForKey:@"description"];
        //point = [item objectForKey:@"point"];
        //accuracy = [item objectForKey:@"accuracy"];
    }


    return self;
}

- (void)setWidth:(float)_width {
    scale = _width/width;
}
@end
