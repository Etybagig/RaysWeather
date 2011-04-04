//
//  MoreViewController.m
//  RaysWeather
//
//  Created by Bobby Lunceford on 3/31/11.
//  Copyright 2011 Appalachian State University. All rights reserved.
//

#import "MoreViewController.h"


@implementation MoreViewController

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
    [potd addTarget:self action:@selector(potdButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [webcams addTarget:self action:@selector(webcamsButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)potdButtonTouched:(id)sender
{
    POTDController *potdView = [[POTDController alloc] initWithNibName:@"POTD" bundle:nil];
    
    RaysWeatherAppDelegate *delegate = (RaysWeatherAppDelegate*)[[UIApplication sharedApplication] delegate];
    [delegate.moreNavController pushViewController:potdView animated:YES];
}

- (void)webcamsButtonTouched:(id)sender
{
    WebcamListController *webcamList = [[WebcamListController alloc] initWithNibName:@"WebcamList" bundle:nil];
    RaysWeatherAppDelegate *delegate = (RaysWeatherAppDelegate*)[[UIApplication sharedApplication] delegate];
    [delegate.moreNavController pushViewController:webcamList animated:YES];
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

- (void)viewDidDisappear:(BOOL)animated
{
    self.title = @"Back";
}

- (void)viewWillAppear:(BOOL)animated
{
    self.title = @"Rays Weather Center";
}



@end
