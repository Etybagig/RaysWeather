//
//  WarningsViewController.h
//  RaysWeather
//
//  Created by Seth Hobson on 3/26/11.
//  Copyright 2011 Appalachian State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyXMLParser.h"


@interface WarningsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    
    IBOutlet UITableView *table;
    NSMutableDictionary *warnings;
    MyXMLParser *parser;
    NSInteger numberOfWarnings;
    NSInteger currentCell;
}

- (NSString *)trimWhitespace:(NSMutableString *)stringToTrim;
- (NSString *)addEntry:(NSString *)warning dictionary:(NSMutableDictionary *)dict;

@end
