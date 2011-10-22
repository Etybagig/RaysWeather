//
//  RaysWeatherAppDelegate.m
//  RaysWeather
//
//  Created by Bobby Lunceford on 3/24/11.
//  Copyright 2011 Appalachian State University. All rights reserved.
//

#import "RaysWeatherAppDelegate.h"
#include "MyXMLParser.h"

@implementation RaysWeatherAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize alertNavController;
@synthesize moreNavController;
@synthesize currentNavController;
@synthesize locationManager;
@synthesize currentLocation;
@synthesize closestStation;
@synthesize currentConditions;
@synthesize stations;
@synthesize parser;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // Add the tab bar controller's current view as a subview of the window
    
    //Initialize core location
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    
    //Load stations
    parser = [MyXMLParser new];
    NSString *stationURL = @"http://raysweather.com/mobile/stations/";
    [parser parseXMLFileAtURL:stationURL];
    stations = parser.stationsData;
    
    [window addSubview:tabBarController.view];
    [window makeKeyAndVisible];
    return YES;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if(parser.error == YES)
        return;
    [currentConditions showPicker];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSDate* eventDate = locationManager.location.timestamp;
    NSTimeInterval howRecent;
    howRecent = [eventDate timeIntervalSinceNow];
    if(abs(howRecent) > 5.0)
        return;
    [locationManager stopUpdatingLocation];
    currentLocation = newLocation;
    double lat = currentLocation.coordinate.latitude;
    double lon = currentLocation.coordinate.longitude;
    NSLog(@"%2.4f", lat);
    NSLog(@"%2.4f", lon);

    closestStation = nil;
    double previousDistance = 1000.00;
    for(NSMutableDictionary *station in stations){
        double stationLat = [[self trimWhitespace:[station objectForKey:@"latitude"]] doubleValue];
        double stationLong = [[self trimWhitespace:[station objectForKey:@"longitude"]] doubleValue];
        double distance = sqrt(pow((stationLat-lat),2) + pow((stationLong-lon),2));
        distance = fabs(distance);
        if(distance<previousDistance){
            closestStation = station;
            previousDistance = distance;
        }
    }
    if(parser.error == YES)
        return;
    [currentConditions locationReceived];
}

- (NSString *)trimWhitespace:(NSMutableString *)stringToTrim{
    NSString *removeNewLine = [stringToTrim stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *removeTab = [removeNewLine stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    return removeTab;
}

// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)thistabBarController didSelectViewController:(UIViewController *)viewController
{
    if(thistabBarController.interfaceOrientation==UIInterfaceOrientationPortrait ||
       thistabBarController.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)
        [viewController willRotateToInterfaceOrientation:UIInterfaceOrientationPortrait duration:10];
    else if(thistabBarController.interfaceOrientation==UIInterfaceOrientationLandscapeRight ||
            thistabBarController.interfaceOrientation==UIInterfaceOrientationLandscapeLeft)
        [viewController willRotateToInterfaceOrientation:UIInterfaceOrientationLandscapeLeft duration:10];
}


@end
