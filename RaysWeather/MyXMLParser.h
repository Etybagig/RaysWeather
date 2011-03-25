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

- (void)parseXMLFileAtURL:(NSString *)URL;
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;

@end
