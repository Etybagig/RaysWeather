//
//  RaysWeatherAppDelegate.m
//  RaysWeather
//
//  Created by Bobby Lunceford on 3/24/11.
//  Copyright 2011 Appalachian State University. All rights reserved.
//

#import "RaysWeatherAppDelegate.h"
#include "MyXMLParser.h"
//#include "MyXMLParser.h"--------1

@implementation RaysWeatherAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize alertNavController;
@synthesize moreNavController;
@synthesize locationManager;
@synthesize currentLocation;

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
    
    //Load stations if needed
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *stationsPath = [documentsDirectory stringByAppendingPathComponent:@"Stations.plist"];
    stations = [[NSMutableArray alloc] initWithContentsOfFile:stationsPath];
    if(stations == nil){
        MyXMLParser *parser = [MyXMLParser new];
        NSString *stationURL = @"http://raysweather.com/mobile/stations/";
        [parser parseXMLFileAtURL:stationURL];
        stations = parser.stationsData;
        [stations writeToFile:stationsPath atomically:YES];
    }
    
    MyXMLParser *parser = [MyXMLParser new];
    NSString *path = @"http://alerts.weather.gov/cap/wwaatmget.php?x=NCZ018";
    [parser parseXMLFileAtURL:path];
    NSMutableDictionary *warnings = [[NSMutableDictionary alloc] init];
    int index = 0;
    warnings = [parser.warningData objectAtIndex:index];
    [parser release];
    bool finished = NO;
    while (!finished){
        @try{
            warnings = [parser.warningData objectAtIndex:index];
            index++;
            if(warnings == Nil){
                index--;
                finished = YES;
            }
            else if([[warnings objectForKey:@"summary"] isEqualToString:@""]){
                index--;
                finished = YES;
            }
            else if([parser.warningData count] == index)
                finished = YES;
        }@catch(NSException *e){
            finished = YES;
        }
    }
    [warnings release];
    NSInteger numberOfWarnings = index--;
    if(numberOfWarnings>0){
    [[[[[self tabBarController] tabBar] items] objectAtIndex:2] setBadgeValue:@"!"];
    }
    
    
    [window addSubview:tabBarController.view];
    [window makeKeyAndVisible];
    return YES;
}

/*- (bool)isWarnings{-------------2
    MyXMLParser *parser = [MyXMLParser new];
    NSString *path = @"http://alerts.weather.gov/cap/wwaatmget.php?x=GAC079";
    [parser parseXMLFileAtURL:path];
    
    
} */

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    currentLocation = newLocation;
    double lat = currentLocation.coordinate.latitude;
    double lon = currentLocation.coordinate.longitude;
    NSLog(@"%2.4f", lat);
    NSLog(@"%2.4f", lon);
    [locationManager stopUpdatingLocation];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [locationManager release];
    [window release];
    [tabBarController release];
    [super dealloc];
}


// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)thistabBarController didSelectViewController:(UIViewController *)viewController
{
    if(thistabBarController.interfaceOrientation==UIInterfaceOrientationPortrait ||
       thistabBarController.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown){
        if([viewController.title isEqualToString:@"Current Conditions"] ||
           [viewController.title isEqualToString:@"Forecast"]){
            [viewController rotateToPortrait];
        }
    }
    else if(thistabBarController.interfaceOrientation==UIInterfaceOrientationLandscapeRight ||
            thistabBarController.interfaceOrientation==UIInterfaceOrientationLandscapeLeft){
        if([viewController.title isEqualToString:@"Current Conditions"] ||
           [viewController.title isEqualToString:@"Forecast"]){
            [viewController rotateToLandscape];
        }
    }
}

/*
- (void)tabBarController:(UITabBarController *)thistabBarController willBeginCustomizingViewControllers:(NSArray *)viewControllers
{

}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
