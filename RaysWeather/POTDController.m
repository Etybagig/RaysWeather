//
//  POTDController.m
//  RaysWeather
//
//  Created by Bobby Lunceford on 3/31/11.
//  Copyright 2011 Appalachian State University. All rights reserved.
//

#import "POTDController.h"


@implementation POTDController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSDate *date = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyyMMdd"];
    NSString *dateString = [format stringFromDate:date];
    
    NSMutableString *imageString = [NSString stringWithFormat:@"http://raysweather.com/photo_of_the_day/lg/%@.jpg", dateString];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageString]];
    UIImage *downloadedImage = [UIImage imageWithData:imageData];
    potdView.image = downloadedImage;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
