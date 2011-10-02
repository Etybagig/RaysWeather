//
//  RadarViewController.h
//  RaysWeather
//
//  Created by Bobby Lunceford on 4/12/11.
//  Copyright 2011 Appalachian State University. All rights reserved.
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
-(void)timerLoad;

@end
