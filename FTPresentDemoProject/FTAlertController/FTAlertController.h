//
//  FTAlertController.h
//  FTAlertController
//
//  Created by narut on 2/7/15.
//  Copyright (c) 2015 Narut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {  FTAlertControllerStyleAlert = 0 ,
                FTAlertControllerStyleActionSheet
            } FTAlertControllerStyle;


@interface FTAlertController : UIViewController <UIAlertViewDelegate,UIActionSheetDelegate>
@property (nonatomic) NSString *messageTitle;
@property (nonatomic) NSString *messageDetail;
@property FTAlertControllerStyle style;

+ (instancetype)alertWithTitle:(NSString *)title Detail:(NSString *)detail Style:(FTAlertControllerStyle)style InViewController:(UIViewController *)viewController;

- (instancetype)initWithTitle:(NSString *)title Detail:(NSString *)detail Style:(FTAlertControllerStyle)style InViewController:(UIViewController *)viewController;

- (UITextField *)textFieldAtIndex:(NSUInteger)index;
- (void)addButtonWithTitle:(NSString *)text Target:(id)target Action:(SEL)action Object:(id)object;
- (void)addButtonWithTitle:(NSString *)text Block:(void(^)(FTAlertController *alert))block;
- (void)addTextFile:(UITextField *)textField;
- (void)setCancelButtonText:(NSString *)text;
- (void)show;
- (void)showInViewController:(UIViewController *)viewController;
- (FTAlertController *)copy;
@end

@interface UIViewController (FTAlertController)

- (void) showFTAlertWithTitle:(NSString *)title detail:(NSString *)detail  cancelText:(NSString *)cancelText style:(FTAlertControllerStyle)style;

@end
