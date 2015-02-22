//
//  ETTableView.h
//  FTPresentDemoProject
//
//  Created by narut on 2/22/15.
//  Copyright (c) 2015 Narut. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETOuterCell.h"
#import "ETInnerCell.h"

typedef NS_ENUM(NSUInteger, ETOuterStage) {ETOuterStageContracted , ETOuterStageExpanded };

@interface ETTableView : UITableView

- (ETOuterCell *)outerCellWithTitle:(NSString *)title stage:(ETOuterStage)stage;
- (ETInnerCell *)innerCellWithTitle:(NSString *)title;

@end
