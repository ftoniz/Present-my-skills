//
//  ResizeableViewController.h
//  FTPresentDemoProject
//
//  Created by narut on 2/16/15.
//  Copyright (c) 2015 Narut. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResizeableTableView.h"

@interface ResizeableViewController : UIViewController <UITableViewDataSource , UITableViewDelegate>
@property (nonatomic) IBOutlet ResizeableTableView *tableView;
@end
