//
//  ResizeTableView.m
//  FTPresentDemoProject
//
//  Created by narut on 2/16/15.
//  Copyright (c) 2015 Narut. All rights reserved.
//

#import "ResizeableTableView.h"

@implementation ResizeableTableView{
}

- (void)awakeFromNib{
    [self registerNib:[UINib nibWithNibName:@"ResizeableTableCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
}

- (ResizeableTableCell *)cell{
    ResizeableTableCell *cell = [self dequeueReusableCellWithIdentifier:@"Cell"];
    
    return cell;
}

@end
