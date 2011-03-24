//
//  FirstViewController.h
//  RaysWeather
//
//  Created by James Fenwick on 3/24/11.
//  Copyright 2011 Appalachian State University. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FirstViewController : UIViewController {
        IBOutlet UIImageView *currentConditionImage;
        IBOutlet UIImageView *dayOneImage;
        IBOutlet UIImageView *dayTwoImage;
        IBOutlet UIImageView *dayThreeImage;
        IBOutlet UILabel *station;
        IBOutlet UILabel *wind;
        IBOutlet UILabel *humidity;
        IBOutlet UILabel *barometer;
        IBOutlet UILabel *warning;
        IBOutlet UILabel *firstDay;
        IBOutlet UILabel *secondDay;
        IBOutlet UILabel *thirdDay;
        IBOutlet UILabel *currentTemp;
        IBOutlet UILabel *firstDay_hi;
        IBOutlet UILabel *firstDay_lo;
        IBOutlet UILabel *secondDay_hi;
        IBOutlet UILabel *secondDay_lo;
        IBOutlet UILabel *thirdDay_hi;
        IBOutlet UILabel *thirdDay_lo;
        IBOutlet UILabel *windDirection;
        IBOutlet UILabel *currentHi;
        IBOutlet UILabel *currentLo;
        //CLLocationManager *locationManager;
        NSXMLParser *parser;
        NSMutableArray *weatherData;
        NSMutableDictionary *item;
        
        //Current Conditions Elements
        NSString *currentElement;
        NSMutableString *currentHumidity;
        NSMutableString *currentWindSpeed;
        NSMutableString *currentConditionIcon;
        NSMutableString *currentTemperature;
        NSMutableString *currentBarometer;
        NSMutableString *currentWindDirection;
        NSMutableString *currentHiTemp;
        NSMutableString *currentLoTemp;
        
        //Forecast Elements
        NSMutableString *day_of_week1;
        NSMutableString *day_of_week2;
        NSMutableString *day_of_week3;
    }
    
    @property (nonatomic, retain) UIImageView *currentConditionImage;
    @property (nonatomic, retain) UIImageView *dayOneImage;
    @property (nonatomic, retain) UIImageView *dayTwoImage;
    @property (nonatomic, retain) UIImageView *dayThreeImage;
    @property (nonatomic, retain) UILabel *station;
    @property (nonatomic, retain) UILabel *wind;
    @property (nonatomic, retain) UILabel *humidity;
    @property (nonatomic, retain) UILabel *barometer;
    @property (nonatomic, retain) UILabel *warning;
    @property (nonatomic, retain) UILabel *firstDay;
    @property (nonatomic, retain) UILabel *secondDay;
    @property (nonatomic, retain) UILabel *thirdDay;
    @property (nonatomic, retain) UILabel *currentTemp;
    @property (nonatomic, retain) UILabel *firstDay_hi;
    @property (nonatomic, retain) UILabel *firstDay_lo;
    @property (nonatomic, retain) UILabel *secondDay_hi;
    @property (nonatomic, retain) UILabel *secondDay_lo;
    @property (nonatomic, retain) UILabel *thirdDay_hi;
    @property (nonatomic, retain) UILabel *thirdDay_lo;
    @property (nonatomic, retain) UILabel *windDirection;
    @property (nonatomic, retain) UILabel *currentHi;
    @property (nonatomic, retain) UILabel *currentLo;
    @property (nonatomic, retain) NSXMLParser *parser;
    @property (nonatomic, retain) NSMutableArray *weatherData;
    @property (nonatomic, retain) NSMutableDictionary *item;
    @property (nonatomic, retain) NSString *currentElement;
    @property (nonatomic, retain) NSMutableString *currentHumidity;
    @property (nonatomic, retain) NSMutableString *currentWindSpeed;
    @property (nonatomic, retain) NSMutableString *currentConditionIcon;
    @property (nonatomic, retain) NSMutableString *currentTemperature;
    @property (nonatomic, retain) NSMutableString *currentBarometer;
    @property (nonatomic, retain) NSMutableString *currentWindDirection;
    @property (nonatomic, retain) NSMutableString *currentHiTemp;
    @property (nonatomic, retain) NSMutableString *currentLoTemp;
    
    - (IBAction)showInfo;
    - (void)parseXMLFileAtURL:(NSString *)URL;
    - (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
    - (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
    - (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;
    
    @end