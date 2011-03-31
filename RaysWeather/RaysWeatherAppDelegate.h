//
//  RaysWeatherAppDelegate.h
//  RaysWeather
//
//  Created by Bobby Lunceford on 3/24/11.
//  Copyright 2011 Appalachian State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertNavController.h"

@class AlertNavController;

@interface RaysWeatherAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    IBOutlet AlertNavController *alertNavController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@property (nonatomic, retain) IBOutlet AlertNavController *alertNavController;

//- (bool)isWarnings;---------3

@end
