//
//  POTDController.h
//  RaysWeather
//
//  Created by Bobby Lunceford on 3/31/11.
//  Copyright 2011 Appalachian State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RaysWeatherAppDelegate.h"

@interface POTDController : UIViewController <UIScrollViewDelegate>{
    UIImageView *potdView;
    IBOutlet UIScrollView *imageScrollView;
    UIImage *image;
}

@end
