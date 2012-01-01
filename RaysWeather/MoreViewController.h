//
//  MoreViewController.h
//  RaysWeather
//
//  Created by Bobby Lunceford and Seth Hobson.
//  Copyright 2011 Ray's Weather. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RaysWeatherAppDelegate.h"
#import "POTDController.h"
#import "WebcamListController.h"

@interface MoreViewController : UIViewController
{
    IBOutlet UIButton *potd;
    IBOutlet UIButton *webcams;
}

- (void)potdButtonTouched:(id)sender;
- (void)webcamsButtonTouched:(id)sender;

@end
