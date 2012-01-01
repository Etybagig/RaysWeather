//
//  MyXMLParser.h
//  RaysWeather
//
//  Created by Bobby Lunceford and Seth Hobson.
//  Copyright 2011 Ray's Weather. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyXMLParser : NSObject <NSXMLParserDelegate>
{
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
    NSMutableString *closest_radar;
    
    //Photo of the Day
    NSMutableArray *photoOfTheDay;
    NSMutableString *date;
    NSMutableString *photoURL;
    NSMutableString *caption;
    
    //Error flag
    BOOL error;
}

@property (nonatomic, strong) NSXMLParser *parser;
@property (nonatomic, strong) NSMutableArray *weatherData;
@property (nonatomic, strong) NSMutableArray *day1;
@property (nonatomic, strong) NSMutableArray *day2;
@property (nonatomic, strong) NSMutableArray *day3;
@property (nonatomic, strong) NSMutableArray *warningData;
@property (nonatomic, strong) NSMutableArray *alert;
@property (nonatomic, strong) NSMutableArray *stationsData;
@property (nonatomic, strong) NSMutableArray *photoOfTheDay;
@property BOOL error;

- (void)parseXMLFileAtURL:(NSString *)URL;
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;

@end
