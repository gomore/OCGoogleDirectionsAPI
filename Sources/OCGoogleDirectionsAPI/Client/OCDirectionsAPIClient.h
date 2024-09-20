//
//  OCDirectionsAPIClient.h
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/24/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../Request/OCDirectionsRequest.h"
#import "../Response/OCDirectionsResponse.h"
#import "RequestURLCreator/OCDirectionsRequestURLCreator.h"
#import "RequestURLCreator/OCDirectionsRequestURLCreatorJSON.h"

typedef NS_SWIFT_UI_ACTOR NS_SWIFT_SENDABLE void (^OCDirectionsRequestCallback)(OCDirectionsResponse *response, NSError *error);

@interface OCDirectionsAPIClient : NSObject

@property (nonatomic) id <OCDirectionsRequestURLCreator> requestURLCreator;

- (instancetype)init;

- (instancetype)initWithKey:(NSString *)key;

- (instancetype)initWithNoKeyUseHttps:(BOOL)useHttps;

- (instancetype)initWithKey:(NSString *)key useHttps:(BOOL)https;

+ (void)provideAPIKey:(NSString *)key;

/*
 Creates a `NSURLSessionDataTask` and resumes immediately.
 **/
- (void)directions:(OCDirectionsRequest *)request response:(OCDirectionsRequestCallback)callback;

/*
 Creates a `NSURLSessionDataTask` for a given `OCDirectionsRequest`.
 @return The `NSURLSessionDataTask` object initialised from the shared `NSURLSession`.
 It is your responsibility to resume this task.
 **/
- (NSURLSessionDataTask *)dataTaskWithRequest:(OCDirectionsRequest *)request response:(OCDirectionsRequestCallback)callback;

- (NSURL *)urlFromRequest:(OCDirectionsRequest *)request;

@end
