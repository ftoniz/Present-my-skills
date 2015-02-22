//
//  ETTableView.m
//  FTPresentDemoProject
//
//  Created by narut on 2/22/15.
//  Copyright (c) 2015 Narut. All rights reserved.
//

#import "ETTableView.h"

@implementation ETTableView

- (void)awakeFromNib{
    
    [self registerNib:[UINib nibWithNibName:@"ETOuterCell" bundle:nil] forCellReuseIdentifier:@"OuterCell"];
    [self registerNib:[UINib nibWithNibName:@"ETInnerCell" bundle:nil] forCellReuseIdentifier:@"InnerCell"];
}


- (ETOuterCell *)outerCellWithTitle:(NSString *)title stage:(ETOuterStage)stage{
    ETOuterCell *cell = [self dequeueReusableCellWithIdentifier:@"OuterCell"];
    [cell.titleLable setText:title];
    if (stage == ETOuterStageContracted) {
        [cell.arrowButton setImage:[UIImage imageNamed:@"Down"] forState:UIControlStateNormal];
    }
    else{
        [cell.arrowButton setImage:[UIImage imageNamed:@"Up"] forState:UIControlStateNormal];
    }
    
    return cell;
}

- (ETInnerCell *)innerCellWithTitle:(NSString *)title{
    ETInnerCell *cell = [self dequeueReusableCellWithIdentifier:@"InnerCell"];
    [cell.titleLable setText:title];
    return cell;
}
@end
