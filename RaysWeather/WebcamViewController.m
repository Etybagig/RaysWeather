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
    self.title = name;
    
    NSMutableString *imageString = [NSString stringWithFormat:@"http://raysweather.com/images/webcams/%@.jpg", extension];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageString]];
    UIImage *downloadedImage = [UIImage imageWithData:imageData];
    image = downloadedImage;
    
    webcamView = [[UIImageView alloc] initWithImage:image];
    [webcamView setContentMode:UIViewContentModeScaleAspectFit];
    [webcamView setFrame:CGRectMake(0,0,320,367)];
    
    [imageScrollView addSubview:webcamView];
    [imageScrollView setContentSize:CGSizeMake(webcamView.frame.size.width, 
                                               webcamView.frame.size.height)];
    [imageScrollView setScrollEnabled:YES];
    [imageScrollView setMinimumZoomScale:1.0];
    [imageScrollView setMaximumZoomScale:4.0];
    [imageScrollView setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated
{

}



-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeRight ||
       toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft)
    {
        [imageScrollView setZoomScale:1.0];
        [webcamView setFrame:CGRectMake(0, 0, 480, 320)];
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
        [webcamView setFrame:CGRectMake(0, 0, 320, 367)];
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [[UIApplication sharedApplication] setStatusBarHidden:NO animated:YES];
        UIView *tabBar = [self.tabBarController.view.subviews objectAtIndex:1];
        self.view.frame = CGRectMake(0, 0, 320, 480);
        tabBar.hidden = NO;
    }
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

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return webcamView;
}

@end
