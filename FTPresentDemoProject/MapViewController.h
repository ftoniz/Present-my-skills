//
//  MapViewController.h
//  FTPresentDemoProject
//
//  Created by narut on 2/17/15.
//  Copyright (c) 2015 Narut. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface MapViewController : UIViewController <MKMapViewDelegate>
@property (nonatomic) IBOutlet MKMapView *mapView;


@end
