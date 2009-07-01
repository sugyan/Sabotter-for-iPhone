#import "SBWassrApiUrl.h"


@implementation SBWassrApiUrl

+ (NSURL *)friends_timeline {
    return [NSURL URLWithString:@"http://api.wassr.jp/statuses/friends_timeline.xml"];
}

+ (NSURL *)reply_timeline {
    return [NSURL URLWithString:@"http://api.wassr.jp/statuses/replies.xml"];
}

+ (NSURL *)user_timeline {
    return [NSURL URLWithString:@"http://api.wassr.jp/statuses/user_timeline.xml"];
}

+ (NSString *)favorite {
    return @"http://api.wassr.jp/favorites/";
}

@end
