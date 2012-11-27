//
//  ExternalService.m
//  Cities
//
//  Created by Kevin Scott on 11/15/12.
//  Copyright (c) 2012 Kevin Scott. All rights reserved.
//

#import "ExternalService.h"

@implementation ExternalService
- (id)initWithCallback:_callbackObject {
    self = [super init];
    if (self) {
        callbackObject = _callbackObject;
        // Custom initialization
        city = nil;
        options = [[NSDictionary alloc] init];
        [self start];
    }
    return self;
}
- (id)initWithCallback:_callbackObject andCity:(id)_city {
    self = [super init];
    if (self) {
        callbackObject = _callbackObject;
        // Custom initialization
        city = _city;
        options = [[NSDictionary alloc] init];        
        [self start];
    }
    return self;
    
}
- (id)initWithCallback:_callbackObject andCity:(id)_city andOptions:(id)_options{
    self = [super init];
    if (self) {
        callbackObject = _callbackObject;
        // Custom initialization
        city = _city;
        options = _options;
        [self start];
    }
    return self;
    
}

- (id)initWithCallback:_callbackObject andFunction:_function {
    self = [super init];
    if (self) {
        callbackObject = _callbackObject;
        function = _function;
        // Custom initialization
        [self start];
    }
    return self;
}
- (id)getCallback {
    if (callbackObject) {
        return callbackObject;
    } else {
        return nil;
    }
}

- (void)start{}
- (void)callback:objects{};

@end
