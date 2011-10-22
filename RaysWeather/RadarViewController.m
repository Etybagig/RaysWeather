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

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [NSThread detachNewThreadSelector:@selector(loadRadar) toTarget:self withObject:nil];
    timer = [NSTimer scheduledTimerWithTimeInterval:(1.0/2.0) target:self selector:@selector(timerLoad) userInfo:nil repeats:YES];
}

- (void)timerLoad
{
    if (!radar.loading)
    {
        [activityIndicator stopAnimating];
        activityIndicator.hidden = YES;
        activityIndicatorLabel.hidden = YES;
    }
    else
    {
        activityIndicator.hidden = NO;
        activityIndicatorLabel.hidden = NO;
        [activityIndicator startAnimating];
    }
}

- (void)loadRadar
{
    @autoreleasepool {
    
        RaysWeatherAppDelegate *delegate = (RaysWeatherAppDelegate*)[[UIApplication sharedApplication] delegate];
        NSString *closest_radar = [self trimWhitespace:[delegate.closestStation objectForKey:@"closest_radar"]];
        NSString *urlAddress = [NSString stringWithFormat:@"http://raysweather.com/radar_images/N0R_%@_loop.gif", closest_radar];
        NSURL *url = [NSURL URLWithString:urlAddress];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [radar loadRequest:requestObj];
    
    }
}

- (NSString *)trimWhitespace:(NSMutableString *)stringToTrim{
    NSString *removeNewLine = [stringToTrim stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *removeTab = [removeNewLine stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    return removeTab;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}


@end
