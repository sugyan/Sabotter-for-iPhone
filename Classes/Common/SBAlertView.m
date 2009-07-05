#import "SBAlertView.h"


static id instance = nil;

@implementation SBAlertView

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
        isShowing = NO;
    }

    return self;
}

- (void)show:(NSString *)title withMessage:(NSString *)message {
    if (!isShowing) {
        isShowing = YES;
        UIAlertView *alertView = [[[UIAlertView alloc]
                                      initWithTitle:title
                                      message:message
                                      delegate:self
                                      cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                      otherButtonTitles:nil] autorelease];
        [alertView show];
    }
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
