//
//  GameHomeTableViewCell.m
//  BasketballStats
//
//  Created by Liam Andrew on 28/05/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import "GameHomeTableViewCell.h"

@implementation GameHomeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUpCell {
    [self.cellBackgroundView setRoundedCorners];
}

@end
