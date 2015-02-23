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
    NSMutableArray *headerData;
    NSMutableArray *innerData;
    NSMutableArray *filterData;
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
    headerData = [NSMutableArray new];
    innerData = [NSMutableArray new];
    filterData = [NSMutableArray new];
    
    [headerData addObject:[[ETOuter alloc] initWithTitle:@"First Outer Cell"]];
    [innerData addObject:@[[[ETInner alloc] initWithTitle:@"First Inner Cell"],[[ETInner alloc] initWithTitle:@"Second Inner Cell"],[[ETInner alloc] initWithTitle:@"Third Inner Cell"]]];


    [headerData addObject:[[ETOuter alloc] initWithTitle:@"Second Outer Cell"]];
    [innerData addObject:@[    [[ETInner alloc] initWithTitle:@"First Inner Cell"],
                                [[ETInner alloc] initWithTitle:@"Second Inner Cell"],
                                [[ETInner alloc] initWithTitle:@"Third Inner Cell"],
                                [[ETInner alloc] initWithTitle:@"Fourth Inner Cell"],
                                [[ETInner alloc] initWithTitle:@"Fifth Inner Cell"] ]];


    [headerData addObject:[[ETOuter alloc] initWithTitle:@"Third Outer Cell"]];
    [innerData addObject:@[ [[ETInner alloc] initWithTitle:@"First Inner Cell"],
                            [[ETInner alloc] initWithTitle:@"Second Inner Cell"],
                            [[ETInner alloc] initWithTitle:@"Third Inner Cell"],
                            [[ETInner alloc] initWithTitle:@"Fourth Inner Cell"],
                            [[ETInner alloc] initWithTitle:@"Fifth Inner Cell"],
                            [[ETInner alloc] initWithTitle:@"Sixth Inner Cell"],
                            [[ETInner alloc] initWithTitle:@"Seventh Inner Cell"] ]];

    [headerData addObject:[[ETOuter alloc] initWithTitle:@"Fourth Outer Cell"]];
    [innerData addObject:@[ [[ETInner alloc] initWithTitle:@"First Inner Cell"],
                            [[ETInner alloc] initWithTitle:@"Second Inner Cell"],
                            [[ETInner alloc] initWithTitle:@"Third Inner Cell"],
                            [[ETInner alloc] initWithTitle:@"Fourth Inner Cell"],
                            [[ETInner alloc] initWithTitle:@"Fifth Inner Cell"],
                            [[ETInner alloc] initWithTitle:@"Sixth Inner Cell"],
                            [[ETInner alloc] initWithTitle:@"Seventh Inner Cell"] ,
                            [[ETInner alloc] initWithTitle:@"Eighth Inner Cell"] ,
                            [[ETInner alloc] initWithTitle:@"Ninth Inner Cell"] ]];

    [headerData addObject:[[ETOuter alloc] initWithTitle:@"Fifth Outer Cell"]];
    [innerData addObject:@[ [[ETInner alloc] initWithTitle:@"First Inner Cell"],
                            [[ETInner alloc] initWithTitle:@"Second Inner Cell"],
                            [[ETInner alloc] initWithTitle:@"Third Inner Cell"],
                            [[ETInner alloc] initWithTitle:@"Fourth Inner Cell"],
                            [[ETInner alloc] initWithTitle:@"Fifth Inner Cell"],
                            [[ETInner alloc] initWithTitle:@"Sixth Inner Cell"],
                            [[ETInner alloc] initWithTitle:@"Seventh Inner Cell"] ,
                            [[ETInner alloc] initWithTitle:@"Eighth Inner Cell"] ,
                            [[ETInner alloc] initWithTitle:@"Ninth Inner Cell"] ,
                            [[ETInner alloc] initWithTitle:@"Tenth Inner Cell"] ]];

    [filterData addObjectsFromArray:headerData];

}



#pragma mark TableView Delegate / Data Source 
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    id object = [filterData objectAtIndex:indexPath.row];
    
    
    if ([object isKindOfClass:[ETOuter class]]) {
        NSUInteger headerIndex = [headerData indexOfObject:object];
        NSMutableArray *reloadIndexPaths = [NSMutableArray new];

        [(ETOuter *)object setExpanded:![(ETOuter *)object expanded]];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        NSArray *innerObject = [innerData objectAtIndex:headerIndex];
        
        for (int i = 1; i <= [innerObject count]; i++) {
            [reloadIndexPaths addObject:[NSIndexPath indexPathForRow:indexPath.row + i inSection:0]];
        }

        if ([(ETOuter *)object expanded]) {
            [filterData insertObjects:innerObject atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(indexPath.row + 1, [innerObject count])]];
            [self.tableView insertRowsAtIndexPaths:reloadIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        else{
            [filterData removeObjectsInArray:innerObject];
            [self.tableView deleteRowsAtIndexPaths:reloadIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [filterData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id object = [filterData objectAtIndex:indexPath.row];
    if ([object isKindOfClass:[ETOuter class]]) {
        return 44;
    }
    else if ([object isKindOfClass:[ETInner class]]){
        return 24;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id object = [filterData objectAtIndex:indexPath.row];
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
