//
//  RadarViewController.m
//  RaysWeather
//
//  Created by Bobby Lunceford and Seth Hobson.
//  Copyright 2011 Ray's Weather. All rights reserved.
//

#import "RadarViewController.h"


@implementation RadarViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(appActivated:)
                                                 name: UIApplicationDidBecomeActiveNotification
                                               object: nil];
}

- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewDidUnload];
}

/*
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(appActivated:)
                                                 name: UIApplicationDidBecomeActiveNotification
                                               object: nil];
}
*/

- (void)appActivated:(NSNotification *)note
{
    NSLog(@"reloading radar");
    [self loadData];
}

- (void)loadData
{
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
    @autoreleasepool
    {
        RaysWeatherAppDelegate *delegate = (RaysWeatherAppDelegate*)[[UIApplication sharedApplication] delegate];
        NSString *closest_radar = [self trimWhitespace:[delegate.closestStation objectForKey:@"closest_radar"]];
        NSString *urlAddress = [NSString stringWithFormat:@"http://raysweather.com/radar_images/N0R_%@_loop.gif", closest_radar];
        NSURL *url = [NSURL URLWithString:urlAddress];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [radar loadRequest:requestObj];
    }
}

- (NSString *)trimWhitespace:(NSMutableString *)stringToTrim
{
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
