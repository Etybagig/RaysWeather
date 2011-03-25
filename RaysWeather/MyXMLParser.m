//
//  MyXMLParser.m
//  RaysWeather
//
//  Created by Bobby Lunceford on 3/24/11.
//  Copyright 2011 Appalachian State University. All rights reserved.
//

#import "MyXMLParser.h"


@implementation MyXMLParser
@synthesize parser, weatherData, item, currentElement, currentHumidity, currentWindSpeed, currentConditionIcon, currentTemperature, currentBarometer, currentWindDirection, currentHiTemp, currentLoTemp;

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
	}
    if ([elementName isEqualToString:@"forecast"]){
        item = [[NSMutableDictionary alloc] init];
        
    }
	
}

- (void)parseXMLFileAtURL:(NSString *)URL {
	weatherData = [[NSMutableArray alloc] init];
	NSURL *xmlUrl = [NSURL URLWithString:URL];
	parser = [[NSXMLParser alloc] initWithContentsOfURL:xmlUrl];
	[parser setDelegate:self];
	[parser setShouldProcessNamespaces:NO];
	[parser setShouldReportNamespacePrefixes:NO];
	[parser setShouldResolveExternalEntities:NO];
	[parser parse];
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
    //NSLog(@"found characters: %@", string);
}

@end
