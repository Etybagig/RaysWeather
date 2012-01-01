//
//  StationPickerViewController.h
//  RaysWeather
//
//  Created by Bobby Lunceford and Seth Hobson.
//  Copyright 2011 Ray's Weather. All rights reserved.
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

@property (nonatomic, strong) CurrentConditionsViewController *currentViewController;

- (NSString *)trimWhitespace:(NSMutableString *)stringToTrim;
- (IBAction)buttonPressed;

@end
