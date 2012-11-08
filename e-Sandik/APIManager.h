//
//  APIManager.h
//  e-Sandik
//
//  Created by Eren Halici on 08.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Voter.h"

typedef void (^VoterBlock) (Voter *voter);
typedef void (^ErrorBlock) (NSError *error);

@interface APIManager : NSObject

+ (APIManager *)sharedInstance;

- (void)getVoterWithTckNo:(int)tckNo
             onCompletion:(VoterBlock)completionBlock
                  onError:(ErrorBlock)errorBlock;

@end
