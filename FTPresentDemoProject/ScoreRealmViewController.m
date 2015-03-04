//
//  ScoreRealmViewController.m
//  FTPresentDemoProject
//
//  Created by FToniz on 3/4/2558 BE.
//  Copyright (c) 2558 Narut. All rights reserved.
//

#import "ScoreRealmViewController.h"
#import "AddScoreRealmViewController.h"
#import "FTPortraitNavigationController.h"
#import "RClass.h"
#import "RScore.h"

#import <Realm/Realm.h>
@interface ScoreRealmViewController () <UITableViewDataSource , UITableViewDelegate>

@end

@implementation ScoreRealmViewController{
    RLMResults *data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self queryScore];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    [self setTitle:self.currentClass.name];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(addScoreHandle:)]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)addScoreHandle:(id)sender{
    AddScoreRealmViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddScoreRealmViewController"];
    [viewController setClass:self.currentClass];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    [self presentViewController:navController animated:YES completion:nil];
}

- (void)queryScore{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ownerClass == %@",self.currentClass];
    data = [RScore objectsWithPredicate:predicate];
}

#pragma mark TableView Delegate / Data Source
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    RScore *selectedScore = [data objectAtIndex:indexPath.row];
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteObject:selectedScore];
    [realm commitWriteTransaction];
    
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [data count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RScore *myScore = [data objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    [cell.textLabel setText:myScore.ownerName];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%zd",myScore.score]];
    return cell;
}

@end
