#import <Foundation/Foundation.h>


@interface SBHttpClient : NSObject {
    NSMutableURLRequest *request;

    NSMutableData *receivedData;
    BOOL isConnecting;

    id target;
    SEL action;
}

- (id)initWithTarget:(id)_target withAction:(SEL)_action;
- (BOOL)get;
- (BOOL)get:(NSURL *)url;
- (BOOL)getWithAuthentication:(NSURL *)url username:(NSString *)user password:(NSString *)pass;
- (BOOL)postWithAuthentication:(NSURL *)url username:(NSString *)user password:(NSString *)pass data:(NSData *)data;

@property (retain, nonatomic) NSMutableURLRequest *request;

@end
