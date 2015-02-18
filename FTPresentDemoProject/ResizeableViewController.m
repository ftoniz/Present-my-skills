//
//  ResizeableViewController.m
//  FTPresentDemoProject
//
//  Created by narut on 2/16/15.
//  Copyright (c) 2015 Narut. All rights reserved.
//

#import "ResizeableViewController.h"

@interface ResizeableViewController ()

@end

@implementation ResizeableViewController{
    NSMutableArray *cellsHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Resizeable TableCell";
    
    cellsHeight = [NSMutableArray new];
    [cellsHeight addObjectsFromArray:@[ @88.0f,@88.0f,@88.0f,
                                        @88.0f,@88.0f,@88.0f,
                                        @88.0f,@88.0f,@88.0f,
                                        @88.0f ] ];
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)increaseHeight:(UIButton *)sender{
    NSNumber *height = [cellsHeight objectAtIndex:sender.tag];
    float heightValue = [height floatValue] + 11.0f;
    height = [NSNumber numberWithFloat:heightValue];
    [cellsHeight replaceObjectAtIndex:sender.tag withObject:height];
    
    [self.tableView reloadData];
}

- (void)decreaseHeight:(UIButton *)sender{
    NSNumber *height = [cellsHeight objectAtIndex:sender.tag];
    float heightValue = [height floatValue] - 11.0f;
    height = [NSNumber numberWithFloat:heightValue];
    [cellsHeight replaceObjectAtIndex:sender.tag withObject:height];
    
    [self.tableView reloadData];
}

#pragma mark TableView Delegate / Data Source
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [cellsHeight count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[cellsHeight objectAtIndex:indexPath.row] floatValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ResizeableTableCell *cell  = [self.tableView cell];
    
    [cell.addButton setTag:indexPath.row];
    [cell.addButton addTarget:self action:@selector(increaseHeight:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.minusButton setTag:indexPath.row];
    [cell.minusButton addTarget:self action:@selector(decreaseHeight:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([[cellsHeight objectAtIndex:indexPath.row] floatValue] <= 88.0f) {
        [cell.minusButton setEnabled:NO];
    }
    else{
        [cell.minusButton setEnabled:YES];
    }
        
    if ([[cellsHeight objectAtIndex:indexPath.row] floatValue] >= 220.0f){
        [cell.addButton setEnabled:NO];
    }
    else{
        [cell.addButton setEnabled:YES];
    }
    
    return cell;
}

@end
