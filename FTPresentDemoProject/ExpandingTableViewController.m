//
//  ExpandingTableViewController.m
//  FTPresentDemoProject
//
//  Created by narut on 2/22/15.
//  Copyright (c) 2015 Narut. All rights reserved.
//

#import "ExpandingTableViewController.h"

@interface ExpandingTableViewController ()
@property (nonatomic) IBOutlet ETTableView *tableView;
@end

@implementation ExpandingTableViewController{
    NSMutableArray *data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Expanding TableView"];
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    [self makeData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)makeData{
    data = [NSMutableArray new];
    
    [data addObject:[[ETOuter alloc] initWithTitle:@"First Outer Cell"]];
    [data addObject:[[ETInner alloc] initWithTitle:@"First Inner Cell"]];
    [data addObject:[[ETInner alloc] initWithTitle:@"Second Inner Cell"]];
    [data addObject:[[ETInner alloc] initWithTitle:@"Third Inner Cell"]];

    [data addObject:[[ETOuter alloc] initWithTitle:@"Second Outer Cell"]];
    [data addObject:[[ETInner alloc] initWithTitle:@"First Inner Cell"]];
    [data addObject:[[ETInner alloc] initWithTitle:@"Second Inner Cell"]];
    [data addObject:[[ETInner alloc] initWithTitle:@"Third Inner Cell"]];
    [data addObject:[[ETInner alloc] initWithTitle:@"Fourth Inner Cell"]];
    [data addObject:[[ETInner alloc] initWithTitle:@"Fifth Inner Cell"]];

    [data addObject:[[ETOuter alloc] initWithTitle:@"Third Outer Cell"]];
    [data addObject:[[ETInner alloc] initWithTitle:@"First Inner Cell"]];
    [data addObject:[[ETInner alloc] initWithTitle:@"Second Inner Cell"]];
    [data addObject:[[ETInner alloc] initWithTitle:@"Third Inner Cell"]];
    [data addObject:[[ETInner alloc] initWithTitle:@"Fourth Inner Cell"]];
    [data addObject:[[ETInner alloc] initWithTitle:@"Fifth Inner Cell"]];
    [data addObject:[[ETInner alloc] initWithTitle:@"Sixth Inner Cell"]];
    [data addObject:[[ETInner alloc] initWithTitle:@"Seventh Inner Cell"]];

    [data addObject:[[ETOuter alloc] initWithTitle:@"Fourth Outer Cell"]];
    [data addObject:[[ETInner alloc] initWithTitle:@"First Inner Cell"]];
    [data addObject:[[ETInner alloc] initWithTitle:@"Second Inner Cell"]];
    [data addObject:[[ETInner alloc] initWithTitle:@"Third Inner Cell"]];
    [data addObject:[[ETInner alloc] initWithTitle:@"Fourth Inner Cell"]];
    [data addObject:[[ETInner alloc] initWithTitle:@"Fifth Inner Cell"]];
    [data addObject:[[ETInner alloc] initWithTitle:@"Sixth Inner Cell"]];
    [data addObject:[[ETInner alloc] initWithTitle:@"Seventh Inner Cell"]];
    [data addObject:[[ETInner alloc] initWithTitle:@"Eighth Inner Cell"]];
    [data addObject:[[ETInner alloc] initWithTitle:@"Ninth Inner Cell"]];

    [data addObject:[[ETOuter alloc] initWithTitle:@"Fifth Outer Cell"]];
    [data addObject:[[ETInner alloc] initWithTitle:@"First Inner Cell"]];
    [data addObject:[[ETInner alloc] initWithTitle:@"Second Inner Cell"]];
    [data addObject:[[ETInner alloc] initWithTitle:@"Third Inner Cell"]];
    [data addObject:[[ETInner alloc] initWithTitle:@"Fourth Inner Cell"]];
    [data addObject:[[ETInner alloc] initWithTitle:@"Fifth Inner Cell"]];
    [data addObject:[[ETInner alloc] initWithTitle:@"Sixth Inner Cell"]];
    [data addObject:[[ETInner alloc] initWithTitle:@"Seventh Inner Cell"]];
    [data addObject:[[ETInner alloc] initWithTitle:@"Eighth Inner Cell"]];
    [data addObject:[[ETInner alloc] initWithTitle:@"Ninth Inner Cell"]];
    [data addObject:[[ETInner alloc] initWithTitle:@"Tenth Inner Cell"]];

}

#pragma mark TableView Delegate / Data Source 
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    id object = [data objectAtIndex:indexPath.row];
    if ([object isKindOfClass:[ETOuter class]]) {
        NSMutableArray *relaodIndexPaths = [NSMutableArray new];

        [(ETOuter *)object setExpanded:![(ETOuter *)object expanded]];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        NSUInteger i = 1;
        while (indexPath.row + i < [data count]) {
            if ([[data objectAtIndex:indexPath.row + i] isKindOfClass:[ETOuter class]]) {
                break;
            }
            else{
                ETInner *innerObject = [data objectAtIndex:indexPath.row + i];
                [innerObject setVisible:![innerObject visible]];
                [relaodIndexPaths addObject:[NSIndexPath indexPathForRow:indexPath.row + i inSection:0]];
            }
            i++;
        }
        [self.tableView reloadRowsAtIndexPaths:relaodIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [data count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id object = [data objectAtIndex:indexPath.row];
    if ([object isKindOfClass:[ETOuter class]]) {
        return 44;
    }
    else if ([object isKindOfClass:[ETInner class]]){
        if ([(ETInner *)object visible] ) {
            return 24;
        }
        else{
            return 0.0001f;
        }
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id object = [data objectAtIndex:indexPath.row];
    if ([object isKindOfClass:[ETOuter class]]) {
        ETOuterCell *cell = [self.tableView outerCellWithTitle:[object valueForKey:@"title"] stage:[(ETOuter *)object expanded] ? ETOuterStageExpanded : ETOuterStageContracted];
        return cell;
    }
    else if([object isKindOfClass:[ETInner class]]){
        ETInnerCell *cell = [self.tableView innerCellWithTitle:[object valueForKey:@"title"]];
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

@end
