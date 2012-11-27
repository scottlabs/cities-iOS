//
//  Server.h
//  Cities
//
//  Created by Kevin Scott on 11/17/12.
//  Copyright (c) 2012 Kevin Scott. All rights reserved.
//

#import "ExternalService.h"

@interface Server : ExternalService <RKObjectLoaderDelegate>{
    RKObjectManager* manager;
}

@property (nonatomic, retain) RKObjectManager *manager;
@end
