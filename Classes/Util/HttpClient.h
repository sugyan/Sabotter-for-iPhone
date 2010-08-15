//
//  HttpClient.h
//  Sabotter
//
//  Created by sugyan on 10/08/15.
//

#import <Foundation/Foundation.h>


@interface HttpClient : NSObject {

}

+ (void)get:(NSURL *)url success:(void (^)(NSData *))callback_ok error:(void (^)(NSError *))callback_ng;

@end
