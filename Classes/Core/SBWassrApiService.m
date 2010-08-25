//
//  SBWassrApiService.m
//  Sabotter
//
//  Created by sugyan on 10/08/17.
//

#import "SBWassrApiService.h"
#import "HttpClient.h"
#import "NSData+Base64.h"


@implementation SBWassrApiService

+ (void)authenticateWithUsername:(NSString *)username password:(NSString *)password callback:(void (^)(BOOL))callback {
    LOG_CURRENT_METHOD;
    NSURL *url = [NSURL URLWithString:@"http://api.wassr.jp/statuses/show.json"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *base64 = [[[NSString stringWithFormat:@"%@:%@", username, password] dataUsingEncoding:NSUTF8StringEncoding] base64EncodedString];
    [request setValue:[NSString stringWithFormat:@"Basic %@", base64] forHTTPHeaderField:@"Authorization"];

    void (^onSuccess)(NSData *) = ^(NSData *data) {
        LOG_CURRENT_METHOD;
        LOG(@"success");
        // Store ... plistに書き込まれるまで遅延あり？ simulatorだけだろうか
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:username forKey:USERDEFAULTS_WASSR_USERNAME];
        [defaults setObject:password forKey:USERDEFAULTS_WASSR_PASSWORD];
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
