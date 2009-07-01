#import <Foundation/Foundation.h>

#import "SBIconContainer.h"


@interface SBIconRepository : NSObject {
    NSMutableDictionary *containers;
}

+ (id)instance;
- (SBIconContainer *)containerForUrl:(NSString *)url;

@end
