//
//  SBApi.m
//  Sabotter
//
//  Created by sugyan on 10/08/17.
//

#import "SBApi.h"
#import "SBTwitterApiService.h"
#import "SBWassrApiService.h"


@implementation SBApi

+ (Class <SBApiProtocol>)classForService:(SBService)service {
    switch (service) {
    case SERVICE_TWITTER:
        return [SBTwitterApiService class];
        break;
    case SERVICE_WASSR:
        return [SBWassrApiService class];
        break;
    default:
        break;
    }
    return [NSObject class];
}

+ (void)authenticate:(SBService)service username:(NSString *)username password:(NSString *)password callback:(void (^)(BOOL))callback {
    [[SBApi classForService:service] authenticateWithUsername:username password:password callback:callback];
}

@end
