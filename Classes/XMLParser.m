//
//  XMLParser.m
//  iPresen
//
//  Created by marutanm on 3/28/10.
//  Copyright 2010 shisobu.in. All rights reserved.
//

#import "XMLParser.h"


@implementation XMLParser

- (id) initWithXMLString:(NSString*)string{
//     if (self = [super init]) {
//         parser = [[NSXMLParser alloc] initWithData:[string dataUsingEncoding:NSUTF8StringEncoding]];
//         [parser setDelegate:self];
//         [parser parse];
//     }
//     return self;
}

- (void) dealloc{
    NSLog(@"dealloc");
    [parser release];
    [super dealloc];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"start parse XML");
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
        // NSLog(@"title is %@ , content is %@", [attributeDict objectForKey:@"title"], [attributeDict objectForKey:@"content"]);
    }
    NSLog(@"%@ start", elementName);
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (qName) {
        elementName = qName;
    }
    NSLog(@"%@ end", elementName);
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    NSLog(@"%@", string);
}

@end
