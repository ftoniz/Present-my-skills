//
//  ScoreRealmViewController.h
//  FTPresentDemoProject
//
//  Created by FToniz on 3/4/2558 BE.
//  Copyright (c) 2558 Narut. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RClass;
@interface ScoreRealmViewController : UIViewController
@property (nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic , setter=setClass:) RClass *currentClass;
@end
