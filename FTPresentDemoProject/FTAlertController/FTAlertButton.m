//
//  FTAlertButton.m
//  FTAlertController
//
//  Created by narut on 2/7/15.
//  Copyright (c) 2015 Narut. All rights reserved.
//

#import "FTAlertButton.h"
@interface FTAlertButton ()
@property (readwrite , nonatomic) SEL action;
@property (readwrite , nonatomic) id target;
@property (readwrite , nonatomic) id object;
@property (readwrite , nonatomic) void (^block)(id object);
@end

@implementation FTAlertButton

- (instancetype)initWithText:(NSString *)text Target:(id)target Action:(SEL)action Object:(id)object{
    self = [super init];
    if (self) {
        self.text = text;
        self.action = action;
        self.target = target;
        self.object = object;
        self.block = nil;
    }
    return self;
}

- (instancetype)initWithText:(NSString *)text Block:(void (^)(id))block{
    self = [super init];
    if (self) {
        self.text = text;
        self.action = nil;
        self.target = nil;
        self.object = nil;
        self.block = block;
    }
    return self;
}

@end
