//
//  XMLParser.m
//  iPresen
//
//  Created by marutanm on 3/28/10.
//  Copyright 2010 shisobu.in. All rights reserved.
//

#import "XMLParser.h"


@implementation XMLParser

- (void) dealloc{
    NSLog(@"dealloc");
    // [parser release];
    [super dealloc];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"start parse XML");
}

- (void)parseXMLFileByName:(NSString *)file parseError:(NSError **)error{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSURL *url;
    NSBundle *bundle = [NSBundle mainBundle];
    if (bundle) {
        NSString *localFilePath = [bundle pathForResource:file ofType:@"xml"];
        if (localFilePath) {
            url = [NSURL fileURLWithPath:localFilePath];
        }
    }
    [self parseXMLFileAtURL:url parseError:&error];
    return array;
}

- (void)parseXMLFileAtURL:(NSURL *)URL parseError:(NSError **)error
{
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:URL];
    [parser setDelegate:self];
    [parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    NSError *parseError = [parser parserError];
    if (parseError && error) {
        *error = parseError;
    }
    [parser release];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
    if ([elementName isEqualToString:@"page"]) {
                    [array addObject:[[NSMutableDictionary alloc] init]];
    } else if ([elementName isEqualToString:@"page"]) {
              [[array lastObject] setObject:[[NSMutableArray alloc] init] forKey:elementName];
    }
    currentKey = elementName;
    NSLog(@"start: %@", elementName);
    // NSLog(@"currentKey: %@", currentKey);
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (qName) {
        elementName = qName;
    }
    currentKey = nil;
    NSLog(@"end: %@", elementName);
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
//    if (![string isEqualToString:@""]){
//                  NSLog(@"string: %@", string);
//    }
    if ([currentKey isEqualToString:@"title"]) {
        [[array lastObject] setValue:string forKey:currentKey];
    } else if ([currentKey isEqualToString:@"content"]){
          [[[array lastObject] objectForKey:currentKey] addObject:string];
    } else {
    }
        NSLog(@"%@:%@", currentKey, string);
}

@end
