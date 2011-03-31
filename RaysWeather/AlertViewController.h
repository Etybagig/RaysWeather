//
//  AlertViewController.h
//  RaysWeather
//
//  Created by Bobby Lunceford on 3/30/11.
//  Copyright 2011 Appalachian State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyXMLParser.h"

@interface AlertViewController : UIViewController {
    IBOutlet UITextView *description;
    IBOutlet UILabel *headline;
    IBOutlet UITextView *instruction;
    NSString *uRL;
    MyXMLParser *parser;
}

@property(nonatomic, retain) NSString *uRL;

@end
