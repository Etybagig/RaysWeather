//
//  MoreViewController.h
//  RaysWeather
//
//  Created by Bobby Lunceford on 3/31/11.
//  Copyright 2011 Appalachian State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RaysWeatherAppDelegate.h"
#import "POTDController.h"

@interface MoreViewController : UIViewController {
    IBOutlet UIButton *potd;
    IBOutlet UIButton *webcams;
}

- (void)potdButtonTouched:sender;

@end
