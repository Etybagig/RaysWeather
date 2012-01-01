//
//  WarningsViewController.m
//  RaysWeather
//
//  Created by Seth Hobson and Bobby Lunceford.
//  Copyright 2011 Ray's Weather. All rights reserved.
//

#import "WarningsViewController.h"

@implementation WarningsViewController

@synthesize alertView, allWarnings, table;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(appActivated:)
                                                 name: UIApplicationDidBecomeActiveNotification
                                               object: nil];
}

- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewDidUnload];
}

/*
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(appActivated:)
                                                 name: UIApplicationDidBecomeActiveNotification
                                               object: nil];
}
*/

- (void)appActivated:(NSNotification *)note
{
    NSLog(@"reloading warnings");
    [self loadData];
}

- (void)loadData
{
    isThreadFinished = NO;
    [activityIndicator startAnimating];
    [NSThread detachNewThreadSelector:@selector(parseWarnings) toTarget:self withObject:nil];
}

- (void)parseWarnings
{
    @autoreleasepool
    {
        RaysWeatherAppDelegate *delegate = (RaysWeatherAppDelegate*)[[UIApplication sharedApplication] delegate];
        
        NSMutableString *zoneCode = [delegate.closestStation valueForKey:@"nwsZoneCode"];
        NSString *zone = [self trimWhitespace:zoneCode];
        NSMutableString *countyCode = [delegate.closestStation valueForKey:@"nwsCountyCode"];
        NSString *county = [self trimWhitespace:countyCode];
        
        parser = [[MyXMLParser alloc] init];
        NSString *path = [NSString stringWithFormat:@"http://alerts.weather.gov/cap/wwaatmget.php?x=%@", zone];
        [parser parseXMLFileAtURL:path];
        NSMutableArray *zoneWarnings = parser.warningData;
        NSString *path2 = [NSString stringWithFormat:@"http://alerts.weather.gov/cap/wwaatmget.php?x=%@", county];
        [parser parseXMLFileAtURL:path2];
        NSMutableArray *countyWarnings = parser.warningData;
        NSMutableSet *set = [NSMutableSet setWithArray:zoneWarnings];
        [set addObjectsFromArray:countyWarnings];
        self.allWarnings = [set allObjects];
        
        bool finished = NO;
        int index = 0;
        while (!finished)
        {
            @try
            {
                warnings = [allWarnings objectAtIndex:index];
                index++;
                if (warnings == nil)
                {
                    index--;
                    finished = YES;
                }
                else if ([[warnings objectForKey:@"summary"] isEqualToString:@""])
                {
                    index--;
                    finished = YES;
                }
                else if ([allWarnings count] == index)
                    finished = YES;
            }
            @catch (NSException *e)
            {
                finished = YES;
            }
        }
        numberOfWarnings = index--;
        
        [activityIndicator stopAnimating];
        activityIndicatorLabel.hidden = YES;
        activityIndicator.hidden = YES;
        isThreadFinished = YES;
        [self.table reloadData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    while(!isThreadFinished);
    
    NSLog(@"%d", numberOfWarnings);
    if (numberOfWarnings == 0)
    {
        noWarnings = YES;
        return 1;
    }
    else
    {
        noWarnings = NO;
        return numberOfWarnings;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
    }
    
    int row = [indexPath row];
    if (row < numberOfWarnings && noWarnings == NO)
    {
        warnings = [allWarnings objectAtIndex:row];
        NSString *title = [self trimWhitespace:[warnings objectForKey:@"title"]];
        [[cell textLabel] setText:title];
    }
    else if (noWarnings == YES)
    {
        [[cell textLabel] setText:@"No current watches or warnings."];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellText = @"No current watches or warnings.";
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:17.0];
    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    
    return labelSize.height + 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    warnings = [allWarnings objectAtIndex:row];
    
    if ([[[[tableView cellForRowAtIndexPath:indexPath] textLabel] text] isEqualToString:@"No current watches or warnings"])
        return;
    
    AlertViewController *anAlertView = [[AlertViewController alloc] initWithNibName:@"AlertView" bundle:nil];
    alertView = anAlertView;
    
    NSMutableString *entryURL = [warnings objectForKey:@"entryLink"];
    NSString *title = [self trimWhitespace:[warnings objectForKey:@"title"]];
    if (!([title isEqualToString:@"There are no active watches, warnings or advisories"]))
    {
        alertView.uRL = [self trimWhitespace:entryURL];
        RaysWeatherAppDelegate *delegate = (RaysWeatherAppDelegate*)[[UIApplication sharedApplication] delegate];
        [delegate.alertNavController pushViewController:alertView animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)trimWhitespace:(NSMutableString *)stringToTrim
{
    NSString *removeNewLine = [stringToTrim stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *removeTab = [removeNewLine stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    NSString *removeLeadingSpaces = [removeTab stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return removeLeadingSpaces;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

@end
