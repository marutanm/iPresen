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

- (NSMutableArray *)parseXMLFileByName:(NSString *)file parseError:(NSError **)error{
    array = [NSMutableArray array];
    NSURL *url;
    NSBundle *bundle = [NSBundle mainBundle];
    if (bundle) {
        NSString *localFilePath = [bundle pathForResource:file ofType:@"xml"];
        if (localFilePath) {
            url = [NSURL fileURLWithPath:localFilePath];
        }
    }
    [self parseXMLFileAtURL:url parseError:&error];
    NSLog(@"result array: %@", array);
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
      [array addObject:[NSMutableDictionary dictionary]];
    } else if ([elementName isEqualToString:@"content"]) {
        NSLog(@"*****%@", [[array lastObject] class]);
        if (![[array lastObject] objectForKey:elementName]) {
            [[array lastObject] setObject:[NSMutableArray array] forKey:elementName];
        }
    }
    currentKey = elementName;
    NSLog(@"start: %@", elementName);
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (qName) {
        elementName = qName;
    }
    NSLog(@"end: %@", currentKey);
    currentKey = nil;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([currentKey isEqualToString:@"title"]) {
        [[array lastObject] setValue:string forKey:currentKey];
    } else if ([currentKey isEqualToString:@"content"]){
        NSLog(@"%@", [[array lastObject] objectForKey:currentKey]);
        NSLog(@"%@:%@", currentKey, string);
        [[[array lastObject] objectForKey:currentKey] addObject:string];
    } else {
    }
}

@end
