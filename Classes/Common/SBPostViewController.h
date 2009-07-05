#import <UIKit/UIKit.h>

#import "SBHttpClient.h"
#import "SBStatus.h"


@interface SBPostViewController : UIViewController <UITextViewDelegate> {
    UISwitch *twitterSwitch;
    UISwitch *wassrSwitch;
    UITextView *textView;
    
    NSString *replyId;
    SBService service;
    BOOL onNavigation;
}

- (id)initOnNavigation:(BOOL)_onNavigation;
- (void)setReplyId:(NSString *)_replyId withService:(SBService)_service;
- (void)setReplyText:(NSString *)str;

@end


@protocol SBPostViewControllerDelegate

@required
- (void)postDidFinished:(SBHttpClient *)sender withData:(NSData *)data;

@end
