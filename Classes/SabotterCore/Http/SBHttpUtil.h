#import <Foundation/Foundation.h>


@interface SBHttpUtil : NSObject {

}

+ (NSString *)encodedStringWithBase64:(NSString *)arg;
+ (NSString *)unescapedStringWithHtml:(NSString *)arg;

@end
