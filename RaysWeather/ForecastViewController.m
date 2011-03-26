//
//  ForecastViewController.m
//  RaysWeather
//
//  Created by Bobby Lunceford on 3/24/11.
//  Copyright 2011 Appalachian State University. All rights reserved.
//

#import "ForecastViewController.h"
#import "MyXMLParser.h"

@implementation ForecastViewController
@synthesize dayOneDictionary, dayTwoDictionary, dayThreeDictionary;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MyXMLParser *parser = [MyXMLParser new];
    NSString *forecastPath = @"http://raysweather.com/mobile/forecast/?station=1";
    [parser parseXMLFileAtURL:forecastPath];
    
    //--------------TODO: parse forecast XML--------------------
    //fake out info
    
    charsToTrim = [NSCharacterSet characterSetWithCharactersInString:@" \n\t"];
    
	dayOneDictionary = [parser.day1 objectAtIndex:0];
    firstDay.text = [self trimWhitespace:[dayOneDictionary objectForKey:@"day_of_week"]];
    firstDay_hi.text = [self trimWhitespace:[dayOneDictionary objectForKey:@"hi"]];
	firstDay_lo.text = [self trimWhitespace:[dayOneDictionary objectForKey:@"lo"]];
    dayOneIconString = [dayOneDictionary objectForKey:@"icon"];
    dayOneDescript.text = [self trimWhitespace:[dayOneDictionary objectForKey:@"descrip"]];
    NSData *dayOneImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self trimWhitespace:dayOneIconString]]];
    UIImage *downloadedImageOne = [UIImage imageWithData:dayOneImageData];
    dayOneImage.image = downloadedImageOne;
    
    dayTwoDictionary = [parser.day2 objectAtIndex:0];
    secondDay.text = [self trimWhitespace:[dayTwoDictionary objectForKey:@"day_of_week"]];
    secondDay_hi.text = [self trimWhitespace:[dayTwoDictionary objectForKey:@"hi"]];
	secondDay_lo.text = [self trimWhitespace:[dayTwoDictionary objectForKey:@"lo"]];
    dayTwoIconString = [dayTwoDictionary objectForKey:@"icon"];
    dayTwoDescript.text = [self trimWhitespace:[dayTwoDictionary objectForKey:@"descrip"]];
    NSData *dayTwoImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self trimWhitespace:dayTwoIconString]]];
    UIImage *downloadedImageTwo = [UIImage imageWithData:dayTwoImageData];
    dayTwoImage.image = downloadedImageTwo;
    
    dayThreeDictionary = [parser.day3 objectAtIndex:0];
    thirdDay.text = [self trimWhitespace:[dayThreeDictionary objectForKey:@"day_of_week"]];
    thirdDay_hi.text = [self trimWhitespace:[dayThreeDictionary objectForKey:@"hi"]];
    thirdDay_lo.text = [self trimWhitespace:[dayThreeDictionary objectForKey:@"lo"]];
    dayThreeIconString = [dayThreeDictionary objectForKey:@"icon"];
    dayThreeDescript.text = [self trimWhitespace:[dayThreeDictionary objectForKey:@"descrip"]];
    NSData *dayThreeImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self trimWhitespace:dayThreeIconString]]];
    UIImage *downloadedImageThree = [UIImage imageWithData:dayThreeImageData];
    dayThreeImage.image = downloadedImageThree;
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
