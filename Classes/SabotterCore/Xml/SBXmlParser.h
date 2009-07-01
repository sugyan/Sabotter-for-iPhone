#import <Foundation/Foundation.h>


@interface SBXmlParser : NSXMLParser {
    id target;
    SEL action;
}

- (id)initWithData:(NSData *)data withTarget:(id)_target withAction:(SEL)_action;

@end
