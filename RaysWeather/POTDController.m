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
    image = [UIImage imageWithData:imageData];
    
    
    
    potdView = [[UIImageView alloc] initWithImage:image];
    [potdView setContentMode:UIViewContentModeScaleAspectFit];
    [potdView setFrame:CGRectMake(0, 0, 320, 367)];
    
    [imageScrollView addSubview:potdView];
    [imageScrollView setContentSize:CGSizeMake(potdView.frame.size.width,
                                               potdView.frame.size.height)];
    [imageScrollView setScrollEnabled:YES];
    [imageScrollView setMinimumZoomScale:1.0];
    [imageScrollView setMaximumZoomScale:4.0];
    [imageScrollView setDelegate:self];
    
    [format setDateStyle:NSDateFormatterShortStyle];
    dateString = [format stringFromDate:date];
    self.title = [NSString stringWithFormat:@"Photo for %@", dateString];
    [format release];
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
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeRight ||
       toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft)
    {
        [imageScrollView setZoomScale:1.0];
        [potdView setFrame:CGRectMake(0, 0, 480, 320)];
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [[UIApplication sharedApplication] setStatusBarHidden:YES animated:YES];
        UIView *tabBar = [self.tabBarController.view.subviews objectAtIndex:1];
        self.view.frame = CGRectMake(0, 0, 480, 320);
        tabBar.hidden = YES;
    }
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait ||
            toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        [imageScrollView setZoomScale:1.0];
        [potdView setFrame:CGRectMake(0, 0, 320, 367)];
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [[UIApplication sharedApplication] setStatusBarHidden:NO animated:YES];
        UIView *tabBar = [self.tabBarController.view.subviews objectAtIndex:1];
        self.view.frame = CGRectMake(0, 0, 320, 480);
        tabBar.hidden = NO;
    }
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{

}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return potdView;
}

@end
