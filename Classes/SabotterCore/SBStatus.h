#import <Foundation/Foundation.h>


typedef enum {
    SERVICE_NONE,
    SERVICE_TWITTER,
    SERVICE_WASSR,
} SBService;
    
@interface SBStatus : NSObject {
    SBService service;
    NSString *Id;
    NSString *text;
    NSString *loginId;
    NSString *screenName;
    NSString *iconUrl;
    NSString *replyName;
    NSString *replyId;
    NSString *replyMessage;
    NSDate *dateTime;
    BOOL favorited;
}

@property (readwrite) SBService service;
@property (retain, nonatomic) NSString *Id;
@property (retain, nonatomic) NSString *text;
@property (retain, nonatomic) NSString *loginId;
@property (retain, nonatomic) NSString *screenName;
@property (retain, nonatomic) NSString *iconUrl;
@property (retain, nonatomic) NSString *replyName;
@property (retain, nonatomic) NSString *replyId;
@property (retain, nonatomic) NSString *replyMessage;
@property (retain, nonatomic) NSDate *dateTime;
@property (readwrite) BOOL favorited;

@end
