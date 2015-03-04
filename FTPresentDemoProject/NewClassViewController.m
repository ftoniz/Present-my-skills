//
//  NewClassViewController.m
//  FTPresentDemoProject
//
//  Created by FToniz on 3/4/2558 BE.
//  Copyright (c) 2558 Narut. All rights reserved.
//

#import "NewClassViewController.h"
#import <Realm/Realm.h>
#import "FTAlertController/FTAlertController.h"
#import "RClass.h"
@interface NewClassViewController () <UITableViewDataSource , UITableViewDelegate , UITextFieldDelegate>

@end

@implementation NewClassViewController{
    UITapGestureRecognizer *tapToEndEditing;
    NSString *classID;
    NSString *className;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self setTitle:@"Add Class"];
    classID = @"";
    className = @"";
    
    tapToEndEditing = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditing)];
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(closeHandle:)]];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"Save"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                                style:UIBarButtonItemStyleDone target:self action:@selector(saveHandle:)]];
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
    if ([classID isEqualToString:@""] || [className isEqualToString:@""]) {
        [self showFTAlertWithTitle:@"Warning" detail:@"Please Inseart ClassName and ClassID" cancelText:@"OK" style:FTAlertControllerStyleAlert];
        return;
    }
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    RClass *myClass = [[RClass alloc] init];
    [myClass setCid:classID];
    [myClass setName:className];
    
    [realm beginWriteTransaction];
    [realm addObject:myClass];
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
        classID = textField.text;
    }
    else if ([textField tag] == 2){
        className = textField.text;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField tag] == 1) {
        [[self.view viewWithTag:2] becomeFirstResponder];
    }
    else if ([textField tag] == 2){
        [self saveHandle:nil];
    }
    return YES;
}

#pragma mark TableView Delegate / Data Source
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [[cell viewWithTag:1] becomeFirstResponder];
    }
    else if (indexPath.row == 1){
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [[cell viewWithTag:2] becomeFirstResponder];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IdCell"];
        [(UITextField *)[cell viewWithTag:1] setDelegate:self];
        return cell;
    }
    else if (indexPath.row == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NameCell"];
        [(UITextField *)[cell viewWithTag:2] setDelegate:self];
        return cell;
    }
    return nil;
}

@end
