//
//  RestHelper.m
//  RestApi
//
//  Created by kita on 14-5-8.
//  Copyright (c) 2014年 kita. All rights reserved.
//

#import "RestHelper.h"
#import "DAConfigManager.h"

#define kHTTPHeaderCookieName   @"Set-Cookie"
#define kHTTPHeaderCsrftoken    @"csrftoken"

#define kHTTPCookie         @"jp.co.dreamarts.smart.sdk.cookie"
#define kHTTPCsrfToken      @"jp.co.dreamarts.smart.sdk.csrftoken"

@interface RestHelper () <UIWebViewDelegate>
@property RACSubject *authSignal;
@property NSString *authUrl;
@end

@implementation RestHelper

+ (RestHelper *)sharedInstance {
    static RestHelper *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [[RestHelper alloc] init];
        }
    });
    return instance;
}


+ (BOOL)hasLoginSession {
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSURL *url = [NSURL URLWithString:[RestHelper getServerAddress]];
    NSArray *cookieArray = [cookieStorage cookiesForURL:url];

    BOOL isLogin = NO;

    for (NSHTTPCookie *cookie in cookieArray) {
        if ([[[DAConfigManager defaults] stringForKey:@"API_Cookie"] isEqualToString:cookie.name] && cookie.value) {
            isLogin = YES;
        }
    }

    return isLogin;
}


#pragma mark - authorize
- (RACSignal *)authorize {
    UIWindow *window = UIApplication.sharedApplication.windows[0];
    UIView *view = [window.rootViewController view];
    return [self authorizeInView:view];
}

- (RACSignal *)authorizeWithUrl:(NSString *)path {
    self.authUrl = path;
    return self.authorize;
}

- (RACSignal *)authorizeInView:(UIView *)view {
    UIWebView *webview = [[UIWebView alloc] init];
    webview.delegate = self;
    [webview loadRequest:self.authorizeRequest];

    [view addSubview:webview];
    webview.frame = view.frame;

    self.authSignal = [RACSubject subject];
    return [self.authSignal finally:^{
        webview.delegate = nil;
        [webview removeFromSuperview];
    }];
}

- (NSURLRequest *)authorizeRequest {
    NSString *url = [[RestHelper getServerAddress] stringByAppendingString:self.authUrl];
    NSURLComponents *comp = [NSURLComponents componentsWithString:url];

    return [[NSURLRequest alloc] initWithURL:comp.URL];
}


#pragma mark - webView delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return TRUE;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.authSignal sendError:error];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {


    if ([[[RestHelper getServerAddress] stringByAppendingString:self.authUrl] isEqualToString:[NSString stringWithFormat:@"%@", webView.request.URL]]) {

        NSCachedURLResponse *resp = [[NSURLCache sharedURLCache] cachedResponseForRequest:webView.request];
        NSDictionary *headers = [(NSHTTPURLResponse *) resp.response allHeaderFields];

        NSString *cookie = [headers objectForKey:kHTTPHeaderCookieName];
        NSString *csrfToken = [headers objectForKey:kHTTPHeaderCsrftoken];

        //将session信息备份一份,以备不时之需
        if (cookie != nil) {
            [[DAConfigManager defaults] setObject:cookie forKey:kHTTPCookie];
        }
        if (csrfToken != nil) {
            [[DAConfigManager defaults] setObject:csrfToken forKey:kHTTPCsrfToken];
        }

        [self.authSignal sendCompleted];
    }
}

#pragma mark -

+ (NSString *)getServerAddress {
    NSString *protocal = [[DAConfigManager defaults] stringForKey:@"API_Scheme"];
    NSString *address = [RestHelper getServerHost];
    NSInteger port = [[DAConfigManager defaults] integerForKey:@"API_Port"];;


    NSString *url = [NSString stringWithFormat:@"%@://%@", protocal, address];
    if (port == 80) {
        return url;
    } else {
        return [url stringByAppendingFormat:@":%d", port];
    }

}

+ (NSString *)getServerHost {
    return [[DAConfigManager defaults] stringForKey:@"API_Host"];
}

@end
