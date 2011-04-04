//
//  CurrentConditionsViewController.h
//  RaysWeather
//
//  Created by Bobby Lunceford on 3/24/11.
//  Copyright 2011 Appalachian State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#include <math.h>
#import "MyXMLParser.h"


@interface CurrentConditionsViewController : UIViewController {
    
    //Dynamic elements
    IBOutlet UIImageView *currentConditionImage;
    IBOutlet UILabel *station;
    IBOutlet UILabel *wind;
    IBOutlet UILabel *humidity;
    IBOutlet UILabel *barometer;
    IBOutlet UILabel *currentTemp;
    IBOutlet UILabel *currentHi;
    IBOutlet UILabel *currentLo;
    IBOutlet UILabel *todaysSummaryTitle;
    IBOutlet UITextView *todaysSummary;
    IBOutlet UIImageView *background;
    
    //Static Elements
    IBOutlet UILabel *currCondLabel;
    IBOutlet UILabel *windLabel;
    IBOutlet UILabel *humidLabel;
    IBOutlet UILabel *baroLabel;
    IBOutlet UILabel *hiLabel;
    IBOutlet UILabel *loLabel;
    IBOutlet UILabel *todaysforcastLabel;
    
    MyXMLParser *parser;
    NSMutableDictionary *weatherDictionary;
    
}

- (NSString *)trimWhitespace:(NSMutableString *)stringToTrim;
- (NSString *)roundAndSnap:(NSString *)stringToRound;
- (void)rotateToPortrait;
- (void)rotateToLandscape;
@end