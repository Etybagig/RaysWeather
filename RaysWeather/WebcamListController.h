//
//  WebcamListController.h
//  RaysWeather
//
//  Created by Bobby Lunceford and Seth Hobson.
//  Copyright 2011 Ray's Weather. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebcamViewController.h"
#import "RaysWeatherAppDelegate.h"

@interface WebcamListController : UITableViewController
{
    NSMutableArray *webcams;
    WebcamViewController *webcamView;
}

@property (nonatomic, strong) WebcamViewController *webcamView;

@end
