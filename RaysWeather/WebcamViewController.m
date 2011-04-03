//
//  WebcamViewController.m
//  RaysWeather
//
//  Created by Bobby Lunceford on 4/1/11.
//  Copyright 2011 Appalachian State University. All rights reserved.
//

#import "WebcamViewController.h"


@implementation WebcamViewController

@synthesize name, extension;

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
}

- (void)viewWillAppear:(BOOL)animated
{
    self.title = name;
    
    NSMutableString *imageString = [NSString stringWithFormat:@"http://raysweather.com/images/webcams/%@.jpg", extension];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageString]];
    UIImage *downloadedImage = [UIImage imageWithData:imageData];
    webcamView.image = downloadedImage;
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
    return YES;
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
