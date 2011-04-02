//
//  WebcamViewController.h
//  RaysWeather
//
//  Created by Bobby Lunceford on 4/1/11.
//  Copyright 2011 Appalachian State University. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WebcamViewController : UIViewController {
    IBOutlet UIImageView *webcamView;
    NSString *name;
    NSString *extension;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *extension;

@end
