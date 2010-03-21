//
//  HttpClient.m
//  Sabotter
//
//  Created by sugyan on 10/03/20.
//

#import "HttpClient.h"


@implementation HttpClient

@synthesize delegate;

- (id)init {
    if (self = [super init]) {
        username = [[NSMutableString alloc] initWithCapacity:0];
        password = [[NSMutableString alloc] initWithCapacity:0];
    }

    return self;
}

- (void)dealloc {
    [username release];
    [password release];
    if ([receivedData retainCount] > 0) {
        [receivedData release];
    }
    [super dealloc];
}

- (void)getWithCredential:(NSString *)urlStr username:(NSString *)user password:(NSString *)pass {
    NSLog(@"getWithCredential:username:password:");
    [username setString:user];
    [password setString:pass];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLConnection *connection = [[[NSURLConnection alloc]
                                       initWithRequest:request
                                              delegate:self] autorelease];
    if (connection) {
        receivedData = [[NSMutableData data] retain];
    }
}

- (void)connection:(NSURLConnection *)connection didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    NSLog(@"connection:didCancelAuthenticationChallenge:");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"connection:didFailWithError:");
    if ([self delegate]) {
        [[self delegate] client:self didFailWithError:error];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    NSLog(@"connection:didReceiveAuthenticationChallenge:");
    if ([challenge proposedCredential]) {
        [connection cancel];
    } else {
        NSURLCredential *credential = [NSURLCredential credentialWithUser:username password:password persistence:NSURLCredentialPersistenceNone];
        [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"connection:didReceiveData:");
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"connection:didReceiveResponse:");
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    NSLog(@"connection:willCacheResponse:");
    return cachedResponse;
}

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse {
    NSLog(@"connection:willSendRequest:");
    return request;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    if ([self delegate]) {
        [[self delegate] client:self didFinishLoading:receivedData];
    }
}

@end
