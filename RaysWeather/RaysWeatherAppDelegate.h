//
//  RaysWeatherAppDelegate.h
//  RaysWeather
//
//  Created by Bobby Lunceford on 3/24/11.
//  Copyright 2011 Appalachian State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#include "CurrentConditionsViewController.h"

@class CurrentConditionsViewController;

@interface RaysWeatherAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate, CLLocationManagerDelegate> {
    IBOutlet UINavigationController *alertNavController;
    IBOutlet UINavigationController *moreNavController;
    IBOutlet UINavigationController *currentNavController;
    
    CurrentConditionsViewController *currentConditions;
    
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    NSMutableArray *stations;
    NSMutableDictionary *closestStation;
    MyXMLParser *parser;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet UINavigationController *alertNavController;
@property (nonatomic, retain) IBOutlet UINavigationController *moreNavController;
@property (nonatomic, retain) IBOutlet UINavigationController *currentNavController;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) CLLocation *currentLocation;
@property (nonatomic, retain) NSMutableDictionary *closestStation;
@property (nonatomic, retain) NSMutableArray *stations;
@property (nonatomic, retain) CurrentConditionsViewController *currentConditions;
@property (nonatomic, retain) MyXMLParser *parser;

- (NSString *)trimWhitespace:(NSMutableString *)stringToTrim;

@end

@interface UITabBarController (MyApp)
@end