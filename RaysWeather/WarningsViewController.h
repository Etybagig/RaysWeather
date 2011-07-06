//
//  WarningsViewController.h
//  RaysWeather
//
//  Created by Seth Hobson on 3/26/11.
//  Copyright 2011 Appalachian State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyXMLParser.h"
#import "AlertViewController.h"
#import "RaysWeatherAppDelegate.h"

@interface WarningsViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource> {
    
    IBOutlet UITableView *table;
    NSMutableDictionary *warnings;
    MyXMLParser *parser;
    NSInteger numberOfWarnings;
    NSInteger currentCell;
    BOOL noWarnings;
    AlertViewController *alertView;
}

@property (nonatomic, retain) AlertViewController *alertView;

- (NSString *)trimWhitespace:(NSMutableString *)stringToTrim;

@end