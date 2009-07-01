#import "SBTimeline.h"
#import "SBCommon.h"
#import "SBHttpClient.h"
#import "SBTwitterApiUrl.h"
#import "SBTwitterXmlParser.h"
#import "SBWassrApiUrl.h"
#import "SBWassrXmlParser.h"


@implementation SBTimeline

- (id)initWithType:(TimelineType)_type {
    if (self = [super init]) {
        type = _type;
        statuses = [[NSMutableArray alloc] initWithCapacity:50];
    }

    return self;
}

- (void)update {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    NSURL *twitter_url, *wassr_url;
    switch (type) {
    case TIMELINE_FRIENDS:
        twitter_url = [SBTwitterApiUrl friends_timeline];
        wassr_url = [SBWassrApiUrl friends_timeline];
        break;
    case TIMELINE_REPLY:
        twitter_url = [SBTwitterApiUrl reply_timeline];
        wassr_url = [SBWassrApiUrl reply_timeline];
        break;
    case TIMELINE_USER:
        twitter_url = [SBTwitterApiUrl user_timeline];
        wassr_url = [SBWassrApiUrl user_timeline];
        break;
    default:
        break;
    }
    
    /* Twitter */
    if ([defaults boolForKey:USERDEFAULTS_TWITTER_ENABLE]) {
        SBHttpClient *twitter = [[[SBHttpClient alloc]
                                     initWithTarget:self
                                     withAction:@selector(twitterClient:didFinishLoading:)] autorelease];
        [twitter getWithAuthentication:twitter_url
                 username:[defaults stringForKey:USERDEFAULTS_TWITTER_USERNAME]
                 password:[defaults stringForKey:USERDEFAULTS_TWITTER_PASSWORD]];
    }
        
    /* Wassr */
    if ([defaults boolForKey:USERDEFAULTS_WASSR_ENABLE]) {
        SBHttpClient *wassr = [[[SBHttpClient alloc]
                                   initWithTarget:self
                                   withAction:@selector(wassrClient:didFinishLoading:)] autorelease];
        [wassr getWithAuthentication:wassr_url
               username:[defaults stringForKey:USERDEFAULTS_WASSR_USERNAME]
               password:[defaults stringForKey:USERDEFAULTS_WASSR_PASSWORD]];
    }
}

- (SBStatus *)statusWithId:(NSString *)ID forService:(SBService)service {
    for (SBStatus *status in statuses) {
        if (([status service] == service) && [[status Id] isEqualToString:ID]) {
            return status;
        }
    }

    return nil;
}

- (void)twitterClient:(id)sender didFinishLoading:(NSData *)data {
//     NSLog(@"twitterClient:didFinishLoading:");
    SBTwitterXmlParser *parser = [[[SBTwitterXmlParser alloc]
                                      initWithData:data
                                      withTarget:self
                                      withAction:@selector(parser:didFinishParse:)] autorelease];
    [parser parse];
}

- (void)wassrClient:(id)sender didFinishLoading:(NSData *)data {
//     NSLog(@"wassrClient:didFinishLoading:");
    SBWassrXmlParser *parser = [[[SBWassrXmlParser alloc]
                                    initWithData:data
                                    withTarget:self
                                    withAction:@selector(parser:didFinishParse:)] autorelease];
    [parser parse];
}

- (void)parser:(id)sender didFinishParse:(NSArray *)array {
//     NSLog(@"parser:didFinishParse:");
    for (SBStatus *status in array) {
        if (![statuses containsObject:status]) {
            [statuses addObject:status];
        }
    }
    [statuses sortUsingSelector:@selector(compare:)];

    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_TIMELINE_DATA_UPDATE object:self];
}

- (NSArray *)statuses {
    return statuses;
}

- (void)dealloc {
    [statuses release];
    [super dealloc];
}

@end
