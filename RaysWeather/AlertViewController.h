//
//  AlertViewController.h
//  RaysWeather
//
//  Created by Bobby Lunceford and Seth Hobson.
//  Copyright 2011 Ray's Weather. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyXMLParser.h"

@interface AlertViewController : UIViewController
{
    IBOutlet UITextView *description;
    IBOutlet UILabel *headline;
    IBOutlet UITextView *instruction;
    NSString *uRL;
    MyXMLParser *parser;
}

@property(nonatomic, strong) NSString *uRL;

@end
