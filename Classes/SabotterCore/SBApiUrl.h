#import <Foundation/Foundation.h>


@protocol SBApiUrlProtocol

+ (NSURL *)friends_timeline;
+ (NSURL *)reply_timeline;
+ (NSURL *)user_timeline;

+ (NSString *)favorite;

@end
