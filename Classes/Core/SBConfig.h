//
//  SBConfig.h
//  Sabotter
//
//  Created by sugyan on 10/08/20.
//

#import <Foundation/Foundation.h>


@interface SBConfig : NSObject {
    NSString *twitter_consumer_key;
    NSString *twitter_consumer_secret;
}

@property(readonly) NSString *twitter_consumer_key;
@property(readonly) NSString *twitter_consumer_secret;

+ (SBConfig *)instance;

@end
