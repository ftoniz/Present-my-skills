//
//  FTAlertButton.h
//  FTAlertController
//
//  Created by narut on 2/7/15.
//  Copyright (c) 2015 Narut. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTAlertButton : NSObject
@property (nonatomic) NSString *text;
@property (readonly , nonatomic) SEL action;
@property (readonly , nonatomic) id target;
@property (readonly , nonatomic) id object;
@property (readonly , nonatomic) void (^block)(id object);

- (instancetype)initWithText:(NSString *)text Target:(id)target Action:(SEL)action Object:(id)object;
- (instancetype)initWithText:(NSString *)text Block:(void(^)(id object))block;
@end
