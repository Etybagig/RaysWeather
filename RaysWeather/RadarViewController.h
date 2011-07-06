//
//  RadarViewController.h
//  RaysWeather
//
//  Created by Bobby Lunceford on 4/12/11.
//  Copyright 2011 Appalachian State University. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RadarViewController : UIViewController <UIWebViewDelegate>{
    IBOutlet UIWebView *radar;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UILabel *activityIndicatorLabel;
}

@end
