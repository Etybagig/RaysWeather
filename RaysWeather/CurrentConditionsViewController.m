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

@implementation CurrentConditionsViewController

// Implement viewWillAppear to do additional setup after loading the view, typically from a nib.
- (void)viewWillAppear:(BOOL)animated
{    
    [super viewWillAppear:YES];
    
    delegate = (RaysWeatherAppDelegate*)[[UIApplication sharedApplication] delegate];
    delegate.currentConditions = self;
}

- (void)locationReceived
{
    stationInfo = delegate.closestStation;
    
    self.title = @"Current Conditions";
    
    //Create Parser
    parser = [MyXMLParser new];
    
    //Set Title
    NSString *stationCity = [self trimWhitespace:[stationInfo objectForKey:@"city"]];
    NSString *stationState = [self trimWhitespace:[stationInfo objectForKey:@"state"]];
    station.text = [NSString stringWithFormat:@"%@, %@", stationCity, stationState];
    
    //Parse first site
    NSInteger stationID = [[self trimWhitespace:[stationInfo objectForKey:@"stationId"]] integerValue];
    NSString *path = [NSString stringWithFormat:@"http://raysweather.com/mobile/conditions/?station=%d", stationID];
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
    //Lines 55-58 add rounded corners and background color
    //Today's Summary
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
    return YES;
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if(toInterfaceOrientation==UIInterfaceOrientationLandscapeRight ||
       toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft)
        [self rotateToLandscape];
    else if(toInterfaceOrientation==UIInterfaceOrientationPortrait ||
            toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)
        [self rotateToPortrait];
}

- (void)rotateToPortrait
{
    NSLog(@"portrait");
    [currentConditionImage setFrame:CGRectMake(208,58,64,64)];
    [station setFrame:CGRectMake(29,68,164,23)];
    [wind setFrame:CGRectMake(78,98,106,22)];
    [humidity setFrame:CGRectMake(102,121,85,22)];
    [barometer setFrame:CGRectMake(113,144,80,21)];
    [currentTemp setFrame:CGRectMake(206,119,69,21)];
    [currentHi setFrame:CGRectMake(229,138,43,21)];
    [currentLo setFrame:CGRectMake(223,156,49,21)];
    [todaysSummary setFrame:CGRectMake(29,238,259,141)];
    [todaysSummaryTitle setFrame:CGRectMake(29,200,259,38)];
    [currCondLabel setFrame:CGRectMake(194,19,93,41)];
    [windLabel setFrame:CGRectMake(34,98,44,21)];
    [humidLabel setFrame:CGRectMake(34,121,71,21)];
    [baroLabel setFrame:CGRectMake(34,144,85,21)];
    [hiLabel setFrame:CGRectMake(208,138,44,21)];
    [loLabel setFrame:CGRectMake(208,156,45,21)];
    [todaysforcastLabel setFrame:CGRectMake(29,184,155,21)];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"currentBack" ofType:@"png"];
    UIImage *newBackground = [UIImage imageWithContentsOfFile:path];
    [background setImage:newBackground];
}

-(void)rotateToLandscape
{
    NSLog(@"landscaperight");
    [currentConditionImage setFrame:CGRectMake(166, 81, 64, 64)];
    [station setFrame:CGRectMake(29, 68, 133, 23)];
    [wind setFrame:CGRectMake(56, 109, 106, 22)];
    [humidity setFrame:CGRectMake(56, 153, 85, 22)];
    [barometer setFrame:CGRectMake(56, 198, 80, 21)];
    [currentTemp setFrame:CGRectMake(164, 146, 69, 21)];
    [currentHi setFrame:CGRectMake(187, 168, 43, 21)];
    [currentLo setFrame:CGRectMake(181, 188, 49, 21)];
    [todaysSummary setFrame:CGRectMake(256, 82, 188, 137)];
    [todaysSummaryTitle setFrame:CGRectMake(240, 40, 218, 38)];
    [currCondLabel setFrame:CGRectMake(152, 37, 93, 41)];
    [windLabel setFrame:CGRectMake(48, 91, 44, 21)];
    [humidLabel setFrame:CGRectMake(48, 135, 71, 21)];
    [baroLabel setFrame:CGRectMake(48, 179, 85, 21)];
    [hiLabel setFrame:CGRectMake(164, 168, 44, 21)];
    [loLabel setFrame:CGRectMake(164, 188, 45, 21)];
    [todaysforcastLabel setFrame:CGRectMake(247, 20, 155, 21)];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"currentLandscapeBack" ofType:@"png"];
    UIImage *newBackground = [UIImage imageWithContentsOfFile:path];
    [background setImage:newBackground];
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
    [parser release];
    [weatherDictionary release];
}

@end
