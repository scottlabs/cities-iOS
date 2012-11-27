//
//  CityFeedController.m
//  Cities
//
//  Created by Kevin Scott on 11/13/12.
//  Copyright (c) 2012 Kevin Scott. All rights reserved.
//

#import "CityFeedController.h"
#import <RestKit/RKJSONParserJSONKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CityFeedTableViewCell.h"


@interface CityFeedController ()

@end

@implementation CityFeedController

@synthesize tweets, photos, tableHeaderView, _tableView, server, buttonURLs, images, navigationBarLabel, cityName;


-(id)initWithCity:(City *)_city {
    self = [super init];

    city = _city;
    if (self) {
        
        server = [[Server alloc] initWithCallback:self andCity:city andOptions:[[NSDictionary alloc]
                                                                                initWithObjectsAndKeys:
                                                                                @"20",@"per_page",
                                                                                nil]];

        authorHeight = 49;
        metaHeight = 75;
        buttonURLs = [[NSMutableArray alloc] init];
        images = [[NSMutableArray alloc] init];
        titleInNavBar = FALSE;
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBar.backItem.title = @"Back to Map";

    //[self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationBar setHidden:NO];

}

- (void)buildTable
{
    
    
    int padding = 0;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(padding, padding, self.view.bounds.size.width-(padding*2), self.view.bounds.size.height) style:UITableViewStylePlain];

    
    [_tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper-1024.png"]];
    
    tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0,0,100,100)];
    [self setupTableHeaderView];
    _tableView.tableHeaderView = tableHeaderView;
    
    [self.view addSubview:_tableView];

}
- (NSString *) formattedDateRelativeToNow:(NSString *)dateString
{
    
    NSLocale* usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en-US"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:usLocale];
    
    int our_date = [[NSDate date] timeIntervalSince1970];
    
    int item_date = [dateString intValue];
    

    int diff = our_date-item_date;

    
    if (diff<15) {
        return @"Just now";
    } else if (diff < 50) {
        return @"Seconds ago";
    } else if (diff <80) {
        return @"A minute ago";
    } else if (diff <60*5) {
        return @"A few minutes ago";
    } else if (diff <60*8) {
        return @"5 minutes ago";
    } else if (diff <60*13) {
        return @"10 minutes ago";
    } else if (diff < 60*18) {
        return @"15 minutes ago";
    } else if (diff < 60*35) {
        return @"30 minutes ago";
    } else if (diff < 60* 50) {
        return @"45 minutes ago";
    } else if (diff < 60*80) {
        return @"An hour ago";
    } else if (diff < 60*60*2.5) {
        return @"2 hours ago";
    } else if (diff < 60*60*22) {
        return @"A few hours ago";
    } else if (diff < 60*60*24*1.5) {
        return @"A day ago";
    } else if (diff < 60*60*24*5) {
        return @"A few days ago";
    } else if (diff < 60*60*24*8) {
        return @"A week ago";
    } else if (diff < 60*60*24*16) {
        return @"2 weeks ago";
    } else if (diff < 60*60*24*34) {
        return @"A month ago";
    } else if (diff < 60*60*24*30*8) {
        return @"A few months ago";
    } else if (diff < 60*60*24*30*14) {
        return @"A year ago";
    } else {
        return @"A few years ago";
    }
}
- (void)loadView
{
    [super loadView];

    UINib *cityFeedTableViewCell = [UINib nibWithNibName:@"CityFeedTableViewCell" bundle:nil];
    [_tableView registerNib:cityFeedTableViewCell
     forCellReuseIdentifier:@"cityFeedTableViewCell"];

    [self buildTable];
    
    [_tableView reloadData];

}

- (void)selectPicture:(id)sender forEvent:(UITapGestureRecognizer *)recognizer {
    UIButton *btn = sender;
    UIImageView *imageView = [images objectAtIndex:btn.tag];
    UIViewController *viewController = [[UIViewController alloc] init];
    [viewController.view addSubview:imageView];
    viewController.view.backgroundColor = [UIColor blackColor];
    imageView.backgroundColor = [UIColor blackColor];
    [imageView setFrame:viewController.view.frame];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    [imageView setCenter:CGPointMake(self.view.frame.size.width/2, (self.view.frame.size.height+20)/2 )];
    
    [self.navigationController pushViewController:viewController animated:YES];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor blackColor]];
}
//The event handling method
- (void)loadWeb:(id)sender forEvent:(UITapGestureRecognizer *)recognizer {
    //CGPoint location = [recognizer locationInView:[recognizer.view superview]];

    WebViewController *webViewController = [[WebViewController alloc] init];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    UIButton *btn = sender;

    NSString *url = [buttonURLs objectAtIndex:btn.tag];
    NSLog(@"%@",url);
    if (nil != url) {
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
        /*NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://en.wikipedia.org/wiki/%@",[city.title stringByReplacingOccurrencesOfString:@" " withString:@"_"]]]];*/
        
        [webView loadRequest:request];
        webViewController.view = webView;
        
        
        [self.navigationController pushViewController:webViewController animated:YES];
        

    }
}

- (void)loadInfo:(UITapGestureRecognizer *)recognizer {

    
    InfoViewController *infoViewController = [[InfoViewController alloc] init];
    [self.navigationController pushViewController:infoViewController animated:YES];
    
    //Do stuff here...
}

- (void)setupTableHeaderView {

    Photo *cityImage = [[Photo alloc] initWithImage:[UIImage imageNamed:city.image]];

    float cityImageContainerHeight = 200;
    
    UIView *cityImageViewContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, cityImageContainerHeight)];

    UIView *cityImageView = [cityImage getImage];
    
    
    
    [cityImageView setFrame:CGRectMake(0, 0, (cityImageViewContainer.frame.size.height/cityImageView.frame.size.height*cityImageView.frame.size.width), cityImageViewContainer.frame.size.height)];
    
    
    [cityImageViewContainer addSubview:cityImageView];
    [cityImageView setCenter:CGPointMake(cityImageView.frame.size.width/2, cityImageViewContainer.frame.size.height/2)];
    cityImageViewContainer.layer.masksToBounds = YES;
    int barShadow = 10;
    int barHeight = 35;


    
    UIView *bar = [[UIView alloc] initWithFrame:CGRectMake(0, cityImageViewContainer.frame.size.height, self.view.frame.size.width, barHeight)];

    
    CAGradientLayer *barBgLayer = [GradientLayer blueGradient];
    barBgLayer.frame = bar.bounds;
    UIView *barGradientView = [[UIView alloc] initWithFrame:bar.bounds];
    [barGradientView.layer insertSublayer:barBgLayer atIndex:0];
    [bar addSubview:barGradientView];

    
    //bar.backgroundColor = [UIColor ]
    
    [tableHeaderView setFrame:CGRectMake(0, 0, self.view.frame.size.width, cityImageViewContainer.frame.size.height + barHeight-barShadow)];
    tableHeaderView.backgroundColor = [UIColor clearColor];

    
    GradientView *barShadowView = [[GradientView alloc] initWithFrame:CGRectMake(0, cityImageViewContainer.frame.size.height-barShadow,tableHeaderView.bounds.size.width,barShadow) andGradient:OPAQUE_GRADIENT andRotation:180 andOpacity:0.5];

    
    
    
    

    
    FeedLabel *barLabel = [[FeedLabel alloc] initWithFrame:CGRectMake(20, 3, tableHeaderView.frame.size.width, barHeight) andColor:[UIColor whiteColor]];
    barLabel.text = @"FEED";

    [barLabel setFont: [UIFont fontWithName: @"Futura" size:20]];

    
//    barLabel.textAlignment = NSTextAlignmentRight;
    
    
    
    barLabel.backgroundColor = [UIColor clearColor];
    [barLabel sizeToFit];
    [bar addSubview:barLabel];
    
    [tableHeaderView addSubview:cityImageViewContainer];
    [tableHeaderView addSubview:bar];
    
    float leftSide = 100;
    
    GradientView *gradientView = [[GradientView alloc] initWithFrame:CGRectMake(-1*leftSide, 0, cityImageViewContainer.bounds.size.width+leftSide, cityImageViewContainer.bounds.size.height) andGradient:OPAQUE_GRADIENT andRotation:90 andOpacity:1.0];

    //[gradientView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [cityImageViewContainer addSubview:gradientView];
    
    UIView *cityInfo = [[UIView alloc] initWithFrame:tableHeaderView.bounds];
    int padding = 20;
    
    
    
    cityName = [[FeedLabel alloc] initWithFrame:CGRectMake(padding, 20, tableHeaderView.bounds.size.width - (padding*2)-30, 30) andColor:[UIColor whiteColor]];
    cityName.text = [city.title uppercaseString];
    [cityName setFont: [UIFont fontWithName: @"Futura" size:28]];
    cityName.textAlignment = NSTextAlignmentRight;
    
    navigationBarLabel = [[FeedLabel alloc] initWithFrame:CGRectMake(padding, 64, tableHeaderView.bounds.size.width - (padding*2)-30, 30) andColor:[UIColor whiteColor]];
    navigationBarLabel.text = [city.title uppercaseString];
    [navigationBarLabel setFont: [UIFont fontWithName: @"Futura" size:28]];
    navigationBarLabel.textAlignment = NSTextAlignmentRight;
    navigationBarLabel.alpha = 0.0;
    [self.navigationController.navigationBar addSubview:navigationBarLabel];
    
    //[cityName sizeToFit];
    [cityInfo addSubview:cityName];
    [tableHeaderView addSubview:barShadowView];
    [tableHeaderView addSubview:cityInfo];
    
    
    
    
    UIButton *wikipediaButton = [[UIButton alloc] initWithFrame:CGRectMake(tableHeaderView.bounds.size.width-30, 10, 25, 25)];
    [wikipediaButton setImage:[UIImage imageNamed:@"wikipedia-48x48.png"] forState:UIControlStateNormal];
    wikipediaButton.backgroundColor = [UIColor clearColor];
    //[wikipediaButton setTitle:@"Wikipedia" forState:UIControlStateNormal];
    [self.navigationController.navigationBar addSubview:wikipediaButton];
    
    NSString *wikipediaString = [NSString stringWithFormat:@"http://en.wikipedia.org/wiki/%@",[city.title stringByReplacingOccurrencesOfString:@" " withString:@"_"]];
    int index = [buttonURLs count];
    [buttonURLs insertObject:wikipediaString atIndex:index];
    wikipediaButton.tag = index;
    [wikipediaButton addTarget:self action:@selector(loadWeb:forEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    
    /*
    UIButton *infoButton = [[UIButton alloc] initWithFrame:CGRectMake(tableHeaderView.bounds.size.width-60, cityImageViewContainer.frame.size.height + 5, 25, 25)];
    [infoButton setImage:[UIImage imageNamed:@"info.png"] forState:UIControlStateNormal];
    infoButton.backgroundColor = [UIColor clearColor];
    [cityInfo addSubview:infoButton];
    
    [infoButton addTarget:self action:@selector(loadInfo:) forControlEvents:UIControlEventTouchUpInside];
    */
    
    CGPoint cityImageViewCenter = cityImageView.center;

    // if the width is 30 pixels greater, than the end point is -30
    cityImageViewCenter.x -= 200;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:70];
    [UIView setAnimationDelay:0.0];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    
    [cityImageView setCenter:cityImageViewCenter];
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark UITableViewDelegate methods


#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{

    if ([feed count]) {
        return [feed count];
    } else {
        return 1;
    }
}
/*
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}*/
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"CityFeedTableViewCell";
    static NSString *PlaceholderCellIdentifier = @"PlaceholderCell";
    
    int feedCount = [feed count];

  	if (feedCount == 0 && indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PlaceholderCellIdentifier];
        if (cell == nil)
		{
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                          reuseIdentifier:PlaceholderCellIdentifier];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
		//cell.detailTextLabel.text = @"Loading...";

        UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [activity startAnimating];
        
        [activity setCenter:CGPointMake(cell.frame.size.width/2, 140)];
        [cell addSubview:activity];
		return cell;

    }
    
    
    CityFeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{

        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CityFeedTableViewCell" owner:self options:nil];
        cell = (CityFeedTableViewCell *)[nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //NSLog(@"init with style");
        cell.containerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"yellow-noise"]];

        
        
        [self drawStroke:cell.authorImg];
        [self drawStroke:cell.typeButton];
        //[self drawStroke:cell.con];
        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
		
    }

    
    // Leave cells empty if there's no data yet
    if (feedCount > 0)
	{
        // Set up the cell...
        //AppRecord *appRecord = [self.entries objectAtIndex:indexPath.row];
        if ([feed objectAtIndex:indexPath.row] !=nil) {
            FeedItem *item =[feed objectAtIndex:indexPath.row];
            UIView *content;
            
                
            int index = [buttonURLs count];
            NSString *url;
            NSString *subtitleText = @"";
            NSString *subtitleContent = @"";
            if ([[feed objectAtIndex:indexPath.row] isKindOfClass:[Tweet class]]) {
                Tweet *tweet = [feed objectAtIndex:indexPath.row];
                content = [self formatTweet:tweet];
                [cell.typeButton setImage:[UIImage imageNamed:@"twitter-48x48.png"] forState:UIControlStateNormal];
                //cell.typeImage.frame = CGRectMake(0, 0, 29, 29)
                url = [NSString stringWithFormat:@"http://twitter.com/%@/status/%@",tweet.author, tweet.tweet_id];

            } else if ([[feed objectAtIndex:indexPath.row] isKindOfClass:[Photo class]]) {
                Photo *photo = [feed objectAtIndex:indexPath.row];
                content = [self formatFlickr:photo];
                [cell.typeButton setImage:[UIImage imageNamed:@"flickr-48x48.png"] forState:UIControlStateNormal];
                [self drawStroke:content];
                //cell.typeLabel.text = @"Flickr";
                url = [NSString stringWithFormat:@"http://www.flickr.com/photos/%@/%@/",photo.author_url,photo.photo_id];


            } else if ([[feed objectAtIndex:indexPath.row] isKindOfClass:[Review class]]) {
                Review *review = [feed objectAtIndex:indexPath.row];
                content = [self formatReview:review];
                [cell.typeButton setImage:[UIImage imageNamed:@"yelp-48x48.png"] forState:UIControlStateNormal];
                //cell.typeLabel.text = @"Yelp";
                url = review.url;
                //subtitleText = @"Review for ";
                //subtitleContent = review.business;
                                
            }
            
            if (nil != url) {
                [buttonURLs insertObject:url atIndex:index];
                cell.typeButton.tag = index;
                
                [cell.typeButton addTarget:self action:@selector(loadWeb:forEvent:) forControlEvents:UIControlEventTouchUpInside];
                
            }
            
            //cell.subtitleLabelText.text = subtitleText;
            //cell.subtitleLabelContent.text = subtitleContent;
            
            //cell.authorLabel.text = @"hey now";
            
            cell.authorLabel.text = item.author;
            
            UIImage *authorImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:item.author_thumb]]];
            //cell.authorImg.backgroundColor = [UIColor yellowColor];
            cell.authorImg.image = authorImage;
            //cell.authorImg = [[UIImageView alloc] initWithImage:authorImage];
            //cell.authorImg.backgroundColor = [UIColor blueColor];
            
            cell.timestamp.text = [self formattedDateRelativeToNow:item.timestamp];
            
            
            
            
            //cell.cellContentView.backgroundColor = [UIColor brownColor];
            
            
            [cell.cellContentView addSubview:content];
            [content setCenter:CGPointMake(content.center.x, content.center.y+20)];
            
            float padding = 10;

            float cell_height = content.frame.size.height + 123 + 5;
            
            [cell.containerView setFrame:CGRectMake(padding, padding*2, self.view.frame.size.width - (padding*2), cell_height)];

            float cell_content_view_height = cell.containerView.frame.size.height - cell.metaView.frame.size.height - cell.authorView.frame.size.height - (0*2);


            [cell.cellContentView setFrame:CGRectMake(0, cell.authorView.frame.size.height+0, cell.containerView.frame.size.width-(0*2), cell_content_view_height)];
            

            
            //cell.containerView.layer.cornerRadius = 5;
            

            
            cell.containerView.layer.shadowColor = [[UIColor blackColor] CGColor];
            cell.containerView.layer.shadowOffset = CGSizeMake(0,2.0);
            
            cell.containerView.layer.shadowRadius = 2;
            cell.containerView.layer.shadowOpacity = 0.4;
            cell.contentView.layer.masksToBounds = NO;
            cell.containerView.layer.masksToBounds = NO;
            
            //cell.metaView.layer.borderColor = [UIColor colorWithRed:0/255 green:200/255 blue:200/255 alpha:1.0].CGColor;

            
        }
        
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if ([feed count] == 0 && indexPath.row == 0) {

        return 200;
    }
    
    UIView *content;

    //float height = 0;
    if ([[feed objectAtIndex:indexPath.row] isKindOfClass:[Tweet class]]) {
        Tweet *tweet = [feed objectAtIndex:indexPath.row];
        content = [self formatTweet:tweet];
    } else if ([[feed objectAtIndex:indexPath.row] isKindOfClass:[Photo class]]) {
        Photo *photo = [feed objectAtIndex:indexPath.row];
        content = [self formatFlickr:photo];
    } else if ([[feed objectAtIndex:indexPath.row] isKindOfClass:[Review class]]) {
        Review *review = [feed objectAtIndex:indexPath.row];
        content = [self formatReview:review];
        //height = [review getSize].size.height;

    }
    
    float end_padding = 0;
    float margin = 40;
    if (indexPath.row==[feed count]-1) {
        end_padding = 100;
    }
    //return 100;
    return content.frame.size.height + 123 + 5 + margin + end_padding; // 123 is the padding plus the other two views, 20 is margin
}

- (UIView *)formatReview:(Review *)review {
    return [review getContentView:self.view.frame.size.width];
}
- (UIView *)formatTweet:(Tweet *)tweet {
    UIView *view = [[UIView alloc] init];
    int padding = 10;
    int width = self.view.frame.size.width-20-(padding*2)-20;
    
    UIView *tweetLabelContainer = [[UIView alloc] initWithFrame:CGRectMake(padding+0, 0, width, 50)];
    FeedLabel *tweetLabel = [[FeedLabel alloc] initWithFrame:CGRectMake(padding+0+20, 20, width-40, 50-40)];
    tweetLabel.numberOfLines = 0;
    CGSize maximumLabelSize = CGSizeMake(width,9999);
    
    CGSize expectedLabelSize = [tweet.text sizeWithFont:tweetLabel.font constrainedToSize:maximumLabelSize lineBreakMode:tweetLabel.lineBreakMode];
    
    //adjust the label the the new height.
    CGRect newFrame = tweetLabel.frame;
    newFrame.size.height = expectedLabelSize.height;
    tweetLabel.frame = newFrame;
    
    

    tweetLabel.text = tweet.text;
    //tweetLabel.text = @"suck a lemon!";
    //[tweetLabel sizeToFit];

    tweetLabelContainer.layer.shadowColor = [[UIColor blackColor] CGColor];
    tweetLabelContainer.layer.shadowOffset = CGSizeMake(0,2.0);
    tweetLabelContainer.layer.shadowRadius = 2;
    tweetLabelContainer.layer.shadowOpacity = 0.4;
    tweetLabelContainer.layer.cornerRadius = 5;
    
    tweetLabelContainer.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"white-noise.png"]];
    [view addSubview:tweetLabelContainer];
    [tweetLabelContainer setFrame:CGRectMake(padding+0, 0, width, tweetLabel.frame.size.height+40)];
    [tweetLabelContainer addSubview:tweetLabel];
    [view setFrame:CGRectMake(padding, 0, self.view.frame.size.width-(padding*2), tweetLabelContainer.frame.size.height)];
    return view;
}
- (UIView *)formatFlickr:(Photo *)photo {
    //UIView *view = [[UIView alloc] init];
    
    //UIView *imageView = [photo getContent];
    int padding = 10;
    int width = self.view.frame.size.width-20-(padding*2);
    [photo setWidth:width];

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(padding,padding,width,[photo getHeight])];
    view.backgroundColor = [UIColor greenColor];
    //[view setFrame:CGRectMake(10, 0, 100, 100)];

    UIImageView *imageView = [photo getImageWithMaximumWidth:width];
    
    if (imageView.frame.size.width > width) {
        //[imageView setFrame:CGRectMake(padding, 0, width, (width/imageView.frame.size.width)*imageView.frame.size.height)];
        float ratio = width/imageView.frame.size.width;
        [imageView setFrame:CGRectMake(0, 0, width, ratio * imageView.frame.size.height)];
    }
    UIButton *imageButton = [[UIButton alloc] initWithFrame:imageView.frame];
    [imageButton setImage:imageView.image forState:UIControlStateNormal];
    //[view setFrame:CGRectMake(0, 0, 200, 200)];
    //view.backgroundColor = [UIColor yellowColor];
    //imageView.layer.cornerRadius = 5;
    [view addSubview:imageButton];
    //[view setFrame:CGRectMake(padding,padding,width,imageView.frame.size.height+0)];
    //view.frame = imageView.frame;
    view.backgroundColor = [UIColor clearColor];
    
    int index = [images count];
    [images insertObject:imageView atIndex:index];
    imageButton.tag = index;
    [imageButton addTarget:self action:@selector(selectPicture:forEvent:) forControlEvents:UIControlEventTouchUpInside];
    //[imageView addGestureRecognizer:UIGest]
    //[imageView addTarget:self action:@selector(loadWeb:forEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    //NSLog(@"format flickr");
    //NSLog(@"%@",imageView);
    //[view setFrame:CGRectMake(0, 0, 100, 100)];
    //view.backgroundColor = [UIColor redColor];
    
    return view;
}




- (void)setFeed:(NSArray *)items {
    //NSLog(@"set feed");

    feed = [[NSMutableArray alloc] init];
    
    for (int i=0;i<[items count];i++) {
        FeedItem *item = [items objectAtIndex:i];

        if ([@"photo" isEqualToString:item.type]) {
            //NSLog(@"photo:");
            //NSLog(@"%@",item.content);
            Photo *parsedItem = [[Photo alloc] initWithItem:item.content];
            //NSLog(@"our item: %@",parsedItem.image_url);
            //NSLog(@" *** p");
            [feed addObject:parsedItem];
        } else if ([@"tweet" isEqualToString:item.type]) {
            Tweet *parsedItem = [[Tweet alloc] initWithItem:item.content];
            [feed addObject:parsedItem];
        } else if ([@"review" isEqualToString:item.type]) {
            Review *parsedItem = [[Review alloc] initWithItem:item.content];
            [feed addObject:parsedItem];
        }

        
    }

    [_tableView reloadData];
}

- (void)drawStroke:(UIView *)view
{
    view.layer.masksToBounds = NO;
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowOffset = CGSizeMake(0,2);
    view.layer.shadowRadius = 2;
    view.layer.shadowOpacity = 0.4;
    /*
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 100, 100) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(20, 20)];
    [[UIColor blackColor] setFill];
    
    [path fill];*/
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y > 15) {
        [navigationBarLabel setCenter:CGPointMake(navigationBarLabel.center.x, scrollView.contentOffset.y+49)];
        navigationBarLabel.alpha = 1-(scrollView.contentOffset.y/100);
        cityName.alpha = 0;
    } else {
        navigationBarLabel.alpha = 0;
        cityName.alpha = 1;
        //[navigationBarLabel setCenter:CGPointMake(navigationBarLabel.center.x, cityName.center.y)];
    }
    NSLog(@"%f",scrollView.contentOffset.y);
    /*
    NSLog(@"%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y < 50) {
        
    } else {
        
    }*/
}
@end
