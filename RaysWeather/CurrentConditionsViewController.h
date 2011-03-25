//
//  CurrentConditionsViewController.h
//  RaysWeather
//
//  Created by Bobby Lunceford on 3/24/11.
//  Copyright 2011 Appalachian State University. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CurrentConditionsViewController : UIViewController {
        IBOutlet UIImageView *currentConditionImage;
        IBOutlet UILabel *station;
        IBOutlet UILabel *wind;
        IBOutlet UILabel *humidity;
        IBOutlet UILabel *barometer;
        IBOutlet UILabel *warning;
        IBOutlet UILabel *currentTemp;
        IBOutlet UILabel *windDirection;
        IBOutlet UILabel *currentHi;
        IBOutlet UILabel *currentLo;
        IBOutlet UIScrollView *todaysSummary;
    }
    
    @property (nonatomic, retain) UIImageView *currentConditionImage;
    @property (nonatomic, retain) UILabel *station;
    @property (nonatomic, retain) UILabel *wind;
    @property (nonatomic, retain) UILabel *humidity;
    @property (nonatomic, retain) UILabel *barometer;
    @property (nonatomic, retain) UILabel *warning;
    @property (nonatomic, retain) UILabel *currentTemp;
    @property (nonatomic, retain) UILabel *windDirection;
    @property (nonatomic, retain) UILabel *currentHi;
    @property (nonatomic, retain) UILabel *currentLo;
    @property (nonatomic, retain) UIScrollView *todaysSummary;
    
@end