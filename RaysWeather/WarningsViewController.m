//
//  WarningsViewController.m
//  RaysWeather
//
//  Created by Seth Hobson on 3/26/11.
//  Copyright 2011 Appalachian State University. All rights reserved.
//

#import "WarningsViewController.h"

@implementation WarningsViewController

@synthesize alertView;

- (void)viewDidLoad
{
    parser = [MyXMLParser new];
    NSString *path = @"http://alerts.weather.gov/cap/wwaatmget.php?x=NCZ018";
    [parser parseXMLFileAtURL:path];
    
    bool finished = NO;
    int index = 0;
    while (!finished){
        @try{
            warnings = [parser.warningData objectAtIndex:index];
            index++;
            if(warnings == Nil){
                index--;
                finished = YES;
            }
            else if([[warnings objectForKey:@"summary"] isEqualToString:@""]){
                index--;
                finished = YES;
            }
        }@catch(NSException *e){
            finished = YES;
        }
    }
    numberOfWarnings = index--;
    currentCell = 0;
    
    table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [table setDelegate:self];
    [table setDataSource:self];
    

    
    [super viewDidLoad];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%d", numberOfWarnings);
    return numberOfWarnings;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    int row = [indexPath row];
    if(row<numberOfWarnings && numberOfWarnings!=currentCell){
        warnings = [parser.warningData objectAtIndex:currentCell++];
        [[cell textLabel] setText:[warnings objectForKey:@"title"]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    NSLog(@"%d", row);
    if(self.alertView == nil){
        AlertViewController *anAlertView = [[AlertViewController alloc] initWithNibName:@"AlertView" bundle:nil];
        self.alertView = anAlertView;
        [anAlertView release];
    }

    warnings = [parser.warningData objectAtIndex:row];
    NSMutableString *entryURL = [warnings objectForKey:@"entryLink"];
    alertView.uRL = [self trimWhitespace:entryURL];
    
    RaysWeatherAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate.alertNavController pushViewController:alertView animated:YES];
    
}

- (NSString *)trimWhitespace:(NSMutableString *)stringToTrim
{
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
