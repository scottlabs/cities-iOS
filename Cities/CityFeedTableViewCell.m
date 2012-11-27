//
//  CityFeedTableViewCell.m
//  Cities
//
//  Created by Kevin Scott on 11/18/12.
//  Copyright (c) 2012 Kevin Scott. All rights reserved.
//

#import "CityFeedTableViewCell.h"

@implementation CityFeedTableViewCell

@synthesize authorView, authorImg, authorLabel, timestamp, contentView, metaView, containerView, cellContentView, typeButton, subtitleLabelContent, subtitleLabelText, businessView;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

    }
    return self;
}

- (void)awakeFromNib {

    // equivalent of view did load
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
