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
#import "OAuth+Additions.h"


@implementation SBTwitterApiService

+ (void)authenticateWithUsername:(NSString *)username password:(NSString *)password callback:(void (^)(BOOL))callback {
    LOG_CURRENT_METHOD;
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
        LOG_CURRENT_METHOD;
        LOG(@"success");
        NSDictionary *result = [NSURL ab_parseURLQueryString:[[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease]];
        // Store ... plistに書き込まれるまで遅延あり？ simulatorだけだろうか
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:username forKey:USERDEFAULTS_TWITTER_USERNAME];
        [defaults setObject:[result objectForKey:@"oauth_token"]        forKey:USERDEFAULTS_TWITTER_ACCESS_TOKEN];
        [defaults setObject:[result objectForKey:@"oauth_token_secret"] forKey:USERDEFAULTS_TWITTER_ACCESS_TOKEN_SECRET];
        // Notify
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_AUTHENTICATED
                                                            object:self
                                                          userInfo:nil];
        callback(YES);
    };
    void (^onError)(NSError *) = ^(NSError *error) {
        LOG_CURRENT_METHOD;
        LOG(@"error: %@", error);
        callback(NO);
    };
    [HttpClient request:request success:onSuccess error:onError];
}

@end
