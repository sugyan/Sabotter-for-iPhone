#import "SBIconContainer.h"
#import "SBCommon.h"
#import "SBHttpClient.h"


@implementation SBIconContainer

@synthesize image;

- (id)initWithUrl:(NSString *)_url {
    if (self = [super init]) {
        image = nil;
        url = [[NSString alloc] initWithString:_url];
        isLoading = NO;
    }

    return self;
}

- (UIImage *)image {
    if (image) {
        return image;
    }

    if (!isLoading) {
        isLoading = YES;
        SBHttpClient *client = [[[SBHttpClient alloc] initWithTarget:self withAction:@selector(action:withData:)] autorelease];
        [client get:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    }
        
    return nil;
}

- (void)action:(id)sender withData:(NSData *)data {
    [self setImage:[UIImage imageWithData:data]];
    isLoading = NO;

    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_TIMELINE_DATA_UPDATE object:self];
}

- (void)dealloc {
    [url release];
    [super dealloc];
}

@end
