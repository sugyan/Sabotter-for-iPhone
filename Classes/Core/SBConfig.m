//
//  SBConfig.m
//  Sabotter
//
//  Created by sugyan on 10/08/20.
//

#import "SBConfig.h"

static SBConfig *instance = nil;


@implementation SBConfig

@synthesize twitter_consumer_key;
@synthesize twitter_consumer_secret;

+ (SBConfig *)instance {
    @synchronized(self) {
        if (! instance) {
            instance = [[self alloc] init];
        }
    }

    return instance;
}

- (id)init {
    if (self = [super init]) {
        NSDictionary *configDict =
            [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"config" ofType:@"plist"]];
        twitter_consumer_key    = [[configDict objectForKey:@"twitter_consumer_key"]    retain];
        twitter_consumer_secret = [[configDict objectForKey:@"twitter_consumer_secret"] retain];
    }

    return self;
}

- (void)dealloc {
    [twitter_consumer_key    release];
    [twitter_consumer_secret release];
    [super dealloc];
}


/* Override */

+ (id)allocWithZone:(NSZone*)zone {
    @synchronized(self) {
        if (!instance) {
            instance = [super allocWithZone:zone];
            return instance;
        }
    }

    return nil;
}

- (id)copyWithZone:(NSZone*)zone {
    return self;
}

- (id)retain {
    return self;
}

- (unsigned)retainCount {
    return UINT_MAX;
}

- (void)release {
}

- (id)autorelease {
    return self;
}


@end
