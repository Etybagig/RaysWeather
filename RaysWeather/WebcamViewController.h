//
//  WebcamViewController.h
//  RaysWeather
//
//  Created by Bobby Lunceford on 4/1/11.
//  Copyright 2011 Appalachian State University. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WebcamViewController : UIViewController <UIScrollViewDelegate>{
    UIImageView *webcamView;
    UIImage *image;
    IBOutlet UIScrollView *imageScrollView;
    NSString *name;
    NSString *extension;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UILabel *activityIndicatorLabel;
    UITapGestureRecognizer *tapGestureRecognizer;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *extension;
@property (nonatomic, retain) UITapGestureRecognizer *tapGestureRecognizer;

@end
