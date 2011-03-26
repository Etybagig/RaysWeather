//
//  MyXMLParser.m
//  RaysWeather
//
//  Created by Bobby Lunceford on 3/24/11.
//  Copyright 2011 Appalachian State University. All rights reserved.
//

#import "MyXMLParser.h"


@implementation MyXMLParser
@synthesize parser, weatherData, item, currentElement, currentHumidity, currentWindSpeed, currentConditionIcon, currentTemperature, currentBarometer, currentWindDirection, currentHiTemp, currentLoTemp, currentIntro, day1, day2, day3, hi, lo, icon, day_of_week, description, currentIntroTitle;

- (void)parseXMLFileAtURL:(NSString *)URL {
	NSURL *xmlUrl = [NSURL URLWithString:URL];
	parser = [[NSXMLParser alloc] initWithContentsOfURL:xmlUrl];
	[parser setDelegate:self];
	[parser setShouldProcessNamespaces:NO];
	[parser setShouldReportNamespacePrefixes:NO];
	[parser setShouldResolveExternalEntities:NO];
	[parser parse];
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{			
	//NSLog(@"found this element: %@", elementName);
	currentElement = [elementName copy];
	if ([elementName isEqualToString:@"conditions"]) {
		item = [[NSMutableDictionary alloc] init];
		currentHumidity = [[NSMutableString alloc] init];
		currentWindSpeed = [[NSMutableString alloc] init];
		currentConditionIcon = [[NSMutableString alloc] init];
		currentTemperature = [[NSMutableString alloc] init];
		currentBarometer = [[NSMutableString alloc] init];
		currentWindDirection = [[NSMutableString alloc] init];
		currentHiTemp = [[NSMutableString alloc] init];
		currentLoTemp = [[NSMutableString alloc] init];
        weatherData = [[NSMutableArray alloc] init];
	}
    if ([elementName isEqualToString:@"forecast"]){
        item = [[NSMutableDictionary alloc] init];
        currentIntro = [[NSMutableString alloc] init];
        currentIntroTitle = [[NSMutableString alloc] init];
    }
    if ([elementName isEqualToString:@"day1"]){
        day1 = [[NSMutableArray alloc] init];
        hi = [[NSMutableString alloc] init];
        lo = [[NSMutableString alloc] init];
        icon = [[NSMutableString alloc] init];
        description = [[NSMutableString alloc] init];
        day_of_week = [[NSMutableString alloc] init];
    }
    if ([elementName isEqualToString:@"day2"]){
        day2 = [[NSMutableArray alloc] init];
        hi = [[NSMutableString alloc] init];
        lo = [[NSMutableString alloc] init];
        icon = [[NSMutableString alloc] init];
        description = [[NSMutableString alloc] init];
        day_of_week = [[NSMutableString alloc] init];        
    }
    if ([elementName isEqualToString:@"day3"]){
        day3 = [[NSMutableArray alloc] init];
        hi = [[NSMutableString alloc] init];
        lo = [[NSMutableString alloc] init];
        icon = [[NSMutableString alloc] init];
        description = [[NSMutableString alloc] init];
        day_of_week = [[NSMutableString alloc] init];
    }
	
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{     
	
	if ([elementName isEqualToString:@"conditions"]) {
		[item setObject:currentHumidity forKey:@"humidity"];
		[item setObject:currentWindSpeed forKey:@"wind_speed"];
		[item setObject:currentConditionIcon forKey:@"condition_icon"];
		[item setObject:currentTemperature forKey:@"temperature"];
		[item setObject:currentBarometer forKey:@"barometer"];
		[item setObject:currentWindDirection forKey:@"wind_direction"];
		[item setObject:currentHiTemp forKey:@"hi_temp"];
		[item setObject:currentLoTemp forKey:@"lo_temp"];
		[weatherData addObject:[item copy]];
	}
    if ([elementName isEqualToString:@"forecast"]){
        [item setObject:currentIntro forKey:@"introduction"];
        [item setObject:currentIntroTitle forKey:@"title"];
        [weatherData addObject:[item copy]];
    }
    if ([elementName isEqualToString:@"day1"]){
        [item setObject:hi forKey:@"hi"];
        [item setObject:lo forKey:@"lo"];
        [item setObject:icon forKey:@"icon"];
        [item setObject:day_of_week forKey:@"day_of_week"];
        [item setObject:description forKey:@"descrip"];
        [day1 addObject:[item copy]];
    }
    if ([elementName isEqualToString:@"day2"]){
        [item setObject:hi forKey:@"hi"];
        [item setObject:lo forKey:@"lo"];
        [item setObject:icon forKey:@"icon"];
        [item setObject:day_of_week forKey:@"day_of_week"];
        [item setObject:description forKey:@"descrip"];
        [day2 addObject:[item copy]];
    }
    if ([elementName isEqualToString:@"day3"]){
        [item setObject:hi forKey:@"hi"];
        [item setObject:lo forKey:@"lo"];
        [item setObject:icon forKey:@"icon"];
        [item setObject:day_of_week forKey:@"day_of_week"];
        [item setObject:description forKey:@"descrip"];
        [day3 addObject:[item copy]];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([currentElement isEqualToString:@"humidity"]) {
        [currentHumidity appendString:string];
    }
    else if ([currentElement isEqualToString:@"wind_speed"]) {
        [currentWindSpeed appendString:string];
    }
    else if ([currentElement isEqualToString:@"condition_icon"]){
        [currentConditionIcon appendString:string];
    }
    else if([currentElement isEqualToString:@"temperature"]){
        [currentTemperature appendString:string];
    }
    else if([currentElement isEqualToString:@"barometer"]){
        [currentBarometer appendString:string];
    }
    else if([currentElement isEqualToString:@"wind_direction"]){
        [currentWindDirection appendString:string];
    }
    else if([currentElement isEqualToString:@"hi_temp"]){
        [currentHiTemp appendString:string];
    }
    else if([currentElement isEqualToString:@"lo_temp"]){
        [currentLoTemp appendString:string];
    }
    else if([currentElement isEqualToString:@"introduction"]){
        [currentIntro appendString:string];
    }
    else if([currentElement isEqualToString:@"high_temperature"]){
        [hi appendString:string];
    }
    else if([currentElement isEqualToString:@"low_temperature"]){
        [lo appendString:string];
    }
    else if([currentElement isEqualToString:@"sky_condition"]){
        [icon appendString:string];
    }
    else if([currentElement isEqualToString:@"day_of_week"]){
        [day_of_week appendString:string];
    }
    else if([currentElement isEqualToString:@"forecast_text"]){
        [description appendString:string];
    }
    else if([currentElement isEqualToString:@"title"]){
        [currentIntroTitle appendString:string];
    }
    //NSLog(@"found characters: %@", string);
}

@end
