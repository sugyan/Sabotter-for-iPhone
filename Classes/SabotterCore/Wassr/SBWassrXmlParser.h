#import <Foundation/Foundation.h>

#import "SBXmlParser.h"


@interface SBWassrXmlParser : SBXmlParser {
    NSMutableString *str;
    NSMutableDictionary *statusDict;
    NSMutableDictionary *userDict;
    NSMutableArray *statusArray;

    BOOL isInStatusTag;
    BOOL isInUserTag;
}

@end
