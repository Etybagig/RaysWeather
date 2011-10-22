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
@synthesize allWarnings;
@synthesize table;

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    isThreadFinished = NO;
    [activityIndicator startAnimating];
    [NSThread detachNewThreadSelector:@selector(parseWarnings) toTarget:self withObject:nil];
}

- (void)parseWarnings
{
    @autoreleasepool {
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
        while (!finished){
            @try{
                warnings = [allWarnings objectAtIndex:index];
                index++;
                if(warnings == Nil){
                    index--;
                    finished = YES;
                }
                else if([[warnings objectForKey:@"summary"] isEqualToString:@""]){
                    index--;
                    finished = YES;
                }
                else if([allWarnings count]==index)
                    finished = YES;
            }@catch(NSException *e){
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    while(!isThreadFinished);
    
    NSLog(@"%d", numberOfWarnings);
    if(numberOfWarnings == 0){
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
 //   while(!isThreadFinished);
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    int row = [indexPath row];
    if(row<numberOfWarnings && noWarnings==NO){
        warnings = [allWarnings objectAtIndex:row];
        NSString *title = [self trimWhitespace:[warnings objectForKey:@"title"]];
        [[cell textLabel] setText:title];
    }
    else if(noWarnings==YES){
        [[cell textLabel] setText:@"No current watches or warnings"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    
    if([[[[tableView cellForRowAtIndexPath:indexPath] textLabel] text] isEqualToString:@"No current watches or warnings"])
        return;
    
    if(self.alertView == nil){
        AlertViewController *anAlertView = [[AlertViewController alloc] initWithNibName:@"AlertView" bundle:nil];
        self.alertView = anAlertView;
    }

    warnings = [allWarnings objectAtIndex:row];
    
    NSMutableString *entryURL = [warnings objectForKey:@"entryLink"];
    NSString *title = [self trimWhitespace:[warnings objectForKey:@"title"]];
    if(!([title isEqualToString:@"There are no active watches, warnings or advisories"])){
        alertView.uRL = [self trimWhitespace:entryURL];
        RaysWeatherAppDelegate *delegate = (RaysWeatherAppDelegate*)[[UIApplication sharedApplication] delegate];
        [delegate.alertNavController pushViewController:alertView animated:YES];
    }
    
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


- (void)viewDidUnload
{
    // Release any retained subviews of the main view.
    self.alertView = nil;
    [super viewDidUnload];
}



@end
