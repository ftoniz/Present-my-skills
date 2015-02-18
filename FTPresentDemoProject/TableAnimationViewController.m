//
//  TableAnimationViewController.m
//  FTPresentDemoProject
//
//  Created by narut on 2/17/15.
//  Copyright (c) 2015 Narut. All rights reserved.
//

#import "TableAnimationViewController.h"

@interface TableAnimationViewController ()

@end

typedef NS_ENUM(NSUInteger, FTableAnimation) {  FTableAnimationFlipFromLeft = 0 ,
                                                FTableAnimationFlipFromRight ,
                                                FTableAnimationFlipFromBottom ,
                                                FTableAnimationSlideFromLeft ,
                                                FTableAnimationSlideFromRight ,
                                                FTableAnimationSlideFromTop ,
                                                FTableAnimationDeepen ,
                                                FTableAnimationStepDeepen ,
                                                FTableAnimationExpandFromCenter ,
                                                FTableAnimationExpandFromLeft ,
                                                FTableAnimationExpandFromRight };
@implementation TableAnimationViewController{
    BOOL tableAnimated;
    FTableAnimation animationOption;
    CGFloat delay;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"AnimationCell";
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Refresh"] style:UIBarButtonItemStyleBordered target:self action:@selector(refreshTable)]];
    tableAnimated = YES;
    animationOption = FTableAnimationStepDeepen;
    delay = 0;
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 
- (void)refreshTable{
    tableAnimated = YES;
    delay = 0;
    [self.tableView reloadData];
}

#pragma mark TableView Delegate / Data Source 
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            animationOption = FTableAnimationFlipFromLeft;
            break;
        case 1:
            animationOption = FTableAnimationFlipFromRight;
            break;
        case 2:
            animationOption = FTableAnimationFlipFromBottom;
            break;
        case 3:
            animationOption = FTableAnimationSlideFromLeft;
            break;
        case 4:
            animationOption = FTableAnimationSlideFromRight;
            break;
        case 5:
            animationOption = FTableAnimationSlideFromTop;
            break;
        case 6:
            animationOption = FTableAnimationDeepen;
            break;
        case 7:
            animationOption = FTableAnimationStepDeepen;
            break;
        case 8:
            animationOption = FTableAnimationExpandFromCenter;
            break;
        case 9:
            animationOption = FTableAnimationExpandFromLeft;
            break;
        case 10:
            animationOption = FTableAnimationExpandFromRight;
            break;
        default:
            return;
    }
    [self refreshTable];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!tableAnimated) {
        return;
    }
    
    if (animationOption == FTableAnimationFlipFromLeft) {
        CGRect bounds = cell.bounds;
        bounds.origin.x = self.view.frame.size.width;
        cell.bounds = bounds;
        
        bounds.origin.x = 0;
        [UIView animateWithDuration:0.3
                              delay:0.1
                            options:UIViewAnimationOptionTransitionFlipFromLeft
                         animations:^(){
                             cell.bounds = bounds;
                         }
                         completion:nil];
    }
    else if (animationOption == FTableAnimationFlipFromRight){
        CGRect bounds = cell.bounds;
        bounds.origin.x = -self.view.frame.size.width;
        cell.bounds = bounds;
        
        bounds.origin.x = 0;
        [UIView animateWithDuration:0.3
                              delay:0.1
                            options:UIViewAnimationOptionTransitionFlipFromRight
                         animations:^(){
                             cell.bounds = bounds;
                         }
                         completion:nil];
    }
    else if (animationOption == FTableAnimationFlipFromBottom){
        CGRect bounds = cell.bounds;
        bounds.origin.y = -self.view.frame.size.height;
        cell.bounds = bounds;
        
        bounds.origin.y = 0;
        [UIView animateWithDuration:0.3
                              delay:0.1
                            options:UIViewAnimationOptionTransitionFlipFromBottom
                         animations:^(){
                             cell.bounds = bounds;
                         }
                         completion:nil];
    }
    else if (animationOption == FTableAnimationSlideFromLeft) {
        CGRect bounds = cell.bounds;
        bounds.origin.x = self.view.frame.size.width;
        cell.bounds = bounds;
        
        bounds.origin.x = 0;
        [UIView animateWithDuration:0.3
                              delay:0.1 + delay
                            options:UIViewAnimationOptionTransitionFlipFromLeft
                         animations:^(){
                             cell.bounds = bounds;
                         }
                         completion:nil];
        delay += 0.1;
    }
    else if (animationOption == FTableAnimationSlideFromRight) {
        CGRect bounds = cell.bounds;
        bounds.origin.x = - self.view.frame.size.width;
        cell.bounds = bounds;
        
        bounds.origin.x = 0;
        [UIView animateWithDuration:0.3
                              delay:0.1 + delay
                            options:UIViewAnimationOptionTransitionFlipFromRight
                         animations:^(){
                             cell.bounds = bounds;
                         }
                         completion:nil];
        delay += 0.1;
    }
    else if (animationOption == FTableAnimationSlideFromTop) {
        CGRect bounds = cell.bounds;
        bounds.origin.y = 60;
        cell.bounds = bounds;
        
        bounds.origin.y = 0;
        [UIView animateWithDuration:0.3
                              delay:0.1 + delay
                            options:UIViewAnimationOptionTransitionFlipFromTop
                         animations:^(){
                             cell.bounds = bounds;
                         }
                         completion:nil];
        delay += 0.1;
    }
    else if (animationOption == FTableAnimationDeepen){
        cell.alpha = 0;
        [UIView animateWithDuration:0.3
                              delay:0.1
                            options:UIViewAnimationOptionShowHideTransitionViews
                         animations:^(){
                             cell.alpha = 1;
                         }
                         completion:nil];
    }
    else if (animationOption == FTableAnimationStepDeepen){
        cell.alpha = 0;
        [UIView animateWithDuration:0.3
                              delay:0.1 + delay
                            options:UIViewAnimationOptionShowHideTransitionViews
                         animations:^(){
                             cell.alpha = 1;
                         }
                         completion:nil];
        delay += 0.1;
    }
    else if (animationOption == FTableAnimationExpandFromCenter){
        cell.transform = CGAffineTransformMakeScale(0, 0);
        [UIView animateWithDuration:0.5
                              delay:0.1 + delay
                            options:UIViewAnimationOptionCurveLinear
                         animations:^(){
                             cell.transform = CGAffineTransformMakeScale(1, 1);
                         }
                         completion:nil];
        delay += 0.1;
    }
    else if (animationOption == FTableAnimationExpandFromLeft){
        cell.transform = CGAffineTransformScale(CGAffineTransformMakeTranslation(- self.view.frame.size.width, 0), 0, 0);
        [UIView animateWithDuration:0.5
                              delay:0.1 + delay
                            options:UIViewAnimationOptionCurveLinear
                         animations:^(){
                            cell.transform = CGAffineTransformScale(CGAffineTransformMakeTranslation(0, 0), 1, 1);
                         }
                         completion:nil];
        delay += 0.1;
    }
    else if (animationOption == FTableAnimationExpandFromRight){
        cell.transform = CGAffineTransformScale(CGAffineTransformMakeTranslation(self.view.frame.size.width, 0), 0, 0);
        [UIView animateWithDuration:0.5
                              delay:0.1 + delay
                            options:UIViewAnimationOptionCurveLinear
                         animations:^(){
                            cell.transform = CGAffineTransformScale(CGAffineTransformMakeTranslation(0, 0), 1, 1);
                         }
                         completion:nil];
        delay += 0.1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    switch (indexPath.row) {
        case 0:
            [cell.textLabel setText:@"FlipFromLeft"];
            break;
        case 1:
            [cell.textLabel setText:@"FlipFromRight"];
            break;
        case 2:
            [cell.textLabel setText:@"FlipFromBottom"];
            break;
        case 3:
            [cell.textLabel setText:@"SlideFromLeft"];
            break;
        case 4:
            [cell.textLabel setText:@"SlpdeFromRight"];
            break;
        case 5:
            [cell.textLabel setText:@"SlideFromTop"];
            break;
        case 6:
            [cell.textLabel setText:@"Deepen"];
            break;
        case 7:
            [cell.textLabel setText:@"Step Deepen"];
            break;
        case 8:
            [cell.textLabel setText:@"ExpandFromCenter"];
            break;
        case 9:
            [cell.textLabel setText:@"ExpandFromLeft"];
            break;
        case 10:
            [cell.textLabel setText:@"ExpandFromRight"];
            break;
        default:
            [cell.textLabel setText:@"Animated"];
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    tableAnimated = NO;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}
@end
