//
//  Review.m
//  Cities
//
//  Created by Kevin Scott on 11/23/12.
//  Copyright (c) 2012 Kevin Scott. All rights reserved.
//

#import "Review.h"
#import "FeedLabel.h"

@implementation Review

@synthesize review_id, username, user_photo_url, user_photo_url_small, text_excerpt, url, rating, rating_img_url, rating_img_url_small, business, photoObj, ratingObj;
@synthesize reviewText;

- (id) initWithItem:(NSDictionary *)item {
    self = [super init];
    if (self) {
        photoObj = [[Photo alloc] initWithURL:@"http://media4.ak.yelpcdn.com/bpthumb/ewEwh5untge1rMd2lwOrwg/ms"];

        //date = [item objectForKey:@"date"];
        timestamp = [item objectForKey:@"timestamp"];
        author = [item objectForKey:@"author"];
        author_thumb = [item objectForKey:@"author_thumb"];
        user_photo_url_small = [item objectForKey:@"user_photo_url_small"];
        text_excerpt = [item objectForKey:@"text_excerpt"];
        url = [item objectForKey:@"url"];
        rating = [item objectForKey:@"rating"];
        rating_img_url_small = [item objectForKey:@"rating_img_url_small"];
        ratingObj = [[Photo alloc] initWithURL:@"http://s3-media3.ak.yelpcdn.com/assets/2/www/img/c7623205d5cd/ico/stars/stars_small_5.png"];
        business = [item objectForKey:@"business"];
    }
    return self;
}

- (UIView *)getContentView:(float)_width {
    if (0 && contentView != nil && text_excerpt != nil) {
        return contentView;
    }
    
    contentView = [[UIView alloc] init];
    
    int padding = 10;
    int width = _width-20-(padding*2);
    //FeedLabel *titleText = [[ FeedLabel alloc] initWithFrame:CGRectMake(padding, 0, width, 50)];
    //titleText.text = [NSString stringWithFormat:@"Review for %@",@"hoo"];
    
   
    //[tweetLabel sizeToFit];
    
    //[contentView addSubview:titleText];
    [contentView addSubview:reviewText];
    
    UIView *businessView = [[UIView alloc] initWithFrame:CGRectMake(padding, 0, width, 150)];
    businessView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gray-noise.png"]];
    
    FeedLabel *businessLabel = [[FeedLabel alloc] initWithFrame:CGRectMake(padding, padding, width-(padding*2), 20)];
    //[businessLabel sizeToFit];
    businessLabel.text = @"my business";
    [businessView addSubview:businessLabel];
    FeedLabel *addressLabel1 = [[FeedLabel alloc] initWithFrame:CGRectMake(padding, businessLabel.frame.size.height+padding, width, 20)];
    //[addressLabel1 sizeToFit];
    addressLabel1.text = @"1 main street";
    [businessView addSubview:addressLabel1];
    FeedLabel *addressLabel2 = [[FeedLabel alloc] initWithFrame:CGRectMake(padding, padding+businessLabel.frame.size.height+addressLabel1.frame.size.height, width, 20)];
    //[addressLabel2 sizeToFit];
    addressLabel2.text = @"Pittsburgh, PA 15213";
    [businessView addSubview:addressLabel2];
    

    UIImageView *businessImage = [photoObj getImage];
    businessImage.contentMode = UIViewContentModeScaleAspectFit;
    [businessImage setFrame:CGRectMake(businessView.frame.size.width-10-60, 10, 60, 60)];
    businessImage.backgroundColor = [UIColor clearColor];
    [businessView addSubview:businessImage];
    
    
    
    float infoHeight = (padding*2)+businessLabel.frame.size.height+addressLabel1.frame.size.height+addressLabel2.frame.size.height;

    MKMapView *businessMapView = [[MKMapView alloc] initWithFrame:CGRectMake(padding, infoHeight, businessView.frame.size.width - (padding*2), 120)];
    businessMapView.zoomEnabled = FALSE;
    NSString *location = [NSString stringWithFormat:@"%@, %@",addressLabel1.text,addressLabel2.text];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:location
                 completionHandler:^(NSArray* placemarks, NSError* error){
                     if (placemarks && placemarks.count > 0) {
                         CLPlacemark *topResult = [placemarks objectAtIndex:0];
                         MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
                         
                         MKCoordinateRegion region = businessMapView.region;
                         region.center = placemark.region.center;
                         region.span.longitudeDelta = 0.04;
                         region.span.latitudeDelta = 0.04;
                         
                         [businessMapView setRegion:region animated:YES];
                         [businessMapView addAnnotation:placemark];
                     }
                 }
     ];
    
    
    [businessView addSubview:businessMapView];
    
    [contentView addSubview:businessView];
    [businessView setFrame:CGRectMake(businessView.frame.origin.x, businessView.frame.origin.y, businessView.frame.size.width, infoHeight+businessMapView.frame.size.height)];
    
    UIImageView *ratingImage = [ratingObj getImage];
    //ratingImage.contentMode = UIViewContentModeScaleAspectFit;
    [ratingImage setFrame:CGRectMake(65, -35, 50, 10)];
    ratingImage.backgroundColor = [UIColor greenColor];
    [contentView addSubview:ratingImage];

    
    
    reviewText = [[FeedLabel alloc] initWithFrame:CGRectMake(padding+0, businessView.frame.size.height+10, width, 50)];
    reviewText.numberOfLines = 0;
    CGSize maximumLabelSize = CGSizeMake(width,9999);
    
    CGSize expectedLabelSize = [text_excerpt sizeWithFont:reviewText.font constrainedToSize:maximumLabelSize lineBreakMode:reviewText.lineBreakMode];
    
    //adjust the label the the new height.
    CGRect newFrame = reviewText.frame;
    newFrame.size.height = expectedLabelSize.height;
    reviewText.frame = newFrame;
    
    
    
    reviewText.text = text_excerpt;
    
    //[contentView setFrame:CGRectMake(0,0,200,200)];
    float contentViewHeight =businessView.frame.size.height+reviewText.frame.size.height+10;
    [contentView setFrame:CGRectMake(0,0,contentView.frame.size.width,contentViewHeight) ];
    return contentView;
}
@end
