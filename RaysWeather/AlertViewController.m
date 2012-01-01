//
//  AlertViewController.m
//  RaysWeather
//
//  Created by Bobby Lunceford and Seth Hobson.
//  Copyright 2011 Ray's Weather. All rights reserved.
//

#import "AlertViewController.h"


@implementation AlertViewController

@synthesize uRL;

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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
