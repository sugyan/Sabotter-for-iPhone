//
//  SBStatus.m
//  Sabotter
//
//  Created by sugyan on 10/08/31.
//

#import "SBStatus.h"
#import "Common.h"
#import "HttpClient.h"


@implementation SBStatus

@synthesize text;
@synthesize user;
@synthesize date;
@synthesize iconUrl;
@synthesize iconImage;

// TODO: statusそれぞれが画像データを持つべきではない
- (void)getImageWithCallback:(void (^)(void))callback {
    LOG_CURRENT_METHOD;

    if (loading) {
        return;
    }

    loading = YES;
    NSURL *url = [NSURL URLWithString:self.iconUrl];
    void (^onSuccess)(NSData *) = ^(NSData *data) {
        loading = NO;
        self.iconImage = [UIImage imageWithData:data];
        callback();
    };
    void (^onError)(NSError *) = ^(NSError *error) {
        loading = NO;
    };
    [HttpClient get:url success:onSuccess error:onError];
}

@end
