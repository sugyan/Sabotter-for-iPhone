#import "SBIconRepository.h"


static id instance = nil;

@implementation SBIconRepository

+ (id)instance {
    @synchronized(self) {
        if (!instance) {
            instance = [[self alloc] init];
        }
    }
    
    return instance;    
}

- (id)init {
    if (self = [super init]) {
        // initCapacityは幾つが適切？
        containers = [[NSMutableDictionary alloc] initWithCapacity:40];
    }

    return self;
}

- (void)dealloc {
    [containers release];
    [super dealloc];
}

- (SBIconContainer *)containerForUrl:(NSString *)url {
    SBIconContainer *container = [containers valueForKey:url];
    if (!container) {
        container = [[[SBIconContainer alloc] initWithUrl:url] autorelease];
        [containers setObject:container forKey:url];
    }
    
    return container;
}

/*
  Override
*/

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
