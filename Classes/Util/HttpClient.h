//
//  HttpClient.h
//  Sabotter
//
//  Created by sugyan on 10/03/20.
//

#import <Foundation/Foundation.h>


@protocol HttpClientProtocol;

@interface HttpClient : NSObject {
    NSMutableData *receivedData;
    NSMutableString *username;
    NSMutableString *password;
    id <HttpClientProtocol> delegate;
}

@property (retain, nonatomic) id <HttpClientProtocol> delegate;

- (void)getWithCredential:(NSString *)urlStr username:(NSString *)user password:(NSString *)pass;

@end


@protocol HttpClientProtocol

- (void)client:(HttpClient *)client didFinishLoading:(NSData *)data;
- (void)client:(HttpClient *)client didFailWithError:(NSError *)error;

@end
