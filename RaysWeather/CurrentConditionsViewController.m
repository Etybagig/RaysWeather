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
@synthesize currentConditionImage, station, wind, humidity, barometer, windDirection, warning, currentHi, currentLo, todaysSummary, currentTemp;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MyXMLParser *parser = [MyXMLParser new];
    NSString *path = @"http://raysweather.com/mobile/conditions/?station=1";
	[parser parseXMLFileAtURL:path];
	humidity.text = parser.currentHumidity;
	NSString *imageString = [NSString stringWithFormat:@"http://raysweather.com/images/icons/%@.png", parser.currentConditionIcon];
	//NSLog(imageString);
	NSString *trimmedString = [imageString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
	NSString *trimmedString2 = [trimmedString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
	NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:trimmedString2]];
	UIImage *downloadedImage = [UIImage imageWithData:imageData];
	currentConditionImage.image = downloadedImage;
	barometer.text = parser.currentBarometer;
	currentTemp.text = parser.currentTemperature;
    
    NSString *windString = [NSString stringWithFormat:@"%@ %@ mph", parser.currentWindDirection, parser.currentWindSpeed];
    NSString *trimmedWindString = [windString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    trimmedWindString = [trimmedWindString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    wind.text = trimmedWindString;
    
	currentHi.text = parser.currentHiTemp;
	currentLo.text = parser.currentLoTemp;
	
    NSString *path2 = @"http://raysweather.com/mobile/forecast/?station=1";
	[parser parseXMLFileAtURL:path2];
    todaysSummary.text = parser.currentIntro;
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
