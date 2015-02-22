//
//  ETOuterCell.m
//  FTPresentDemoProject
//
//  Created by narut on 2/22/15.
//  Copyright (c) 2015 Narut. All rights reserved.
//

#import "ETOuterCell.h"

@implementation ETOuterCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@implementation ETOuter

- (id)initWithTitle:(NSString *)title{
    self = [super init];
    if (self) {
        self.title = title;
        self.expanded = NO;
    }
    return self;
}

@end