//
//  Common.h
//  Sabotter
//
//  Created by sugyan on 10/08/17.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
#  define LOG(...) NSLog(__VA_ARGS__)
#  define LOG_CURRENT_METHOD NSLog(@"%@/%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd))
#else
#  define LOG(...) ;
#  define LOG_CURRENT_METHOD ;
#endif

#define NOTIFICATION_AUTHENTICATED @"NOTIFICATION_AUTHENTICATED"
#define USERDEFAULTS_TWITTER_USERNAME            @"TWITTER_USERNAME"
#define USERDEFAULTS_TWITTER_ACCESS_TOKEN        @"TWITTER_ACCESSTOKEN"
#define USERDEFAULTS_TWITTER_ACCESS_TOKEN_SECRET @"TWITTER_ACCESSTOKEN_SECRET"
#define USERDEFAULTS_WASSR_USERNAME              @"WASSR_USERNAME"
#define USERDEFAULTS_WASSR_PASSWORD              @"WASSR_PASSWORD"

typedef enum {
    SERVICE_TWITTER,
    SERVICE_WASSR,
} SBService;
