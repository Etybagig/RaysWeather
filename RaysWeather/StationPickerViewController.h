//
//  StationPickerViewController.h
//  RaysWeather
//
//  Created by Bobby Lunceford on 7/5/11.
//  Copyright 2011 Appalachian State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RaysWeatherAppDelegate.h"
#import "CurrentConditionsViewController.h"

@class RaysWeatherAppDelegate;
@class CurrentConditionsViewController;

@interface StationPickerViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
{
    IBOutlet UIPickerView *stationPicker;
    IBOutlet UIButton *select;
    NSInteger selectedStation;
    RaysWeatherAppDelegate *delegate;
    CurrentConditionsViewController *currentViewController;
}

@property (nonatomic, retain) CurrentConditionsViewController *currentViewController;

- (NSString *)trimWhitespace:(NSMutableString *)stringToTrim;
- (IBAction)buttonPressed;

@end
