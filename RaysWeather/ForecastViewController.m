//
//  ForecastViewController.m
//  RaysWeather
//
//  Created by Bobby Lunceford on 3/24/11.
//  Copyright 2011 Appalachian State University. All rights reserved.
//

#import "ForecastViewController.h"

@implementation ForecastViewController
@synthesize dayOneDictionary, dayTwoDictionary, dayThreeDictionary;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Forecast";
    
    RaysWeatherAppDelegate *delegate = (RaysWeatherAppDelegate*)[[UIApplication sharedApplication] delegate];
    currentConditions = delegate.currentConditions;
    
    MyXMLParser *parser = currentConditions.parser;
    
    //-----------------------Day One-------------------------//
	dayOneDictionary = [parser.day1 objectAtIndex:0];
    
    //Day Name
    firstDay.text = [self trimWhitespace:[dayOneDictionary objectForKey:@"day_of_week"]];
    
    //High
    NSString *hi1 = [self trimWhitespace:[dayOneDictionary objectForKey:@"hi"]];
    firstDay_hi.text = [NSString stringWithFormat:@"%@\u00B0", hi1];
    
    //Low
    NSString *lo1 = [self trimWhitespace:[dayOneDictionary objectForKey:@"lo"]];
    firstDay_lo.text = [NSString stringWithFormat:@"%@\u00B0", lo1];
    
    //Icon
    dayOneIconString = [dayOneDictionary objectForKey:@"icon"];
    NSData *dayOneImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self trimWhitespace:dayOneIconString]]];
    UIImage *downloadedImageOne = [UIImage imageWithData:dayOneImageData];
    dayOneImage.image = downloadedImageOne;
    
    //Description
    //[[dayOneDescript layer] setBorderColor:[[UIColor whiteColor] CGColor]];
    //[[dayOneDescript layer] setBorderWidth:2];
    [[dayOneDescript layer] setCornerRadius:10];
    [dayOneDescript setClipsToBounds: YES];
    dayOneDescript.text = [self trimWhitespace:[dayOneDictionary objectForKey:@"descrip"]];
    
    //-----------------------Day Two-------------------------//
    dayTwoDictionary = [parser.day2 objectAtIndex:0];
    
    //Day Name
    secondDay.text = [self trimWhitespace:[dayTwoDictionary objectForKey:@"day_of_week"]];
    
    //High
    NSString *hi2 = [self trimWhitespace:[dayTwoDictionary objectForKey:@"hi"]];
    secondDay_hi.text = [NSString stringWithFormat:@"%@\u00B0", hi2];
    
    //Low
    NSString *lo2 = [self trimWhitespace:[dayTwoDictionary objectForKey:@"lo"]];
    secondDay_lo.text = [NSString stringWithFormat:@"%@\u00B0", lo2];
    
    //Icon
    dayTwoIconString = [dayTwoDictionary objectForKey:@"icon"];
    NSData *dayTwoImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self trimWhitespace:dayTwoIconString]]];
    UIImage *downloadedImageTwo = [UIImage imageWithData:dayTwoImageData];
    dayTwoImage.image = downloadedImageTwo;
    
    //Description
    //[[dayTwoDescript layer] setBorderColor:[[UIColor whiteColor] CGColor]];
    //[[dayTwoDescript layer] setBorderWidth:2];
    [[dayTwoDescript layer] setCornerRadius:10];
    [dayTwoDescript setClipsToBounds: YES];
    dayTwoDescript.text = [self trimWhitespace:[dayTwoDictionary objectForKey:@"descrip"]];
    
    //-----------------------Day Three----------------------//
    dayThreeDictionary = [parser.day3 objectAtIndex:0];
    
    //Day Name
    thirdDay.text = [self trimWhitespace:[dayThreeDictionary objectForKey:@"day_of_week"]];
    
    //High
    NSString *hi3 = [self trimWhitespace:[dayThreeDictionary objectForKey:@"hi"]];
    thirdDay_hi.text = [NSString stringWithFormat:@"%@\u00B0", hi3];
    
    //Low
    NSString *lo3 = [self trimWhitespace:[dayThreeDictionary objectForKey:@"lo"]];
    thirdDay_lo.text = [NSString stringWithFormat:@"%@\u00B0", lo3];
    
    //Icon
    dayThreeIconString = [dayThreeDictionary objectForKey:@"icon"];
    NSData *dayThreeImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self trimWhitespace:dayThreeIconString]]];
    UIImage *downloadedImageThree = [UIImage imageWithData:dayThreeImageData];
    dayThreeImage.image = downloadedImageThree;
    
    //Description
    //[[dayThreeDescript layer] setBorderColor:[[UIColor whiteColor] CGColor]];
    //[[dayThreeDescript layer] setBorderWidth:2];
    [[dayThreeDescript layer] setCornerRadius:10];
    [dayThreeDescript setClipsToBounds: YES];
    dayThreeDescript.text = [self trimWhitespace:[dayThreeDictionary objectForKey:@"descrip"]];
    

}

- (NSString *)trimWhitespace:(NSMutableString *)stringToTrim{
    NSString *removeNewLine = [stringToTrim stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *removeTab = [removeNewLine stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    return removeTab;
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
    [forecastTitle setHidden:NO];
    [firstDay setFrame:CGRectMake(26,71,88,21)];
    [secondDay setFrame:CGRectMake(26,176,83,21)];
    [thirdDay setFrame:CGRectMake(26,284,83,22)];
    [firsthi setFrame:CGRectMake(120,74,45,22)];
    [firstlo setFrame:CGRectMake(206,74,42,21)];
    [secondhi setFrame:CGRectMake(120,178,44,21)];
    [secondlo setFrame:CGRectMake(206,178,42,21)];
    [thirdhi setFrame:CGRectMake(120,287,44,21)];
    [thirdlo setFrame:CGRectMake(206,287,42,21)];
    [firstDay_hi setFrame:CGRectMake(145,74,42,21)];
    [firstDay_lo setFrame:CGRectMake(225,74,45,21)];
    [secondDay_hi setFrame:CGRectMake(138,178,49,21)];
    [secondDay_lo setFrame:CGRectMake(225,178,45,21)];
    [thirdDay_hi setFrame:CGRectMake(142,287,45,21)];
    [thirdDay_lo setFrame:CGRectMake(225,287,45,21)];
    [dayOneImage setFrame:CGRectMake(29,100,64,64)];
    [dayTwoImage setFrame:CGRectMake(29,204,64,64)];
    [dayThreeImage setFrame:CGRectMake(29,314,64,64)];
    [faceOverlay setFrame:CGRectMake(0,311,59,100)];
    [dayOneDescript setFrame:CGRectMake(102,96,188,71)];
    [dayOneDescript setBackgroundColor:[UIColor colorWithRed:0.0 green:0.067 blue:0.192 alpha:1]];
    [dayTwoDescript setFrame:CGRectMake(102,200,188,71)];
    [dayTwoDescript setBackgroundColor:[UIColor colorWithRed:0.0 green:0.149 blue:0.639 alpha:1]];
    [dayThreeDescript setFrame:CGRectMake(102,311,188,71)];
    [dayThreeDescript setBackgroundColor:[UIColor colorWithRed:0.0 green:0.067 blue:0.192 alpha:1]];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"forecastBack" ofType:@"png"];
    UIImage *newBackground = [UIImage imageWithContentsOfFile:path];
    [background setImage:newBackground];
}

-(void)rotateToLandscape
{
    NSLog(@"landscape");
    [forecastTitle setHidden:YES];
    [firstDay setFrame:CGRectMake(25, 20, 131, 21)];
    [secondDay setFrame:CGRectMake(168,20,146,21)];
    [thirdDay setFrame:CGRectMake(322, 20, 131, 22)];
    [firsthi setFrame:CGRectMake(24, 52, 45, 22)];
    [firstlo setFrame:CGRectMake(25, 74, 42, 21)];
    [secondhi setFrame:CGRectMake(172, 53, 44, 21)];
    [secondlo setFrame:CGRectMake(172, 74, 42, 21)];
    [thirdhi setFrame:CGRectMake(322, 53, 44, 21)];
    [thirdlo setFrame:CGRectMake(322, 74, 42, 21)];
    [firstDay_hi setFrame:CGRectMake(45, 53, 42, 21)];
    [firstDay_lo setFrame:CGRectMake(42, 74, 45, 21)];
    [secondDay_hi setFrame:CGRectMake(188, 53, 49, 21)];
    [secondDay_lo setFrame:CGRectMake(192, 74, 45, 21)];
    [thirdDay_hi setFrame:CGRectMake(339, 53, 45, 21)];
    [thirdDay_lo setFrame:CGRectMake(339, 74, 45, 21)];
    [dayOneImage setFrame:CGRectMake(91, 41, 64, 64)];
    [dayTwoImage setFrame:CGRectMake(244, 41, 64, 64)];
    [dayThreeImage setFrame:CGRectMake(389, 41, 64, 64)];
    [faceOverlay setFrame:CGRectMake(0, 151, 59, 100)];
    [dayOneDescript setFrame:CGRectMake(26, 112, 130, 111)];
    [dayOneDescript setBackgroundColor:[UIColor colorWithRed:0.0 green:0.149 blue:0.639 alpha:1]];
    [dayTwoDescript setFrame:CGRectMake(172, 112, 130, 111)];
    [dayTwoDescript setBackgroundColor:[UIColor colorWithRed:0.0 green:0.067 blue:0.192 alpha:1]];
    [dayThreeDescript setFrame:CGRectMake(322, 112, 130, 111)];
    [dayThreeDescript setBackgroundColor:[UIColor colorWithRed:0.0 green:0.149 blue:0.639 alpha:1]];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"forecastLandscapeBack" ofType:@"png"];
    UIImage *newBackground = [UIImage imageWithContentsOfFile:path];
    [background setImage:newBackground];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
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



@end
