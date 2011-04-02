//
//  WebcamListController.h
//  RaysWeather
//
//  Created by Bobby Lunceford on 4/1/11.
//  Copyright 2011 Appalachian State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebcamViewController.h"
#import "RaysWeatherAppDelegate.h"

@interface WebcamListController : UITableViewController {
    NSMutableArray *webcams;
    WebcamViewController *webcamView;
}

@property (nonatomic, retain) WebcamViewController *webcamView;

@end
