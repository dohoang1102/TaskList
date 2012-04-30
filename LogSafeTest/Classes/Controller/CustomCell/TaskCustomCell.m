//
//  TaskCustomCell.m
//  LogSafeTest
//
//  Created by Clément Rousselle on 4/30/12.
//  Copyright (c) 2012 Hot Apps Factroy. All rights reserved.
//

#import "TaskCustomCell.h"

@implementation TaskCustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
