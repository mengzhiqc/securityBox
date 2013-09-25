//
//  LSAboutAppViewController.m
//  security
//
//  Created by 孟 智 on 13-9-24.
//  Copyright (c) 2013年 孟 智. All rights reserved.
//

#import "LSAboutAppViewController.h"

@interface LSAboutAppViewController ()

@end

@implementation LSAboutAppViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UINavigationBar *navigationBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    [self.view addSubview:navigationBar];
    
    NSString *localHTMLPageName = @"aboutUs";
    NSString *localHTMLPageFilePath = [[NSBundle mainBundle]pathForResource:localHTMLPageName ofType:@"html"];
    NSURL *localHTMLPageFileURL = [NSURL fileURLWithPath:localHTMLPageFilePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:localHTMLPageFileURL];
    CGRect frame = self.view.bounds;
    frame.origin.y = 50;
    UIWebView *webView = [[UIWebView alloc]initWithFrame:frame];
    [webView loadRequest:request];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
