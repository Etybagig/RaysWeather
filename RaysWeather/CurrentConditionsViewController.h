//
//  CurrentConditionsViewController.h
//  RaysWeather
//
//  Created by Bobby Lunceford on 3/24/11.
//  Copyright 2011 Appalachian State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface CurrentConditionsViewController : UIViewController {
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
    NSMutableDictionary *weatherDictionary;
    
}

- (NSString *)trimWhitespace:(NSMutableString *)stringToTrim;

@end