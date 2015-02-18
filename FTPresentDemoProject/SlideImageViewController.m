//
//  SlideImageViewController.m
//  FTPresentDemoProject
//
//  Created by narut on 2/15/15.
//  Copyright (c) 2015 Narut. All rights reserved.
//

#import "SlideImageViewController.h"

@interface SlideImageViewController ()

@end

@implementation SlideImageViewController{
    NSUInteger imageIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Slide Image";
    [self.scrollView setDelegate:self];
    [self.scrollView setDecelerationRate:0.01];
    imageIndex = 1;
    CGSize viewSize;
    viewSize = [[[[[UIApplication sharedApplication] delegate] window] rootViewController] view].bounds.size;
    viewSize.height -= 64;
    [self makeImageSlideForSize:viewSize];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)makeImageSlideForSize:(CGSize)size{
    NSArray *imagesName = @[@"Image3.jpg",@"Image1.jpg",@"Image2.jpg",@"Image3.jpg",@"Image1.jpg"];
    NSUInteger scrollIndex = 0;
    for (NSString *imageName in imagesName) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        CGRect frame = CGRectMake(0, 0, size.width, size.height );
        frame.origin.x = size.width * scrollIndex;
        scrollIndex++;
        
        imageView.frame = frame;
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        
        [self.scrollView addSubview:imageView];
    }
    [self.scrollView setContentSize:CGSizeMake(scrollIndex * size.width, 0)];
    [self.scrollView setContentOffset:CGPointMake(imageIndex * size.width, 0)];
}

- (void)resizeImageSlideForSize:(CGSize)size{
    NSUInteger scrollIndex = 0;
    for (UIView *view in self.scrollView.subviews) {
        CGRect frame = view.frame;
        frame.size = size;
        frame.origin.x = size.width * scrollIndex;
        scrollIndex++;
        
        view.frame = frame;
    }
    [self.scrollView setContentSize:CGSizeMake(scrollIndex * size.width, 0)];
    [self.scrollView setContentOffset:CGPointMake(imageIndex * size.width, 0)];
}

- (void)upDateImageIndex{
    CGSize size = self.scrollView.bounds.size;
    imageIndex = self.scrollView.contentOffset.x / size.width;
    if (imageIndex == 0) {
        imageIndex = 3;
    }
    else if (imageIndex == 4){
        imageIndex = 1;
    }
    [self.scrollView setContentOffset:CGPointMake(imageIndex * size.width, 0) animated:NO];
}

#pragma mark ScrollView Delegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        [self upDateImageIndex];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self upDateImageIndex];
}

#pragma mark Rotation
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    CGSize scrollSize = size;
    if (size.width < size.height) {
        scrollSize.height -= 64;
    }

    [coordinator animateAlongsideTransition:^(id context){
        
        [self resizeImageSlideForSize:scrollSize];
    }
                                 completion:^(id context){
                                    
                                 }];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    CGRect frame = self.view.frame;
    CGSize size;
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        size = frame.size;
    }
    else{
        size = CGSizeMake(frame.size.height, frame.size.width);
    }
    
    CGSize scrollSize = size;
    if (size.width < size.height) {
        scrollSize.height -= 64;
    }
    [self resizeImageSlideForSize:scrollSize];
}

@end
