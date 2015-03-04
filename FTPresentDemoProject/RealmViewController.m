//
//  RealmViewController.m
//  FTPresentDemoProject
//
//  Created by FToniz on 3/4/2558 BE.
//  Copyright (c) 2558 Narut. All rights reserved.
//

#import "RealmViewController.h"
#import <Realm/Realm.h>
#import "RClass.h"
#import "RScore.h"

#import "ScoreRealmViewController.h"
#import "NewClassViewController.h"
#import "FTPortraitNavigationController.h"
@interface RealmViewController () <UITableViewDataSource , UITableViewDelegate>

@end

@implementation RealmViewController{
    RLMResults *data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"ClassRoom"];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                                style:UIBarButtonItemStyleDone target:self action:@selector(newClassHandle:)]];
    
    data = [RClass allObjects];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)newClassHandle:(id)sender{
    NewClassViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NewClassViewController"];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self presentViewController:navController animated:YES completion:nil];
}


# pragma mark TableView Delegate / Data source
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RClass *selectedClass = [data objectAtIndex:indexPath.row];
    ScoreRealmViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ScoreRealmViewController"];
    [viewController setClass:selectedClass];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    RClass *myClass = [data objectAtIndex:indexPath.row];
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ownerClass == %@",myClass];
    RLMResults *myClassScore = [RScore objectsWithPredicate:predicate];    
    
    [realm beginWriteTransaction];
    [realm deleteObjects:myClassScore];
    [realm deleteObject:myClass];
    [realm commitWriteTransaction];
    
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RClass *myClass = [data objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    [cell.textLabel setText:myClass.name];
    [cell.detailTextLabel setText:myClass.cid];
    return cell;
}

@end
