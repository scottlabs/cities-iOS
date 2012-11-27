//
//  CityFeedController.h
//  Cities
//
//  Created by Kevin Scott on 11/13/12.
//  Copyright (c) 2012 Kevin Scott. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
//#import "Flickr.h"
#import "City.h"
#import "Photo.h"
#import "Three20/Three20.h"
#import "Server.h"


#import "Tweet.h"
#import "Review.h"
#import "GradientLayer.h"
#import "GradientView.h"

#import "WebViewController.h"
#import "InfoViewController.h"

#import "FeedLabel.h"

@interface CityFeedController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate> {
    UITableView *_tableView;
    NSMutableArray *feed;
    NSMutableArray *tweets;
    NSMutableArray *photos;
//    Flickr *flickr;
    Server *server;
    City *city;
    UIView *tableHeaderView;
    float authorHeight;
    float metaHeight;
    NSMutableArray *buttonURLs;
    NSMutableArray *images;
    BOOL titleInNavBar;
    
    FeedLabel *navigationBarLabel;
    FeedLabel *cityName;

}
@property (nonatomic, retain) FeedLabel *cityName;
@property (nonatomic, retain) FeedLabel *navigationBarLabel;
@property (nonatomic, retain) NSMutableArray *images;
@property (nonatomic, retain) NSMutableArray *tweets;
@property (nonatomic, retain) NSMutableArray *photos;

@property (nonatomic, retain) NSMutableArray *buttonURLs;
//@property (nonatomic, retain) Flickr *flickr;
@property (nonatomic, retain) Server *server;
@property (nonatomic, retain) UIView *tableHeaderView;


@property (nonatomic, retain) UITableView *_tableView;

- (void)setupTableHeaderView;
- (id)initWithCity:(City *)_city;
- (UIView *)formatFlickr:(Photo *)photo;
- (UIView *)formatTweet:(Tweet *)tweet;
- (UIView *)formatReview:(Review *)review;
- (void)setFeed:(NSArray *)items;
- (NSString *) formattedDateRelativeToNow:(NSString *)dateString;
//- (void):(UITapGestureRecognizer *)recognizer;
- (void)buildTable;
- (void)loadWeb:(id)sender forEvent:(UITapGestureRecognizer *)recognizer;
- (void)drawStroke:(UIView *)view;
@end
