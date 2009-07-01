#import <Foundation/Foundation.h>


@interface SBIconContainer : NSObject {
    UIImage *image;
    NSString *url;
    BOOL isLoading;
}

- (id)initWithUrl:(NSString *)_url;
- (UIImage *)image;

@property (retain, nonatomic) UIImage *image;

@end
