//
//  APIManager.h
//  e-Sandik
//
//  Created by Eren Halici on 08.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKNetworkKit/MKNetworkEngine.h"

@class Voter;

typedef void (^VoterBlock) (Voter *voter);
typedef void (^ErrorBlock) (NSError *error);

@interface APIManager : MKNetworkEngine

+ (APIManager *)sharedInstance;

- (MKNetworkOperation *)getVoterWithTckNo:(NSString *)tckNo
                             onCompletion:(VoterBlock)completionBlock
                                  onError:(ErrorBlock)errorBlock;

@end
