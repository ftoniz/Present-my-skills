//
//  ETOuterCell.h
//  FTPresentDemoProject
//
//  Created by narut on 2/22/15.
//  Copyright (c) 2015 Narut. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETOuterCell : UITableViewCell
@property (nonatomic) IBOutlet UILabel *titleLable;
@property (nonatomic) IBOutlet UIButton *arrowButton;
@end

@interface ETOuter : NSObject
@property NSString *title;
@property BOOL expanded;

- initWithTitle:(NSString *)title;
@end