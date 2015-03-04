//
//  AddScoreRealmViewController.m
//  FTPresentDemoProject
//
//  Created by FToniz on 3/4/2558 BE.
//  Copyright (c) 2558 Narut. All rights reserved.
//

#import "AddScoreRealmViewController.h"
#import <Realm/Realm.h>
#import "RScore.h"
#import "FTAlertController/FTAlertController.h"
@interface AddScoreRealmViewController () <UITableViewDataSource , UITableViewDelegate , UITextFieldDelegate>

@end

@implementation AddScoreRealmViewController{
    NSString *ownerName;
    NSString *score;
    UITapGestureRecognizer *tapToEndEditing;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Add Score"];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(closeHandle:)]];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"Save"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(saveHandle:)]];
    tapToEndEditing = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditing)];
    
    ownerName = @"";
    score = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
- (void)closeHandle:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveHandle:(id)sender{
    [self.view endEditing:YES];
    if ([ownerName isEqualToString:@""] || [score isEqualToString:@""]) {
        [self showFTAlertWithTitle:@"Warning" detail:@"Please Inseart Name and Score" cancelText:@"OK" style:FTAlertControllerStyleAlert];
        return;
    }
    RLMRealm *realm = [RLMRealm defaultRealm];
    RScore *newScore = [[RScore alloc] init];
    [newScore setOwnerClass:self.currentClass];
    [newScore setOwnerName:ownerName];
    [newScore setScore:[score integerValue]];
    
    [realm beginWriteTransaction];
    [realm addObject:newScore];
    [realm commitWriteTransaction];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)endEditing{
    [self.view endEditing:YES];
}

#pragma mark TextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self.tableView addGestureRecognizer:tapToEndEditing];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self.tableView removeGestureRecognizer:tapToEndEditing];
    if ([textField tag] == 1) {
        ownerName = textField.text;
    }
    else if ([textField tag] == 2){
        score = textField.text;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField tag] == 1) {
        [[self.view viewWithTag:2] becomeFirstResponder];
    }
    
    return YES;
}

#pragma mark TableView Delegate / Data source
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NameCell"];
        [(UITextField *)[cell viewWithTag:1] setDelegate:self];
        return cell;
    }
    else if (indexPath.row == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScoreCell"];
        [(UITextField *)[cell viewWithTag:2] setDelegate:self];
        return cell;
    }
    
    return nil;
}

@end
