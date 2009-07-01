#import <UIKit/UIKit.h>

#import "SBStatus.h"


@interface SBStatusViewController : UITableViewController {
    SBStatus *status;
    UILabel *textLabel;
    UILabel *replyLabel;
    NSMutableArray *actions;
}

- (id)initWithStatus:(SBStatus *)_status;
- (void)changeFavorited:(BOOL)favorited;

@end
