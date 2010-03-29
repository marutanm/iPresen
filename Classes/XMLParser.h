//
//  XMLParser.h
//  iPresen
//
//  Created by marutanm on 3/28/10.
//  Copyright 2010 shisobu.in. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XMLParser : NSObject {
	// NSXMLParser *parser;
    NSMutableArray *array;
    NSString *currentKey;
}

- (id) initWithXMLString:(NSString*)string;

@end
