//
//  FTAlertController.m
//  FTAlertController
//
//  Created by narut on 2/7/15.
//  Copyright (c) 2015 Narut. All rights reserved.
//

#import "FTAlertController.h"
#import "FTAlertButton.h"
@interface FTAlertController ()
@property (strong , nonatomic) UIAlertView *alert;
@property (strong , nonatomic) UIActionSheet *actionSheet;
@end

@implementation FTAlertController{
    NSArray *buttonArray;
    NSArray *textFieldArray;
    NSString *closeButtonTitle;
    UIAlertController *alertController;
    UIViewController *alertViewController;
}

#pragma mark -
+ (instancetype)alertWithTitle:(NSString *)title Detail:(NSString *)detail Style:(FTAlertControllerStyle)style InViewController:(UIViewController *)viewController{
    return [[self alloc] initWithTitle:title Detail:detail Style:style InViewController:viewController];
}

- (instancetype)initWithTitle:(NSString *)title Detail:(NSString *)detail Style:(FTAlertControllerStyle)style InViewController:(UIViewController *)viewController{
    self = [super init];
    if (self) {
        [self setMessageTitle:title];
        [self setMessageDetail:detail];
        [self setCancelButtonText:@"Close"];
        [self setViewController:viewController];
        [self setStyle:style];
    }
    return self;
}

- (UITextField *)textFieldAtIndex:(NSUInteger)index{
    UITextField *textField;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0f ) {
        textField = [_alert textFieldAtIndex:index];
    }
    else{
        textField = [[alertController textFields] objectAtIndex:index];
    }
    return textField;
}

- (void)setCancelButtonText:(NSString *)text{
    closeButtonTitle = text;
}

- (void)setViewController:(UIViewController *)viewController{
    alertViewController = viewController;
}

- (void)addButtonWithTitle:(NSString *)text Target:(id)target Action:(SEL)action Object:(id)object{
    FTAlertButton *button = [[FTAlertButton alloc] initWithText:text Target:target Action:action Object:object];
    
    NSMutableArray *tmpArray = [NSMutableArray new];
    if (buttonArray) {
        [tmpArray addObjectsFromArray:buttonArray];
    }
    [tmpArray addObject:button];
    buttonArray = [NSArray arrayWithArray:tmpArray];
}

- (void)addButtonWithTitle:(NSString *)text Block:(void(^)(FTAlertController *alert))block{
    FTAlertButton *button = [[FTAlertButton alloc] initWithText:text Block:block];
    
    NSMutableArray *tmpArray = [NSMutableArray new];
    if (buttonArray) {
        [tmpArray addObjectsFromArray:buttonArray];
    }
    [tmpArray addObject:button];
    buttonArray = [NSArray arrayWithArray:tmpArray];
}

- (void)addTextFile:(UITextField *)textField{
    NSMutableArray *tmpArray = [NSMutableArray new];
    if (textFieldArray) {
        [tmpArray addObjectsFromArray:textFieldArray];
    }
    [tmpArray addObject:textField];
    textFieldArray = [NSArray arrayWithArray:tmpArray];
}

- (void)show{
    [self showInViewController:alertViewController];
}

- (void)showInViewController:(UIViewController *)viewController{
    if (self.style == FTAlertControllerStyleAlert) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
            [self showAlertViewInController:viewController];
        }
        else{
            [self showAlertControllerInController:viewController];
        }
    }
    else if (self.style == FTAlertControllerStyleActionSheet){
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
            [self showActionSheetInController:viewController];
        }
        else{
            [self showActionSheetControllerInController:viewController];
        }
    }
}

- (void)showAlertViewInController:(UIViewController *)viewController{
    _alert = [[UIAlertView alloc] initWithTitle:self.messageTitle message:self.messageDetail delegate:self cancelButtonTitle:closeButtonTitle otherButtonTitles:nil];
    
    for (UITextField *textField in textFieldArray) {
        [_alert addSubview:textField];
    }
    
    switch ([textFieldArray count]) {
        case 0:
            [_alert setAlertViewStyle:UIAlertViewStyleDefault];
            break;
        case 1:
            [_alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
            [[_alert textFieldAtIndex:0] setPlaceholder:[(UITextField *)textFieldArray[0] placeholder]];
            [[_alert textFieldAtIndex:0] setText:[(UITextField *)textFieldArray[0] text]];
            [[_alert textFieldAtIndex:0] setTag:[(UITextField *)textFieldArray[0] tag]];
            [[_alert textFieldAtIndex:0] setReturnKeyType:[(UITextField *)textFieldArray[0] returnKeyType]];
            [[_alert textFieldAtIndex:0] setSecureTextEntry:[(UITextField *)textFieldArray[0] isSecureTextEntry]];
            break;
        case 2:
            [_alert setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
            
            
            [[_alert textFieldAtIndex:0] setPlaceholder:[(UITextField *)textFieldArray[0] placeholder]];
            [[_alert textFieldAtIndex:0] setText:[(UITextField *)textFieldArray[0] text]];
            [[_alert textFieldAtIndex:0] setTag:[(UITextField *)textFieldArray[0] tag]];
            [[_alert textFieldAtIndex:0] setReturnKeyType:[(UITextField *)textFieldArray[0] returnKeyType]];
            [[_alert textFieldAtIndex:0] setSecureTextEntry:[(UITextField *)textFieldArray[0] isSecureTextEntry]];
            
            [[_alert textFieldAtIndex:1] setPlaceholder:[(UITextField *)textFieldArray[1] placeholder]];
            [[_alert textFieldAtIndex:1] setText:[(UITextField *)textFieldArray[1] text]];
            [[_alert textFieldAtIndex:1] setTag:[(UITextField *)textFieldArray[1] tag]];
            [[_alert textFieldAtIndex:1] setReturnKeyType:[(UITextField *)textFieldArray[1] returnKeyType]];
            [[_alert textFieldAtIndex:1] setSecureTextEntry:[(UITextField *)textFieldArray[1] isSecureTextEntry]];
            break;
        default:
            [_alert setAlertViewStyle:UIAlertViewStyleDefault];
            break;
    }
    
    for (FTAlertButton *button in buttonArray) {
        [_alert addButtonWithTitle:button.text];
    }
    [_alert show];
    [viewController addChildViewController:self];
}

- (void)showAlertControllerInController:(UIViewController *)viewController{
    alertController = [UIAlertController alertControllerWithTitle:self.messageTitle message:self.messageDetail preferredStyle:UIAlertControllerStyleAlert];
    
    for (UITextField *tmpTextField in textFieldArray) {
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
            [textField setText:tmpTextField.text];
            [textField setPlaceholder:tmpTextField.placeholder];
            [textField setTag:tmpTextField.tag];
            [textField setReturnKeyType:tmpTextField.returnKeyType];
            [textField setSecureTextEntry:tmpTextField.isSecureTextEntry];
        }];
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:closeButtonTitle style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    for (FTAlertButton *button in buttonArray) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:button.text
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action){
                                                           if (button.target) {
                                                               [button.target performSelectorOnMainThread:button.action withObject:self waitUntilDone:YES];
                                                           }
                                                           else if(button.block){
                                                               button.block(self);
                                                           }
                                                       }];
        [alertController addAction:action];
    }
    [viewController presentViewController:alertController animated:YES completion:nil];
}

- (void)showActionSheetInController:(UIViewController *)viewController{
    _actionSheet = [[UIActionSheet alloc] initWithTitle:self.messageTitle delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    for (FTAlertButton *button in buttonArray) {
        [_actionSheet addButtonWithTitle:button.text];
    }
    [_actionSheet addButtonWithTitle:closeButtonTitle];
    [_actionSheet showInView:viewController.view];
    [viewController addChildViewController:self];
}

- (void)showActionSheetControllerInController:(UIViewController *)viewController{
    alertController = [UIAlertController alertControllerWithTitle:self.messageTitle message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:closeButtonTitle style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    for (FTAlertButton *button in buttonArray) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:button.text
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action){
                                                           if (button.target) {
                                                               [button.target performSelectorOnMainThread:button.action withObject:self waitUntilDone:YES];
                                                           }
                                                           else if(button.block){
                                                               button.block(self);
                                                           }
                                                       }];
        [alertController addAction:action];
    }
    [viewController presentViewController:alertController animated:YES completion:nil];
}

- (FTAlertController *)copy{
    return nil;
}

# pragma mark AlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    @try {
        if (buttonIndex > 0) {
            FTAlertButton *alertButton = [buttonArray objectAtIndex:buttonIndex - 1];
            if (alertButton.target) {
                [alertButton.target performSelectorOnMainThread:alertButton.action withObject:self waitUntilDone:YES];
            }
            else if(alertButton.block){
                alertButton.block(self);
            }
        }
    }
    @catch (NSException *exception) {
        
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    [self removeFromParentViewController];
}

#pragma mark Action Sheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    @try {
        FTAlertButton *alertButton = [buttonArray objectAtIndex:buttonIndex];
        if (alertButton.target) {
            [alertButton.target performSelectorOnMainThread:alertButton.action withObject:self waitUntilDone:YES];
        }
        else if(alertButton.block){
            alertButton.block(self);
        }
    }
    @catch (NSException *exception) {

    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    [self removeFromParentViewController];
}
@end

@implementation UIViewController (FTAlertController)

- (void)showFTAlertWithTitle:(NSString *)title detail:(NSString *)detail cancelText:(NSString *)cancelText style:(FTAlertControllerStyle)style{
    FTAlertController *alert = [FTAlertController alertWithTitle:title Detail:detail Style:style InViewController:self];
    [alert setCancelButtonText:cancelText];
    [alert show];
}

@end
