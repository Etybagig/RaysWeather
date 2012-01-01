//
//  CurrentConditionsViewController.m
//  RaysWeather
//
//  Created by Bobby Lunceford and Seth Hobson.
//  Copyright 2011 Ray's Weather. All rights reserved.
//
// http://raysweather.com/mobile/stations
// http://raysweather.com/mobile/conditions/?station=n
// http://raysweather.com/mobile/forecast/?station=n
// http://raysweather.com/images/icons/n

#import "CurrentConditionsViewController.h"

@implementation CurrentConditionsViewController

@synthesize parser, stationInfo;

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
- (void)viewDWillDisappear:(BOOL)animated
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
    NSLog(@"reloading current conditions");
    [self loadData];
}

- (void)loadData
{
    delegate = (RaysWeatherAppDelegate*)[[UIApplication sharedApplication] delegate];
    delegate.currentConditions = self;
    delegate.currentNavController.navigationBar.hidden = YES;
    
    currentConditionImage.hidden = YES;
    station.hidden = YES;
    wind.hidden = YES;
    humidity.hidden = YES;
    barometer.hidden = YES;
    currentTemp.hidden = YES;
    currentHi.hidden = YES;
    currentLo.hidden = YES;
    todaysSummaryTitle.hidden = YES;
    todaysSummary.hidden = YES;
    currCondLabel.hidden = YES;
    windLabel.hidden = YES;
    humidLabel.hidden = YES;
    baroLabel.hidden = YES;
    hiLabel.hidden = YES;
    loLabel.hidden = YES;
    todaysforcastLabel.hidden = YES;
    
    activityIndicatorLabel.hidden = NO;
    activityIndicator.hidden = NO;
    [activityIndicator startAnimating];
    
    //No internet connection present or other problem with the xml parser.
    if (delegate.parser.error == YES)
    {
        activityIndicatorLabel.hidden = YES;
        [activityIndicator stopAnimating];
        activityIndicator.hidden = YES;
        connectionError.hidden = NO;
        return;
    }
}

- (void)locationReceived
{
    stationInfo = delegate.closestStation;
    
    self.title = @"Current";
    
    //Create Parser
    parser = [MyXMLParser new];
    
    //Set Title
    NSString *stationName = [self trimWhitespace:[stationInfo objectForKey:@"station_name"]];
    station.text = stationName;
    
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
    NSString *path2 = [NSString stringWithFormat:@"http://raysweather.com/mobile/forecast/?station=%d", stationID];
	[parser parseXMLFileAtURL:path2];
    weatherDictionary = [parser.weatherData objectAtIndex:1];
    
    //Set information that was parsed, trimming all strings
    //Lines 55-58 add rounded corners and background color
    //Today's Summary
    [[todaysSummary layer] setCornerRadius:10];
    [todaysSummary setClipsToBounds: YES];
    todaysSummary.text = [self stringByStrippingHTML:[weatherDictionary objectForKey:@"introduction"]];
    
    
    //Today's Summary Title
    todaysSummaryTitle.text = [self trimWhitespace:[weatherDictionary objectForKey:@"title"]];

    //Stop activity indicator and hide
    [activityIndicator stopAnimating];
    activityIndicator.hidden = YES;
    activityIndicatorLabel.hidden = YES;
    
    //Unhide everything
    currentConditionImage.hidden = NO;
    station.hidden = NO;
    wind.hidden = NO;
    humidity.hidden = NO;
    barometer.hidden = NO;
    currentTemp.hidden = NO;
    currentHi.hidden = NO;
    currentLo.hidden = NO;
    todaysSummaryTitle.hidden = NO;
    todaysSummary.hidden = NO;
    currCondLabel.hidden = NO;
    windLabel.hidden = NO;
    humidLabel.hidden = NO;
    baroLabel.hidden = NO;
    hiLabel.hidden = NO;
    loLabel.hidden = NO;
    todaysforcastLabel.hidden = NO;
}

- (void)showPicker
{
    StationPickerViewController *stationPicker = [[StationPickerViewController alloc] initWithNibName:@"StationPicker" bundle:nil];
    stationPicker.hidesBottomBarWhenPushed = YES;
    stationPicker.currentViewController = self;
    [delegate.currentNavController pushViewController:stationPicker animated:YES];
}


- (NSString *)trimWhitespace:(NSMutableString *)stringToTrim
{
    NSString *removeNewLine = [stringToTrim stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *removeTab = [removeNewLine stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    return removeTab;
}

- (NSString *)stringByStrippingHTML:(NSString *)stringToStrip
{
    NSRange range;
    NSString *string = [stringToStrip copy];
    while ((range = [string rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        string = [string stringByReplacingCharactersInRange:range withString:@""];
    NSString *removeNewLine = [string stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    return removeNewLine;
}

- (NSString *)roundAndSnap:(NSString *)stringToRound
{
    double asDouble = [stringToRound doubleValue];
    int asRoundedInt = round(asDouble);
    return [[NSNumber numberWithInt:asRoundedInt] stringValue];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight ||
       toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft)
        [self rotateToLandscape];
    else if (toInterfaceOrientation == UIInterfaceOrientationPortrait ||
            toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
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

@end
