//
//  SBApi.h
//  Sabotter
//
//  Created by sugyan on 10/08/17.
//

#import <Foundation/Foundation.h>
#import "Common.h"


@protocol SBApiProtocol

@required
+ (void)authenticateWithUsername:(NSString *)username password:(NSString *)password callback:(void (^)(void))callback;

@end


@interface SBApi : NSObject {
}

+ (Class <SBApiProtocol>)classForService:(SBService)service;
+ (void)authenticate:(SBService)service username:(NSString *)username password:(NSString *)password callback:(void (^)(void))callback;

@end
