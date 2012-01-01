//
//  POTDController.h
//  RaysWeather
//
//  Created by Bobby Lunceford and Seth Hobson.
//  Copyright 2011 Ray's Weather. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RaysWeatherAppDelegate.h"
#import "MyXMLParser.h"

@interface POTDController : UIViewController <UIScrollViewDelegate>
{
    UIImageView *potdView;
    IBOutlet UIScrollView *imageScrollView;
    UIImage *image;
    IBOutlet UITextView *caption;
    NSString *captionText;
}

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong) NSString *captionText;

- (NSString *)trimWhitespace:(NSMutableString *)stringToTrim;

@end
