#import "SBTwitterApiUrl.h"


@implementation SBTwitterApiUrl

+ (NSURL *)friends_timeline {
    return [NSURL URLWithString:@"http://twitter.com/statuses/friends_timeline.xml"];
}

+ (NSURL *)reply_timeline {
    return [NSURL URLWithString:@"http://twitter.com/statuses/replies.xml"];
}

+ (NSURL *)user_timeline {
    return [NSURL URLWithString:@"http://twitter.com/statuses/user_timeline.xml"];
}

+ (NSString *)favorite {
    return @"http://twitter.com/favourings/";
}

@end
