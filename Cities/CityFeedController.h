//
//  CityFeedController.h
//  Cities
//
//  Created by Kevin Scott on 11/13/12.
//  Copyright (c) 2012 Kevin Scott. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

@interface CityFeedController : UIViewController <UITableViewDelegate, UITableViewDataSource, RKObjectLoaderDelegate> {
    UITableView *_tableView;
    NSArray *_statuses;
}

@end
