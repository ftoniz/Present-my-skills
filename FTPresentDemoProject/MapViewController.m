//
//  MapViewController.m
//  FTPresentDemoProject
//
//  Created by narut on 2/17/15.
//  Copyright (c) 2015 Narut. All rights reserved.
//

#import "MapViewController.h"
#import "CustomMapPin.h"
#import "WebViewController.h"
@interface MapViewController ()

@end

@implementation MapViewController{
    CLLocationManager *locationManager;
    NSArray *demoData;
    CustomMapPinOption pinOption;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MapView";
    pinOption = CustomMapPinOptionRed;
    
    [self.mapView setShowsUserLocation:NO];
    [self.mapView setDelegate:self];
    [self locationAuthorization];
    demoData = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MapLocationDemo" ofType:@"plist"]];
    NSLog(@"%@",demoData);
    [self addPointInMap];
    
    [self.redButton addTarget:self action:@selector(changePinToRed) forControlEvents:UIControlEventTouchUpInside];
    [self.brownButton addTarget:self action:@selector(changePinToBrown) forControlEvents:UIControlEventTouchUpInside];
    [self.yellowButton addTarget:self action:@selector(changePinToYellow) forControlEvents:UIControlEventTouchUpInside];
    [self.pinkButton addTarget:self action:@selector(changePinToPink) forControlEvents:UIControlEventTouchUpInside];
    

    [self.mapView setRegion:[self.mapView regionThatFits:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(13.75955, 100.52394), 15000, 15000)] ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)locationAuthorization{
    locationManager = [[CLLocationManager alloc]init];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8) {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
    [self.mapView setShowsUserLocation:YES];
}

- (void)addPointInMap{
    for (NSDictionary *point in demoData) {
        NSString *pointName = [point objectForKey:@"Name"];
        NSString *pointAddress = [point objectForKey:@"Description"];
        NSString *pointURL = [point objectForKey:@"URL"];
        CLLocationCoordinate2D pointLocation = CLLocationCoordinate2DMake([[[point objectForKey:@"Location"] objectForKey:@"Latitude"] doubleValue], [[[point objectForKey:@"Location"] objectForKey:@"Longitude"] doubleValue]);
        CustomMapPin *mapPin = [[CustomMapPin alloc] initWithTitle:pointName SubTitle:pointAddress Location:pointLocation];
        [mapPin setUrl:pointURL];
        [self.mapView addAnnotation:mapPin];
    }
}

- (void)refreshPointInMap{
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self addPointInMap];
}

- (void)presentWebForURL:(NSString *)url title:(NSString *)title{
    WebViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    [viewController setStarterURL:url];
    [viewController setTitle:title];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    [self presentViewController:navController animated:YES completion:nil];
}
#pragma mark Change Pin Color
- (void)changePinToRed{
    pinOption = CustomMapPinOptionRed;
    [self refreshPointInMap];
}

- (void)changePinToYellow{
    pinOption = CustomMapPinOptionYellow;
    [self refreshPointInMap];
}

- (void)changePinToBrown{
    pinOption = CustomMapPinOptionBrown;
    [self refreshPointInMap];
}

- (void)changePinToPink{
    pinOption = CustomMapPinOptionPink;
    [self refreshPointInMap];
}

- (NSUInteger)indexOfURL:(NSString *)url{
    for (NSUInteger index = 0 ; index < [demoData count] ; index++) {
        if ([demoData[index][@"URL"] isEqualToString:url]) {
            return index;
        }
    }
    
    return 0;
}

#pragma mark MapView Delegate
- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error{
    NSLog(@"Load map Error : %@",error);
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if ([annotation isKindOfClass:[CustomMapPin class]]) {
        CustomMapPin *customAnnotation = annotation;
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomMapPin"];
        annotationView = [customAnnotation annotationViewWithOption:pinOption];
        [annotationView setTag:[self indexOfURL:customAnnotation.url]];
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    if ([control allControlEvents] == UIControlEventTouchUpInside ) {
        [self presentWebForURL:demoData[view.tag][@"URL"] title:demoData[view.tag][@"URL Name"]];
    }
}


@end
