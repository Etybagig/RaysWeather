//
//  ForecastViewController.h
//  RaysWeather
//
//  Created by Bobby Lunceford and Seth Hobson.
//  Copyright 2011 Ray's Weather. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "MyXMLParser.h"
#import "RaysWeatherAppDelegate.h"

@interface ForecastViewController : UIViewController
{    
    //Dynamic elements
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
    IBOutlet UITextView *dayOneDescript;
    IBOutlet UITextView *dayTwoDescript;
    IBOutlet UITextView *dayThreeDescript;
    IBOutlet UIImageView *background;
    
    //Landscape specific elements
    IBOutlet UIImageView *faceOverlay;
    
    //Static elements
    IBOutlet UILabel *firsthi;
    IBOutlet UILabel *firstlo;
    IBOutlet UILabel *secondhi;
    IBOutlet UILabel *secondlo;
    IBOutlet UILabel *thirdhi;
    IBOutlet UILabel *thirdlo;
    IBOutlet UILabel *forecastTitle;
    
    NSCharacterSet *charsToTrim;
    NSMutableString *dayOneIconString;
    NSMutableString *dayTwoIconString;
    NSMutableString *dayThreeIconString;
    
    NSMutableDictionary *dayOneDictionary;
    NSMutableDictionary *dayTwoDictionary;
    NSMutableDictionary *dayThreeDictionary;
    
    CurrentConditionsViewController *currentConditions;
}

@property (nonatomic, strong) NSMutableDictionary *dayOneDictionary;
@property (nonatomic, strong) NSMutableDictionary *dayTwoDictionary;
@property (nonatomic, strong) NSMutableDictionary *dayThreeDictionary;

- (NSString *)trimWhitespace:(NSMutableString *)stringToTrim;
- (void)rotateToLandscape;
- (void)rotateToPortrait;
- (void)loadData;

@end
