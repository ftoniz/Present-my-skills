//
//  CustomMapPin.m
//  FTPresentDemoProject
//
//  Created by narut on 2/18/15.
//  Copyright (c) 2015 Narut. All rights reserved.
//

#import "CustomMapPin.h"

@implementation CustomMapPin

- (id) initWithTitle:(NSString *)title SubTitle:(NSString *)subTitle Location:(CLLocationCoordinate2D)location{
    self = [super init];
    if (self) {
        self.title = title;
        self.subtitle = subTitle;
        self.coordinate = location;
    }
    return self;
}

- (MKAnnotationView *)annotationViewWithOption:(CustomMapPinOption)option{
    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"TNPinAnnotation"];
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    annotationView.image = [self imageForOption:option];
    annotationView.centerOffset = CGPointMake(0, -20);
    
    return annotationView;
}

- (UIImage *)imageForOption:(CustomMapPinOption)option{
    switch (option) {
        case CustomMapPinOptionRed:
            return [UIImage imageNamed:@"RedPin"];
            break;
        case CustomMapPinOptionPink:
            return [UIImage imageNamed:@"PinkPin"];
            break;
        case CustomMapPinOptionBrown:
            return [UIImage imageNamed:@"BrownPin"];
            break;
        case CustomMapPinOptionYellow:
            return [UIImage imageNamed:@"YellowPin"];
            break;
        default:
            return nil;
            break;
    }
    return nil;
}
@end
