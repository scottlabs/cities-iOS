//
//  AsynchronousImage.m
//  Cities
//
//  Created by Kevin Scott on 11/24/12.
//  Copyright (c) 2012 Kevin Scott. All rights reserved.
//

#import "AsynchronousImage.h"
#import "Photo.h"
@implementation AsynchronousImage

@synthesize delegate, tag;

- (id) initWithURL:(NSString *)url andDelegate:(id)_delegate {
    self = [super init];
    if (self != nil) {
        image_url = url;
        delegate = _delegate;
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:image_url]
                                 cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                 timeoutInterval:30.0];
        connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    }
    return self;
}
- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData {
    
    if (data == nil) { data = [[NSMutableData alloc] initWithCapacity:2048]; }
    [data appendData:incrementalData];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection {
    UIImage *image = [UIImage imageWithData:data];
    [delegate setImage:image];
}
@end
