//
//  ETInnerCell.h
//  FTPresentDemoProject
//
//  Created by narut on 2/22/15.
//  Copyright (c) 2015 Narut. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETInnerCell : UITableViewCell
@property (nonatomic) IBOutlet UILabel *titleLable;
@end

@interface ETInner : NSObject
@property NSString *title;
@property BOOL visible;

- (instancetype)initWithTitle:(NSString *)title;
@end
