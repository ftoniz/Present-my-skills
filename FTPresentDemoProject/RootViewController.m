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

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Menu";
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -

#pragma mark TableView Delegate / Data Source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *nextViewController;
    switch (indexPath.row) {
        case 0:
            nextViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SlideImageViewController"];
            break;
        case 1:
            nextViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ResizeableViewController"];
            break;
        case 2:
            nextViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TableAnimationViewController"];
            break;
        case 3:
            nextViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
            break;
        case 4:
            nextViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CameraViewController"];
            break;
        default:
            break;
    }
    
    [self.navigationController pushViewController:nextViewController animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    switch (indexPath.row) {
        case 0:
            cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
            [cell.textLabel setText:@"Slide Image"];
            return cell;
        case 1:
            cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
            [cell.textLabel setText:@"Resizeable Cell"];
            return cell;
        case 2:
            cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
            [cell.textLabel setText:@"Animation TableViewCell"];
            return cell;
        case 3:
            cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
            [cell.textLabel setText:@"MapKit"];
            return cell;
        case 4:
            cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
            [cell.textLabel setText:@"Camera"];
            return cell;
        default:
            break;
    }
    
    return nil;
}

@end

