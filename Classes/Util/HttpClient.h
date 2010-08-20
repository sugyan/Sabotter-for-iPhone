//
//  HttpClient.h
//  Sabotter
//
//  Created by sugyan on 10/08/15.
//

#import <Foundation/Foundation.h>


@interface HttpClient : NSObject {

}

+ (void)get:(NSURL *)url success:(void (^)(NSData *))onSuccess error:(void (^)(NSError *))onError;
+ (void)request:(NSURLRequest *)request success:(void (^)(NSData *))onSuccess error:(void (^)(NSError *))onError;

@end
