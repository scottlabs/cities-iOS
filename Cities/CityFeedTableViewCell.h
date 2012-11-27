//
//  CityFeedTableViewCell.h
//  Cities
//
//  Created by Kevin Scott on 11/18/12.
//  Copyright (c) 2012 Kevin Scott. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityFeedTableViewCell : UITableViewCell {
    IBOutlet UIView *authorView;
    IBOutlet UIImageView *authorImg;
    IBOutlet UILabel *authorLabel;
    IBOutlet UILabel *subtitleLabelText;
    IBOutlet UILabel *subtitleLabelContent;
    
    IBOutlet UILabel *timestamp;
    IBOutlet UIButton *typeButton;
    IBOutlet UIView *contentView;
    IBOutlet UIView *metaView;
    IBOutlet UIView *containerView;
    IBOutlet UIView *cellContentView;
    IBOutlet UIView *businessView;
    
}

@property (nonatomic, retain) IBOutlet UIView *businessView;
@property (nonatomic, retain) IBOutlet UILabel *subtitleLabelText;
@property (nonatomic, retain) IBOutlet UILabel *subtitleLabelContent;
@property (nonatomic, retain) IBOutlet UIButton *typeButton;
@property (nonatomic, retain) IBOutlet UIView *authorView;
@property (nonatomic, retain) IBOutlet UIImageView *authorImg;
@property (nonatomic, retain) IBOutlet UILabel *authorLabel;
@property (nonatomic, retain) IBOutlet UILabel *timestamp;
@property (nonatomic, retain) IBOutlet UIView *contentView;
@property (nonatomic, retain) IBOutlet UIView *metaView;
@property (nonatomic, retain) IBOutlet UIView *containerView;
@property (nonatomic, retain) IBOutlet UIView *cellContentView;

@end
