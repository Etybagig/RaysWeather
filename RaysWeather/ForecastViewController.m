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
@synthesize firstDay, firstDay_hi, firstDay_lo, secondDay, secondDay_hi, secondDay_lo, thirdDay, thirdDay_hi, thirdDay_lo, dayOneImage, dayTwoImage, dayThreeImage, dayOneDictionary, dayTwoDictionary, dayThreeDictionary, dayOneIconString, dayTwoIconString, dayThreeIconString, charsToTrim;


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
    firstDay.text = [dayOneDictionary objectForKey:@"day_of_week"];
    firstDay_hi.text = [dayOneDictionary objectForKey:@"hi"];
	firstDay_lo.text = [dayOneDictionary objectForKey:@"lo"];
    dayOneIconString = [dayOneDictionary objectForKey:@"icon"];
    dayOneDescript.text = [dayOneDictionary objectForKey:@"descrip"];
    NSData *dayOneImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[dayOneIconString stringByTrimmingCharactersInSet:charsToTrim]]];
    UIImage *downloadedImageOne = [UIImage imageWithData:dayOneImageData];
    dayOneImage.image = downloadedImageOne;
    
    dayTwoDictionary = [parser.day2 objectAtIndex:0];
    secondDay.text = [dayTwoDictionary objectForKey:@"day_of_week"];
    secondDay_hi.text = [dayTwoDictionary objectForKey:@"hi"];
	secondDay_lo.text = [dayTwoDictionary objectForKey:@"lo"];
    dayTwoIconString = [dayTwoDictionary objectForKey:@"icon"];
    dayTwoDescript.text = [dayTwoDictionary objectForKey:@"descrip"];
    NSData *dayTwoImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[dayTwoIconString stringByTrimmingCharactersInSet:charsToTrim]]];
    UIImage *downloadedImageTwo = [UIImage imageWithData:dayTwoImageData];
    dayTwoImage.image = downloadedImageTwo;
    
    dayThreeDictionary = [parser.day3 objectAtIndex:0];
    thirdDay.text = [dayThreeDictionary objectForKey:@"day_of_week"];
    thirdDay_hi.text = [dayThreeDictionary objectForKey:@"hi"];
    thirdDay_lo.text = [dayThreeDictionary objectForKey:@"lo"];
    dayThreeIconString = [dayThreeDictionary objectForKey:@"icon"];
    dayThreeDescript.text = [dayThreeDictionary objectForKey:@"descrip"];
    NSData *dayThreeImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[dayThreeIconString stringByTrimmingCharactersInSet:charsToTrim]]];
    UIImage *downloadedImageThree = [UIImage imageWithData:dayThreeImageData];
    dayThreeImage.image = downloadedImageThree;
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
