//
//  MyXMLParser.h
//  RaysWeather
//
//  Created by Bobby Lunceford on 3/24/11.
//  Copyright 2011 Appalachian State University. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyXMLParser : NSObject <NSXMLParserDelegate> {
    //CLLocationManager *locationManager;
    NSXMLParser *parser;
    NSMutableArray *weatherData;
    NSMutableDictionary *item;
    NSMutableString *currentType;
    
    //Current Conditions Elements
    NSString *currentElement;
    NSMutableString *currentHumidity;
    NSMutableString *currentWindSpeed;
    NSMutableString *currentConditionIcon;
    NSMutableString *currentTemperature;
    NSMutableString *currentBarometer;
    NSMutableString *currentBaroTrend;
    NSMutableString *currentWindDirection;
    NSMutableString *currentHiTemp;
    NSMutableString *currentLoTemp;
    NSMutableString *currentIntroTitle;
    NSMutableString *currentIntro;
    
    //Forecast Elements
    NSMutableString *hi;
    NSMutableString *lo;
    NSMutableString *icon;
    NSMutableString *day_of_week;
    NSMutableString *description;
    NSMutableArray *day1;
    NSMutableArray *day2;
    NSMutableArray *day3;
    
    //Alert Table Elements
    NSMutableArray *warningData;
    NSMutableString *linkToEntry;
    NSMutableString *title;
    NSMutableString *summary;
    
    //Alert Elements
    NSMutableArray *alert;
    NSMutableString *headline;
    NSMutableString *alertDescription;
    NSMutableString *instruction;
    NSMutableString *severity;
    
    //Stations
    NSMutableArray *stationsData;
    NSMutableString *station_id;
    NSMutableString *city;
    NSMutableString *state;
    NSMutableString *latitude;
    NSMutableString *longitude;
    NSMutableString *nws_zone_code;
    NSMutableString *nws_county_code;
    NSMutableString *station_name;
    
    //Error flag
    BOOL error;
}

@property (nonatomic, retain) NSXMLParser *parser;
@property (nonatomic, retain) NSMutableArray *weatherData;
@property (nonatomic, retain) NSMutableArray *day1;
@property (nonatomic, retain) NSMutableArray *day2;
@property (nonatomic, retain) NSMutableArray *day3;
@property (nonatomic, retain) NSMutableArray *warningData;
@property (nonatomic, retain) NSMutableArray *alert;
@property (nonatomic, retain) NSMutableArray *stationsData;
@property BOOL error;

- (void)parseXMLFileAtURL:(NSString *)URL;
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;

@end
