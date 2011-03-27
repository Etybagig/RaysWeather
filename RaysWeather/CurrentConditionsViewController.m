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
#include <math.h>

@implementation CurrentConditionsViewController


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Create Parser
    parser = [MyXMLParser new];
    
    //Until we get the location stuff working, station will be set to boone
    station.text = @"Boone, NC";
    
    //Parse first site
    NSString *path = @"http://raysweather.com/mobile/conditions/?station=1";
	[parser parseXMLFileAtURL:path];
    weatherDictionary = [parser.weatherData objectAtIndex:0];
    
    //Set information that was parsed, trimming all strings
    //Humidity
    NSString *humidityReading = [self trimWhitespace:[weatherDictionary objectForKey:@"humidity"]];
    humidityReading = [self roundAndSnap:humidityReading];
    humidityReading = [NSString stringWithFormat:@"%@ %%", humidityReading];
	humidity.text = humidityReading;
    
    //Icon
	NSMutableString *imageString = [NSString stringWithFormat:@"http://raysweather.com/images/icons/%@.png", [weatherDictionary objectForKey:@"condition_icon"]];
	NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self trimWhitespace:imageString]]];
	UIImage *downloadedImage = [UIImage imageWithData:imageData];
	currentConditionImage.image = downloadedImage;
    
	//Barometer
    NSString *barometerReading = [weatherDictionary objectForKey:@"barometer"];
    barometerReading = [self roundAndSnap:barometerReading];
    NSString *barometerTrend = [weatherDictionary objectForKey:@"baroTrend"];
    NSMutableString *barometerText = [NSString stringWithFormat:@"%@ %@", barometerReading, barometerTrend];
    barometer.text = [self trimWhitespace:barometerText];
    
    //Current Temperature
    NSString *tempText = [self trimWhitespace:[weatherDictionary objectForKey:@"temperature"]];
    tempText = [self roundAndSnap:tempText];
    tempText = [NSString stringWithFormat:@"%@\u00B0", tempText];
    currentTemp.text = tempText;
    
    //Wind
    NSMutableString *windString = [NSString stringWithFormat:@"%@ %@ mph", [weatherDictionary objectForKey:@"wind_direction"], [weatherDictionary objectForKey:@"wind_speed"]];
    wind.text = [self trimWhitespace:windString];
    
    //Hi
    NSString *tempTextHi = [self trimWhitespace:[weatherDictionary objectForKey:@"hi_temp"]];
    tempTextHi = [self roundAndSnap:tempTextHi];
    tempTextHi = [NSString stringWithFormat:@"%@\u00B0", tempTextHi];
    currentHi.text = tempTextHi;
    
    //Lo
    NSString *tempTextLo = [self trimWhitespace:[weatherDictionary objectForKey:@"lo_temp"]];
    tempTextLo = [self roundAndSnap:tempTextLo];
    tempTextLo = [NSString stringWithFormat:@"%@\u00B0", tempTextLo];
    currentLo.text = tempTextLo;
	
    //Parse second site
    NSString *path2 = @"http://raysweather.com/mobile/forecast/?station=1";
	[parser parseXMLFileAtURL:path2];
    weatherDictionary = [parser.weatherData objectAtIndex:1];
    
    //Set information that was parsed, trimming all strings
    //Lines 55-58 add rounded corners and a border to UITextView
    //Today's Summary
    [[todaysSummary layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[todaysSummary layer] setBorderWidth:2];
    [[todaysSummary layer] setCornerRadius:10];
    [todaysSummary setClipsToBounds: YES];
    todaysSummary.text = [self trimWhitespace:[weatherDictionary objectForKey:@"introduction"]];
    
    //Today's Summary Title
    todaysSummaryTitle.text = [self trimWhitespace:[weatherDictionary objectForKey:@"title"]];
}

- (NSString *)trimWhitespace:(NSMutableString *)stringToTrim{
    NSString *removeNewLine = [stringToTrim stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *removeTab = [removeNewLine stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    return removeTab;
}

- (NSString *)roundAndSnap:(NSString *)stringToRound{
    double asDouble = [stringToRound doubleValue];
    int asRoundedInt = round(asDouble);
    return [[NSNumber numberWithInt:asRoundedInt] stringValue];
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
