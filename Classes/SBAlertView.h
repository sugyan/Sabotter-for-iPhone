#import <Foundation/Foundation.h>


@interface SBAlertView : NSObject {
    BOOL isShowing;
}

+ (id)instance;
- (void)show:(NSString *)title withMessage:(NSString *)message;

@end
