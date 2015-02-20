//
//  WebViewController.h
//  FTPresentDemoProject
//
//  Created by narut on 2/19/15.
//  Copyright (c) 2015 Narut. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>
@property (nonatomic) IBOutlet UIWebView *webView;

- (void)setStarterURL:(NSString *)url;
@end
