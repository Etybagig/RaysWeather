//
//  AlertViewController.m
//  RaysWeather
//
//  Created by Bobby Lunceford on 3/30/11.
//  Copyright 2011 Appalachian State University. All rights reserved.
//

#import "AlertViewController.h"


@implementation AlertViewController

@synthesize uRL;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    parser = [[MyXMLParser alloc] init];
    [parser parseXMLFileAtURL:uRL];
    
    NSMutableDictionary *alert = [parser.alert objectAtIndex:0];
    headline.text = [alert objectForKey:@"headline"];
    description.text = [alert objectForKey:@"description"];
    instruction.text = [alert objectForKey:@"instruction"];
    self.title = [alert objectForKey:@"severity"];
    [parser release];
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

- (void)dealloc
{
    [uRL release];
    [super dealloc];
}

@end
