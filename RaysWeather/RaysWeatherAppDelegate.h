//
//  RaysWeatherAppDelegate.h
//  RaysWeather
//
//  Created by Bobby Lunceford on 3/24/11.
//  Copyright 2011 Appalachian State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertNavController.h"
#import "MoreNavController.h"
#import <CoreLocation/CoreLocation.h>

@class AlertNavController;
@class MoreNavController;

@interface RaysWeatherAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate, CLLocationManagerDelegate> {
//    IBOutlet UITabBarController *tabBarController;
    IBOutlet AlertNavController *alertNavController;
    IBOutlet MoreNavController *moreNavController;
    
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    NSMutableArray *stations;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet AlertNavController *alertNavController;
@property (nonatomic, retain) IBOutlet MoreNavController *moreNavController;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) CLLocation *currentLocation;

@end

@interface UITabBarController (MyApp)
@end