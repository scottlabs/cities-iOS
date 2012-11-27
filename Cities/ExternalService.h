//
//  ExternalService.h
//  Cities
//
//  Created by Kevin Scott on 11/15/12.
//  Copyright (c) 2012 Kevin Scott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "City.h"
#import "definitions.h"

@interface ExternalService : NSObject {
    id callbackObject;
    NSString *function;
    City *city;
    NSDictionary *options;
}
- (id)initWithCallback:_callbackObject;
- (id)initWithCallback:_callbackObject andCity:_city;
- (id)initWithCallback:_callbackObject andCity:_city andOptions:_options;
- (id)initWithCallback:_callbackObject andFunction:_function;
- (void)start;
- (void)callback:objects;
- (id)getCallback;
@end
