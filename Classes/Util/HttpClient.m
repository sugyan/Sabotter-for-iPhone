//
//  HttpClient.m
//  Sabotter
//
//  Created by sugyan on 10/08/15.
//

#import "HttpClient.h"


@implementation HttpClient

+ (void)get:(NSURL *)url success:(void (^)(NSData *))callback_ok error:(void (^)(NSError *))callback_ng {
    NSURLRequest  *request  = [NSURLRequest requestWithURL:url];
    NSURLResponse *response = nil;
    NSError       *error    = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    if (error) {
        callback_ng(error);
    } else {
        callback_ok(data);
    }
}

@end
