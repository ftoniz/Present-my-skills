//
//  WebViewController.m
//  FTPresentDemoProject
//
//  Created by narut on 2/19/15.
//  Copyright (c) 2015 Narut. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController{
    NSURL *starterURL;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView setDelegate:self];
    [self.webView loadRequest:[NSURLRequest requestWithURL:starterURL]];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Cross"] style:UIBarButtonItemStyleBordered target:self action:@selector(closeHandle:)]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)closeHandle:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark WebView Delegate 
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}

#pragma mark Public Method
- (void)setStarterURL:(NSString *)url{
    starterURL = [NSURL URLWithString:url];
    
}

@end
