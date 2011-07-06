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
#import "RaysWeatherAppDelegate.h"
#import "StationPickerViewController.h"

@class RaysWeatherAppDelegate;

@interface CurrentConditionsViewController : UIViewController 
{
    
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
    
    //Activity Indicator
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UILabel *activityIndicatorLabel;
    
    //Internet Error
    IBOutlet UILabel *connectionError;
    
    MyXMLParser *parser;
    NSMutableDictionary *weatherDictionary;
    NSMutableDictionary *stationInfo;
    RaysWeatherAppDelegate *delegate;
}

@property (nonatomic, retain) MyXMLParser *parser;
@property (nonatomic, retain) NSMutableDictionary *stationInfo;

- (void)showPicker;
- (void)locationReceived;
- (NSString *)trimWhitespace:(NSMutableString *)stringToTrim;
- (NSString *)roundAndSnap:(NSString *)stringToRound;
- (void)rotateToPortrait;
- (void)rotateToLandscape;
@end