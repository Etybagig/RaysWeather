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
    IBOutlet UITextView *dayOneDescript;
    IBOutlet UITextView *dayTwoDescript;
    IBOutlet UITextView *dayThreeDescript;
    
    NSCharacterSet *charsToTrim;
    NSMutableString *dayOneIconString;
    NSMutableString *dayTwoIconString;
    NSMutableString *dayThreeIconString;
    
    NSMutableDictionary *dayOneDictionary;
    NSMutableDictionary *dayTwoDictionary;
    NSMutableDictionary *dayThreeDictionary;
}

@property (nonatomic, retain) NSMutableDictionary *dayOneDictionary;
@property (nonatomic, retain) NSMutableDictionary *dayTwoDictionary;
@property (nonatomic, retain) NSMutableDictionary *dayThreeDictionary;

- (NSString *)trimWhitespace:(NSMutableString *)stringToTrim;

@end
