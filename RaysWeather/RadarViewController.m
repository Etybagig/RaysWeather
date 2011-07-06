//
//  RadarViewController.m
//  RaysWeather
//
//  Created by Bobby Lunceford on 4/12/11.
//  Copyright 2011 Appalachian State University. All rights reserved.
//

#import "RadarViewController.h"


@implementation RadarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    activityIndicator.hidden = NO;
    [activityIndicator startAnimating];
    activityIndicatorLabel.hidden = NO;
}    
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    NSString *urlAddress = @"http://raysweather.com/radar_images/N0R_FCX_loop.gif";
	NSURL *url = [NSURL URLWithString:urlAddress];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	[radar loadRequest:requestObj];
    
    activityIndicatorLabel.hidden = YES;
    [activityIndicator stopAnimating];
    activityIndicator.hidden = YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
