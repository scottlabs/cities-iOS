//
//  AsynchronousImage.h
//  Cities
//
//  Created by Kevin Scott on 11/24/12.
//  Copyright (c) 2012 Kevin Scott. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AsynchronousImage : NSObject {
    NSString *image_url;
    UIImageView *image_view;
    NSURLConnection *connection;
    NSMutableData *data;

}

@property (nonatomic, assign) id  delegate;
@property (nonatomic)  int tag;


- (id)initWithURL:(NSString *)url andDelegate:(id)_delegate;

@end
