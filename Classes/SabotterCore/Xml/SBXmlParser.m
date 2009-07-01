#import "SBXmlParser.h"


@implementation SBXmlParser

- (id)initWithData:(NSData *)data withTarget:(id)_target withAction:(SEL)_action {
    if (self = [super initWithData:data]) {
        [self setDelegate:self];
        target = _target;
        action = _action;
    }

    return self;
}

/*
  Delegate Methods
 */

// Document handling methods
- (void)parserDidStartDocument:(NSXMLParser *)parser {
    // sent when the parser begins parsing of the document.
    NSLog(@"parserDidStartDocument");
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    // sent when the parser has completed parsing. If this is encountered, the parse was successful.
    NSLog(@"parserDidEndDocument:%@");
}

// DTD handling methods for various declarations.
- (void)parser:(NSXMLParser *)parser foundNotationDeclarationWithName:(NSString *)name publicID:(NSString *)publicID systemID:(NSString *)systemID {
    NSLog(@"foundNotationDeclarationWithName");
}

- (void)parser:(NSXMLParser *)parser foundUnparsedEntityDeclarationWithName:(NSString *)name publicID:(NSString *)publicID systemID:(NSString *)systemID notationName:(NSString *)notationName {
    NSLog(@"foundUnparsedEntityDeclarationWithName");
}

- (void)parser:(NSXMLParser *)parser foundAttributeDeclarationWithName:(NSString *)attributeName forElement:(NSString *)elementName type:(NSString *)type defaultValue:(NSString *)defaultValue {
    NSLog(@"foundAttributeDeclarationWithName");
}

- (void)parser:(NSXMLParser *)parser foundElementDeclarationWithName:(NSString *)elementName model:(NSString *)model {
    NSLog(@"foundElementDeclarationWithName");
}

- (void)parser:(NSXMLParser *)parser foundInternalEntityDeclarationWithName:(NSString *)name value:(NSString *)value {
    NSLog(@"foundInternalEntityDeclarationWithName");
}

- (void)parser:(NSXMLParser *)parser foundExternalEntityDeclarationWithName:(NSString *)name publicID:(NSString *)publicID systemID:(NSString *)systemID {
    NSLog(@"foundExternalEntityDeclarationWithName");
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    // sent when the parser finds an element start tag.
    // In the case of the cvslog tag, the following is what the delegate receives:
    //   elementName == cvslog, namespaceURI == http://xml.apple.com/cvslog, qualifiedName == cvslog
    // In the case of the radar tag, the following is what's passed in:
    //    elementName == radar, namespaceURI == http://xml.apple.com/radar, qualifiedName == radar:radar
    // If namespace processing >isn't< on, the xmlns:radar="http://xml.apple.com/radar" is returned as an attribute pair, the elementName is 'radar:radar' and there is no qualifiedName.
    NSLog(@"didStartElement");
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    // sent when an end tag is encountered. The various parameters are supplied as above.
    NSLog(@"didEndElement");
}

- (void)parser:(NSXMLParser *)parser didStartMappingPrefix:(NSString *)prefix toURI:(NSString *)namespaceURI {
    // sent when the parser first sees a namespace attribute.
    // In the case of the cvslog tag, before the didStartElement:, you'd get one of these with prefix == @"" and namespaceURI == @"http://xml.apple.com/cvslog" (i.e. the default namespace)
    // In the case of the radar:radar tag, before the didStartElement: you'd get one of these with prefix == @"radar" and namespaceURI == @"http://xml.apple.com/radar"
    NSLog(@"didStartMappingPrefix");
}

- (void)parser:(NSXMLParser *)parser didEndMappingPrefix:(NSString *)prefix {
    // sent when the namespace prefix in question goes out of scope.
    NSLog(@"didEndMappingPrefix");
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    // This returns the string of the characters encountered thus far. You may not necessarily get the longest character run. The parser reserves the right to hand these to the delegate as potentially many calls in a row to -parser:foundCharacters:
    NSLog(@"foundCharacters");
}

- (void)parser:(NSXMLParser *)parser foundIgnorableWhitespace:(NSString *)whitespaceString {
    // The parser reports ignorable whitespace in the same way as characters it's found.
    NSLog(@"foundIgnorableWhitespace");
}

- (void)parser:(NSXMLParser *)parser foundProcessingInstructionWithTarget:(NSString *)target data:(NSString *)data {
    // The parser reports a processing instruction to you using this method. In the case above, target == @"xml-stylesheet" and data == @"type='text/css' href='cvslog.css'"
    NSLog(@"foundProcessingInstructionWithTarget");
}

- (void)parser:(NSXMLParser *)parser foundComment:(NSString *)comment {
    // A comment (Text in a <!-- --> block) is reported to the delegate as a single string
    NSLog(@"foundComment");
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock {
    // this reports a CDATA block to the delegate as an NSData.
    NSLog(@"foundCDATA");
}

- (NSData *)parser:(NSXMLParser *)parser resolveExternalEntityName:(NSString *)name systemID:(NSString *)systemID {
    // this gives the delegate an opportunity to resolve an external entity itself and reply with the resulting data.
    NSLog(@"resolveExternalEntityName");
    return nil;
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    // ...and this reports a fatal error to the delegate. The parser will stop parsing.
    NSLog(@"parseErrorOccurred");
}

- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError {
    // If validation is on, this will report a fatal validation error to the delegate. The parser will stop parsing.
    NSLog(@"validationErrorOccurred");
}

@end
