//
//  SBStatus.h
//  Sabotter
//
//  Created by sugyan on 10/08/31.
//

#import <Foundation/Foundation.h>


@interface SBStatus : NSObject {
    NSString *text;
    NSString *user;
    NSDate   *date;
    NSString *iconUrl;
    UIImage  *iconImage;
    BOOL loading;
}

@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) NSString *user;
@property (nonatomic, retain) NSDate   *date;
@property (nonatomic, retain) NSString *iconUrl;
@property (nonatomic, retain) UIImage  *iconImage;

- (void)getImageWithCallback:(void (^)(void))callback;

@end
