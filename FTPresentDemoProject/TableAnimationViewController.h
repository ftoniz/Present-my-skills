//
//  TableAnimationViewController.h
//  FTPresentDemoProject
//
//  Created by narut on 2/17/15.
//  Copyright (c) 2015 Narut. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableAnimationViewController : UIViewController <UITableViewDataSource , UITableViewDelegate>
@property (nonatomic) IBOutlet UITableView *tableView;
@end
