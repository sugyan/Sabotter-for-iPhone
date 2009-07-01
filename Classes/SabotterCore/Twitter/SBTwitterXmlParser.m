#import "SBTwitterXmlParser.h"
#import "SBHttpUtil.h"
#import "SBStatus.h"

#define TAG_STATUS @"status"
#define TAG_USER   @"user"

#define TAG_USER_LOGIN_ID    @"screen_name"
#define TAG_USER_SCREEN_NAME @"name"
#define TAG_USER_IMAGE       @"profile_image_url"
#define TAG_TEXT             @"text"
#define TAG_DATE             @"created_at"
#define TAG_REPLY_ID         @"in_reply_to_screen_name"
#define TAG_ID               @"id"
#define TAG_FAVORITED        @"favorited"

@implementation SBTwitterXmlParser

/*
  Override
 */

- (id)initWithData:(NSData *)data withTarget:(id)_target withAction:(SEL)_action {
    if (self = [super initWithData:data withTarget:_target withAction:_action]) {
        str         = [[[NSMutableString alloc] initWithCapacity:100] autorelease];
        statusDict  = [[[NSMutableDictionary alloc] initWithCapacity:20] autorelease];
        userDict    = [[[NSMutableDictionary alloc] initWithCapacity:20] autorelease];
        statusArray = [[[NSMutableArray alloc] initWithCapacity:20] autorelease];
    }

    return self;
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    isInStatusTag = NO;
    isInUserTag = NO;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if ([target respondsToSelector:action]) {
        [target performSelector:action withObject:self withObject:statusArray];
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:TAG_STATUS]) {
        isInStatusTag = YES;
        [statusDict removeAllObjects];
    } else if ([elementName isEqualToString:TAG_USER]) {
        isInUserTag = YES;
        [userDict removeAllObjects];
    }

    NSRange range = { 0, [str length] };
    [str deleteCharactersInRange:range];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:TAG_STATUS]) {
        isInStatusTag = NO;
        SBStatus *status = [[[SBStatus alloc] init] autorelease];
        [status setService:SERVICE_TWITTER];
        [status setId:[statusDict objectForKey:TAG_ID]];
        [status setText:[SBHttpUtil unescapedStringWithHtml:[statusDict objectForKey:TAG_TEXT]]];
        NSDictionary *userInfo = [statusDict objectForKey:TAG_USER];
        {
            [status setLoginId:[userInfo objectForKey:TAG_USER_LOGIN_ID]];
            [status setScreenName:[SBHttpUtil unescapedStringWithHtml:[userInfo objectForKey:TAG_USER_SCREEN_NAME]]];
            [status setIconUrl:[userInfo objectForKey:TAG_USER_IMAGE]];
        }
        struct tm time;
        strptime([[statusDict objectForKey:TAG_DATE] UTF8String],
                 "%a %b %d %H:%M:%S %z %Y",
                 &time);
        [status setDateTime:[NSDate dateWithTimeIntervalSince1970:mktime(&time)]];
        [status setReplyId:[statusDict objectForKey:TAG_REPLY_ID]];
        if ([[statusDict objectForKey:TAG_FAVORITED] isEqualToString:@"true"]) {
            [status setFavorited:YES];
        }
        [statusArray addObject:status];
    } else if ([elementName isEqualToString:TAG_USER]) {
        isInUserTag = NO;
        [statusDict setObject:userDict forKey:elementName];
    } else {
        if (isInUserTag) {
            [userDict setObject:[NSString stringWithString:str] forKey:elementName];
        } else if (isInStatusTag) {
            [statusDict setObject:[NSString stringWithString:str] forKey:elementName];
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [str appendString:string];
}

@end
