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
    [[dayOneDescript layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[dayOneDescript layer] setBorderWidth:2];
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
    [[dayTwoDescript layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[dayTwoDescript layer] setBorderWidth:2];
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
    [[dayThreeDescript layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[dayThreeDescript layer] setBorderWidth:2];
    [[dayThreeDescript layer] setCornerRadius:10];
    [dayThreeDescript setClipsToBounds: YES];
    dayThreeDescript.text = [self trimWhitespace:[dayThreeDictionary objectForKey:@"descrip"]];
    

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
