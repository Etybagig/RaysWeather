//
//  POTDController.m
//  RaysWeather
//
//  Created by Bobby Lunceford on 3/31/11.
//  Copyright 2011 Appalachian State University. All rights reserved.
//

#import "POTDController.h"


@implementation POTDController
@synthesize tapGestureRecognizer, captionText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [activityIndicator startAnimating];
    [NSThread detachNewThreadSelector:@selector(loadPhoto) toTarget:self withObject:nil];
    [self willRotateToInterfaceOrientation:self.interfaceOrientation duration:10];
}

- (void)loadPhoto
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    MyXMLParser *parser = [[MyXMLParser alloc] init];
    [parser parseXMLFileAtURL:@"http://raysweather.com/mobile/photo/"];
    
    NSMutableDictionary *potd = [parser.photoOfTheDay objectAtIndex:0];
    NSMutableString *photoURL = [potd objectForKey:@"photoURL"];
    
    NSString *imageString = [self trimWhitespace:photoURL];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageString]];
    image = [UIImage imageWithData:imageData];
    
    self.captionText = [self trimWhitespace:[potd objectForKey:@"caption"]];
    
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
    
    NSDate *date = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateStyle:NSDateFormatterShortStyle];
    NSString *dateString = [format stringFromDate:date];
    self.title = [NSString stringWithFormat:@"Photo for %@", dateString];
    [format release];
    
    [self performSelectorOnMainThread:@selector(updateUI) withObject:nil waitUntilDone: NO];
    [parser release];
    [pool drain];
}

- (void)updateUI
{
    caption.text = captionText;
    caption.hidden = NO;
}

- (void)viewDidLoad
{
    UITapGestureRecognizer *newTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTaps:)];
    self.tapGestureRecognizer = newTapGestureRecognizer;
    self.tapGestureRecognizer.numberOfTouchesRequired = 1;
    self.tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:self.tapGestureRecognizer];
    [newTapGestureRecognizer release];
}

-(void)handleTaps:(UITapGestureRecognizer*)paramSender
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO animated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (NSString *)trimWhitespace:(NSMutableString *)stringToTrim{
    NSString *removeNewLine = [stringToTrim stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *removeTab = [removeNewLine stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    return removeTab;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
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

-(void)dealloc
{
    [tapGestureRecognizer release];
    [captionText release];
    [super dealloc];
}

@end
