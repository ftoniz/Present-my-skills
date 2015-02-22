//
//  ViewController.m
//  FTPresentDemoProject
//
//  Created by narut on 2/13/15.
//  Copyright (c) 2015 Narut. All rights reserved.
//

#import "RootViewController.h"
#import "SlideImageViewController.h"
#import "ResizeableViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController{
    NSMutableArray *menuData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Menu";
    menuData = [NSMutableArray new];
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    [self addObjectsToMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -

- (void)addObjectsToMenu{
    [menuData addObject:@{ @"Title" : @"Slide Image" , @"StoryIdentifier" : @"SlideImageViewController" }];
    [menuData addObject:@{ @"Title" : @"Resizeable Cell" , @"StoryIdentifier" : @"ResizeableViewController" }];
    [menuData addObject:@{ @"Title" : @"Animation TableViewCell" , @"StoryIdentifier" : @"TableAnimationViewController" }];
    [menuData addObject:@{ @"Title" : @"MapKit" , @"StoryIdentifier" : @"MapViewController" }];
    [menuData addObject:@{ @"Title" : @"Expanding TableView" , @"StoryIdentifier" : @"ExpandingTableViewController" }];
//    [menuData addObject:@{ @"" : @"" , @"" : @"" }];
//    [menuData addObject:@{ @"" : @"" , @"" : @"" }];
//    [menuData addObject:@{ @"" : @"" , @"" : @"" }];
}

#pragma mark TableView Delegate / Data Source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *nextViewController = [self.storyboard instantiateViewControllerWithIdentifier:[[menuData objectAtIndex:indexPath.row] objectForKey:@"StoryIdentifier"]];
    [self.navigationController pushViewController:nextViewController animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [menuData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];;
    [cell.textLabel setText:[[menuData objectAtIndex:indexPath.row] objectForKey:@"Title"]];
    return cell;
}

@end

