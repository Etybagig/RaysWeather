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

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, strong) IBOutlet UINavigationController *alertNavController;
@property (nonatomic, strong) IBOutlet UINavigationController *moreNavController;
@property (nonatomic, strong) IBOutlet UINavigationController *currentNavController;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, strong) NSMutableDictionary *closestStation;
@property (nonatomic, strong) NSMutableArray *stations;
@property (nonatomic, strong) CurrentConditionsViewController *currentConditions;
@property (nonatomic, strong) MyXMLParser *parser;

- (NSString *)trimWhitespace:(NSMutableString *)stringToTrim;

@end

@interface UITabBarController (MyApp)
@end