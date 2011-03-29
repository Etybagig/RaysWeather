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

@synthesize window=_window;

@synthesize tabBarController=_tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // Add the tab bar controller's current view as a subview of the window
    MyXMLParser *parser = [MyXMLParser new];
    NSString *path = @"http://alerts.weather.gov/cap/wwaatmget.php?x=NCZ018";
    [parser parseXMLFileAtURL:path];
    NSMutableDictionary *warnings = [[NSMutableDictionary alloc] init];
    bool finished = NO;
    int index = 0;
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
        }@catch(NSException *e){
            finished = YES;
        }
    }
    NSInteger numberOfWarnings = index--;
    if(numberOfWarnings>0){
    [[[[[self tabBarController] tabBar] items] objectAtIndex:2] setBadgeValue:@"!"];
    }
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

/*- (bool)isWarnings{-------------2
    MyXMLParser *parser = [MyXMLParser new];
    NSString *path = @"http://alerts.weather.gov/cap/wwaatmget.php?x=GAC079";
    [parser parseXMLFileAtURL:path];
    
    
} */

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
    [_window release];
    [_tabBarController release];
    [super dealloc];
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
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
