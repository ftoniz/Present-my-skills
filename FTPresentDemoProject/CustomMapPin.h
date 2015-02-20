//
//  CustomMapPin.h
//  FTPresentDemoProject
//
//  Created by narut on 2/18/15.
//  Copyright (c) 2015 Narut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


typedef NS_ENUM(NSUInteger , CustomMapPinOption) {  CustomMapPinOptionRed = 0 ,
                                                    CustomMapPinOptionYellow ,
                                                    CustomMapPinOptionBrown ,
                                                    CustomMapPinOptionPink };
@interface CustomMapPin : NSObject <MKAnnotation>
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (copy , nonatomic) NSString *title;
@property (copy , nonatomic) NSString *subtitle;
@property (readwrite , nonatomic) NSString *url;

- (id) initWithTitle:(NSString *)title SubTitle:(NSString *)subTitle Location:(CLLocationCoordinate2D)location;
- (MKAnnotationView *)annotationViewWithOption:(CustomMapPinOption)option;
@end
