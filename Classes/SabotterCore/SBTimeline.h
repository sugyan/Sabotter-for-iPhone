#import <Foundation/Foundation.h>

#import "SBStatus.h"


typedef enum {
    TIMELINE_FRIENDS,
    TIMELINE_REPLY,
    TIMELINE_USER,
} TimelineType;

@interface SBTimeline : NSObject {
    TimelineType type;
    NSMutableArray *statuses;
}

- (id)initWithType:(TimelineType)_type;
- (SBStatus *)statusWithId:(NSString *)ID forService:(SBService)service;
- (void)update;
- (NSArray *)statuses;

@end
