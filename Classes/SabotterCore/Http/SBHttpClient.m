#import "SBHttpClient.h"
#import "SBAlertView.h"
#import "SBCommon.h"
#import "SBHttpUtil.h"


@implementation SBHttpClient

@synthesize request;

- (id)initWithTarget:(id)_target withAction:(SEL)_action {
    if (self = [super init]) {
        target = _target;
        action = _action;
        request = [[NSMutableURLRequest alloc] initWithURL:nil
                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                               timeoutInterval:10.0];
    }

    return self;
}

- (BOOL)get:(NSURL *)url {
    [request setURL:url];
    return [self get];
}

- (BOOL)getWithAuthentication:(NSURL *)url username:(NSString *)user password:(NSString *)pass {
    [request setURL:url];
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", user, pass];
    NSString *authHeader = [NSString stringWithFormat:@"Basic %@", [SBHttpUtil encodedStringWithBase64:authStr]];
    [request setValue:authHeader forHTTPHeaderField:@"Authorization"];
    return [self get];
}

- (BOOL)get {
//     NSLog(@"request:%@", request);
    if (isConnecting) {
        return NO;
    }
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (connection) {
//         NSLog(@"connection start!");
        isConnecting = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_HTTP_CONNECTION_START object:self];
        receivedData = [[NSMutableData data] retain];
    } else {
//         NSLog(@"Connection init error!");
    }

    return YES;
}

- (BOOL)postWithAuthentication:(NSURL *)url username:(NSString *)user password:(NSString *)pass data:(NSData *)data {
    [request setURL:url];
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", user, pass];
    NSString *authHeader = [NSString stringWithFormat:@"Basic %@", [SBHttpUtil encodedStringWithBase64:authStr]];
    [request setValue:authHeader forHTTPHeaderField:@"Authorization"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    return [self get];
}

- (void)dealloc {
    [request release];
    [super dealloc];
}

/*
  Delegate Methods
*/

/*! 
    @method connection:willSendRequest:redirectResponse:   
    @abstract This method is called whenever an NSURLConnection
    determines that it must change URLs in order to continue loading a
    request.
    @discussion This method gives the delegate an opportunity to
    inspect the request that will be used to continue loading the
    request, and modify it if necessary. The URL-change determinations
    mentioned above can occur as a result of transforming a request
    URL to its canonical form, or can happen for protocol-specific
    reasons, such as an HTTP redirect. 
    <p>If the delegate wishes to reject the redirect, it can call
    <tt>[connection cancel]</tt>, or it can return nil from this
    method. There is one subtle difference which results from this
    choice. If <tt>[connection cancel]</tt> is called in the delegate
    method, all processing for the connection stops, and no futher
    delegate callbacks will be sent. If the delegate returns nil, the
    connection will continue to process, and this has special
    relevance in the case where the redirectResponse argument is
    non-nil. In this case, any data that is loaded for the connection
    will be sent to the delegate, and the delegate will receive a
    finshed or failure delegate callback as appropiate.
    @param connection an NSURLConnection that has determined that it
    must change URLs in order to continue loading a request.
    @param request The NSURLRequest object that will be used to
    continue loading. The delegate should copy and modify this request
    as necessary to change the attributes of the request, or can
    simply return the given request if the delegate determines that no
    changes need to be made.
    @param redirectResponse The NSURLResponse that caused this
    callback to be sent. This argument is nil in cases where this
    callback is not being sent as a result of involving the delegate
    in redirect processing.
    @result The request that the URL loading system will use to
    continue.
*/
- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)aRequest redirectResponse:(NSURLResponse *)response {
//     NSLog(@"willSendRequest");
    return aRequest;
}

/*!
    @method connection:didReceiveAuthenticationChallenge:
    @abstract Start authentication for a given challenge
    @discussion Call useCredential:forAuthenticationChallenge:,
    continueWithoutCredentialForAuthenticationChallenge: or cancelAuthenticationChallenge: on
    the challenge sender when done.
    @param connection the connection for which authentication is needed
    @param challenge The NSURLAuthenticationChallenge to start authentication for
*/
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
//     NSLog(@"didReceiveAuthenticationChallenge");
    // ここが呼び出されたときは自動的に失敗としてキャンセルする
    [[challenge sender] cancelAuthenticationChallenge:challenge];
    // inform the user that the user name and password
    // in the preferences are incorrect
}

/*!
    @method connection:didCancelAuthenticationChallenge:
    @abstract Cancel authentication for a given request
    @param connection the connection for which authentication was cancelled
    @param challenge The NSURLAuthenticationChallenge for which to cancel authentication
*/
- (void)connection:(NSURLConnection *)connection didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
//     NSLog(@"didCancelAuthenticationChallenge");
}

/*! 
    @method connection:didReceiveResponse:   
    @abstract This method is called when the URL loading system has
    received sufficient load data to construct a NSURLResponse object.
    @discussion The given NSURLResponse is immutable and
    will not be modified by the URL loading system once it is
    presented to the NSURLConnectionDelegate by this method.
    <p>See the category description for information regarding
    the contract associated with the delivery of this delegate 
    callback.
    @param connection an NSURLConnection instance for which the
    NSURLResponse is now available.
    @param response the NSURLResponse object for the given
    NSURLConnection.
*/
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
//     NSLog(@"didReceiveResponse");
}

/*! 
    @method connection:didReceiveData:   
    @abstract This method is called to deliver the content of a URL
    load.
    @discussion Load data is delivered incrementally. Clients can
    concatenate each successive NSData object delivered through this
    method over the course of an asynchronous load to build up the
    complete data for a URL load. It is also important to note that this
    method provides the only way for an ansynchronous delegate to find
    out about load data. In other words, it is the responsibility of the
    delegate to retain or copy this data as it is delivered through this
    method.
    <p>See the category description for information regarding
    the contract associated with the delivery of this delegate 
    callback.
    @param connection  NSURLConnection that has received data.
    @param data A chunk of URL load data.
*/
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
//     NSLog(@"didReceiveData");
    [receivedData appendData:data];
}

/*! 
    @method connectionDidFinishLoading:   
    @abstract This method is called when an NSURLConnection has
    finished loading successfully.
    @discussion See the category description for information regarding
    the contract associated with the delivery of this delegate
    callback.
    @param connection an NSURLConnection that has finished loading
    successfully.
*/
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
//     NSLog(@"connectionDidFinishLoading");
    [target performSelector:action withObject:self withObject:receivedData];
    [connection release];
    [receivedData release];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_HTTP_CONNECTION_END object:self];
    isConnecting = NO;
}

/*! 
    @method connection:didFailWithError:   
    @abstract This method is called when an NSURLConnection has
    failed to load successfully.
    @discussion See the category description for information regarding
    the contract associated with the delivery of this delegate
    callback.
    @param connection an NSURLConnection that has failed to load.
    @param error The error that encapsulates information about what
    caused the load to fail.
*/
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
//     NSLog(@"didFailWithError");
    [connection release];
    [receivedData release];

    [[SBAlertView instance]
        show:NSLocalizedString(@"Error", nil)
        withMessage:[error localizedDescription]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_HTTP_CONNECTION_END object:self];
    isConnecting = NO;
}

/*!
    @method connection:willCacheResponse:
    @abstract This method gives the delegate an opportunity to inspect
    the NSCachedURLResponse that will be stored in the cache, and modify
    it if necessary.
    @discussion See the category description for information regarding
    the contract associated with the delivery of this delegate
    callback.
    @param connection an NSURLConnection that has a NSCachedURLResponse
    ready for inspection.
    @result a NSCachedURLResponse that will be written to the cache. The
    delegate need not perform any customization and may return the
    NSCachedURLResponse passed to it. The delegate may replace the
    NSCachedURLResponse with a completely new one. The delegate may also
    return nil to indicate that no NSCachedURLResponse should be stored
    for this connection.
*/
- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
//     NSLog(@"willCacheResponse");
    return cachedResponse;
}

@end
