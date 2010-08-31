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
}

@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) NSString *user;

@end
