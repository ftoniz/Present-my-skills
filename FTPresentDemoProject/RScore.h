//
//  RScore.h
//  FTPresentDemoProject
//
//  Created by FToniz on 3/4/2558 BE.
//  Copyright (c) 2558 Narut. All rights reserved.
//

#import "RLMObject.h"

@class RClass;
@interface RScore : RLMObject
@property NSString *ownerName;
@property NSInteger score;
@property RClass *ownerClass;
@end
