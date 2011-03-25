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
@synthesize firstDay, firstDay_hi, firstDay_lo, secondDay, secondDay_hi, secondDay_lo, thirdDay, thirdDay_hi, thirdDay_lo, dayOneImage, dayTwoImage, dayThreeImage;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MyXMLParser *parser = [MyXMLParser new];
    NSString *forecastPath = @"http://raysweather.com/mobile/forecast/?station=1";
    [parser parseXMLFileAtURL:forecastPath];
    
    //--------------TODO: parse forecast XML--------------------
    //fake out info
	firstDay_hi.text = @"62.02";
	firstDay_lo.text = @"41.08";
	secondDay_hi.text = @"49.80";
	secondDay_lo.text = @"41.28";
	thirdDay_hi.text = @"62.03";
	thirdDay_lo.text = @"45.73";
	NSString *dayOne = @"http://raysweather.com/images/icons/11.png";
	NSData *imageData1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:dayOne]];
	UIImage *downloadedImageOne = [UIImage imageWithData:imageData1];
	dayOneImage.image = downloadedImageOne;
	NSString *dayTwo = @"http://raysweather.com/images/icons/40.png";
	NSData *imageData2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:dayTwo]];
	UIImage *downloadedImageTwo = [UIImage imageWithData:imageData2];
	dayTwoImage.image = downloadedImageTwo;
	NSString *dayThree = @"http://raysweather.com/images/icons/26.png";
	NSData *imageData3 = [NSData dataWithContentsOfURL:[NSURL URLWithString:dayThree]];
	UIImage *downloadedImageThree = [UIImage imageWithData:imageData3];
	dayThreeImage.image = downloadedImageThree;}


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
