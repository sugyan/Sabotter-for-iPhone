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

typedef enum {
    SERVICE_TWITTER,
    SERVICE_WASSR,
} SBService;
