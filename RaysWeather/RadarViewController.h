//
//  RadarViewController.h
//  RaysWeather
//
//  Created by Bobby Lunceford and Seth Hobson.
//  Copyright 2011 Ray's Weather. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RaysWeatherAppDelegate.h"

@interface RadarViewController : UIViewController 
{
    IBOutlet UIWebView *radar;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UILabel *activityIndicatorLabel;
    NSTimer *timer;
}

- (NSString *)trimWhitespace:(NSMutableString *)stringToTrim;
- (void)timerLoad;
- (void)loadData;

@end
