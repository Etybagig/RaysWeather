//
//  ForecastViewController.h
//  RaysWeather
//
//  Created by Bobby Lunceford on 3/24/11.
//  Copyright 2011 Appalachian State University. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ForecastViewController : UIViewController {
    IBOutlet UILabel *firstDay_hi;
    IBOutlet UILabel *firstDay_lo;
    IBOutlet UILabel *secondDay_hi;
    IBOutlet UILabel *secondDay_lo;
    IBOutlet UILabel *thirdDay_hi;
    IBOutlet UILabel *thirdDay_lo;
    IBOutlet UILabel *firstDay;
    IBOutlet UILabel *secondDay;
    IBOutlet UILabel *thirdDay;
    IBOutlet UIImageView *dayOneImage;
    IBOutlet UIImageView *dayTwoImage;
    IBOutlet UIImageView *dayThreeImage;
}

@property (nonatomic, retain) UIImageView *dayOneImage;
@property (nonatomic, retain) UIImageView *dayTwoImage;
@property (nonatomic, retain) UIImageView *dayThreeImage;
@property (nonatomic, retain) UILabel *firstDay;
@property (nonatomic, retain) UILabel *secondDay;
@property (nonatomic, retain) UILabel *thirdDay;
@property (nonatomic, retain) UILabel *firstDay_hi;
@property (nonatomic, retain) UILabel *firstDay_lo;
@property (nonatomic, retain) UILabel *secondDay_hi;
@property (nonatomic, retain) UILabel *secondDay_lo;
@property (nonatomic, retain) UILabel *thirdDay_hi;
@property (nonatomic, retain) UILabel *thirdDay_lo;

@end
