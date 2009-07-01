#import <UIKit/UIKit.h>

#import "SBTimeline.h"


@interface SBTimelineViewController : UITableViewController {
    SBTimeline *timeline;
}

- (id)initWithType:(TimelineType)type withUpdate:(BOOL)update;

@end
