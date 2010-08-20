//
//  SBTwitterApiService.m
//  Sabotter
//
//  Created by sugyan on 10/08/17.
//

#import "SBTwitterApiService.h"
#import "SBConfig.h"
#import "HttpClient.h"
#import "OAuthCore.h"


@implementation SBTwitterApiService

+ (void)authenticateWithUsername:(NSString *)username password:(NSString *)password callback:(void (^)(void))callback {
    SBConfig *config = [SBConfig instance];
    NSString *consumer_key    = config.twitter_consumer_key;
    NSString *consumer_secret = config.twitter_consumer_secret;
    NSURL    *url    = [NSURL URLWithString:@"https://api.twitter.com/oauth/access_token"];
    NSString *method = @"POST";
    NSData   *body   = [[NSString stringWithFormat:@"x_auth_username=%@&x_auth_password=%@&x_auth_mode=client_auth",
                                  username,
                                  password] dataUsingEncoding:NSUTF8StringEncoding];
    NSString *header = OAuthorizationHeader(url, method, body, consumer_key, consumer_secret, @"", @"");
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:method];
    [request setValue:header forHTTPHeaderField:@"Authorization"];
    [request setHTTPBody:body];
    void (^onSuccess)(NSData *) = ^(NSData *data) {
        NSLog(@"onSuccess: %@", [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease]);
        callback();
    };
    void (^onError)(NSError *) = ^(NSError *error) {
        NSLog(@"onError: %@", error);
        callback();
    };
    [HttpClient request:request success:onSuccess error:onError];
}

@end
