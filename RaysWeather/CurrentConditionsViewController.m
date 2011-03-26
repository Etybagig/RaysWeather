//
//  CurrentConditionsViewController.m
//  RaysWeather
//
//  Created by Bobby Lunceford on 3/24/11.
//  Copyright 2011 Appalachian State University. All rights reserved.
//
// http://raysweather.com/mobile/stations
// http://raysweather.com/mobile/conditions/?station=n
// http://raysweather.com/mobile/forecast/?station=n
// http://raysweather.com/images/icons/n

#import "CurrentConditionsViewController.h"
#import "MyXMLParser.h"

@implementation CurrentConditionsViewController


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Create Parser
    MyXMLParser *parser = [MyXMLParser new];
    
    //Until we get the location stuff working, station will be set to boone
    station.text = @"Boone, NC";
    
    //Parse first site
    NSString *path = @"http://raysweather.com/mobile/conditions/?station=1";
	[parser parseXMLFileAtURL:path];
    weatherDictionary = [parser.weatherData objectAtIndex:0];
    
    //Set information that was parsed, trimming all strings
	humidity.text = [self trimWhitespace:[weatherDictionary objectForKey:@"humidity"]];
	NSMutableString *imageString = [NSString stringWithFormat:@"http://raysweather.com/images/icons/%@.png", [weatherDictionary objectForKey:@"condition_icon"]];
	NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self trimWhitespace:imageString]]];
	UIImage *downloadedImage = [UIImage imageWithData:imageData];
	currentConditionImage.image = downloadedImage;
	barometer.text = [self trimWhitespace:[weatherDictionary objectForKey:@"barometer"]];
	currentTemp.text = [self trimWhitespace:[weatherDictionary objectForKey:@"temperature"]];
    NSMutableString *windString = [NSString stringWithFormat:@"%@ %@ mph", [weatherDictionary objectForKey:@"wind_direction"], [weatherDictionary objectForKey:@"wind_speed"]];
    wind.text = [self trimWhitespace:windString];
	currentHi.text = [self trimWhitespace:[weatherDictionary objectForKey:@"hi_temp"]];
	currentLo.text = [self trimWhitespace:[weatherDictionary objectForKey:@"lo_temp"]];
	
    //Parse second site
    NSString *path2 = @"http://raysweather.com/mobile/forecast/?station=1";
	[parser parseXMLFileAtURL:path2];
    weatherDictionary = [parser.weatherData objectAtIndex:1];
    
    //Set information that was parsed, trimming all strings
    //Lines 55-58 add rounded corners and a border to UITextView
    [[todaysSummary layer] setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [[todaysSummary layer] setBorderWidth:2.3];
    [[todaysSummary layer] setCornerRadius:15];
    [todaysSummary setClipsToBounds: YES];
    todaysSummary.text = [self trimWhitespace:[weatherDictionary objectForKey:@"introduction"]];
    todaysSummaryTitle.text = [self trimWhitespace:[weatherDictionary objectForKey:@"title"]];
}

- (NSString *)trimWhitespace:(NSMutableString *)stringToTrim{
    NSString *removeNewLine = [stringToTrim stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *removeTab = [removeNewLine stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    return removeTab;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc
{
    [super dealloc];
}

@end
