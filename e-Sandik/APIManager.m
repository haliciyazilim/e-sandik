//
//  APIManager.m
//  e-Sandik
//
//  Created by Eren Halici on 08.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "APIManager.h"
#import "Voter.h"
#import "Neighbour.h"

@implementation APIManager

static APIManager *sharedInstance = nil;

#pragma mark - Singleton and init methods

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;
        }
    }
    
    return nil;
}

- (id)init
{
    NSMutableDictionary *headerFields = [NSMutableDictionary dictionary];
    [headerFields setValue:@"iOS" forKey:@"x-client-identifier"];
    

    self = [super init];
    
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+ (APIManager *)sharedInstance
{
    @synchronized (self) {
        if (sharedInstance == nil) {
            sharedInstance = [[self alloc] init];
        }
    }
    
    return sharedInstance;
}

#pragma mark -

- (void)getVoterWithTckNo:(int)tckNo
             onCompletion:(VoterBlock)completionBlock
                  onError:(ErrorBlock)errorBlock {
    
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        completionBlock([[Voter alloc] initWithName:@"Eren"
                                             school:@"ODTU"
                                           province:@"Ankara"
                                              chest:@"112"
                                         chestIndex:@"115"
                                  fellowsInBuilding:@[  [Neighbour neighbourWithName:@"Alperen Kavun" doorNumber:@"10"],
                                                        [Neighbour neighbourWithName:@"Yunus Eren Güzel" doorNumber:@"13"],
                                                        [Neighbour neighbourWithName:@"Abdullah Karacabey" doorNumber:@"17"],
                                                        [Neighbour neighbourWithName:@"Ebuzer Egemen Dursun" doorNumber:@"1"]]
                                     fellowsInChest:@[  [Neighbour neighbourWithName:@"Alperen Kavun" doorNumber:@"10"],
                                                        [Neighbour neighbourWithName:@"Yunus Eren Güzel" doorNumber:@"13"],
                                                        [Neighbour neighbourWithName:@"Abdullah Karacabey" doorNumber:@"17"],
                                                        [Neighbour neighbourWithName:@"Ebuzer Egemen Dursun" doorNumber:@"1"],
                                                        [Neighbour neighbourWithName:@"Nihal Sandıkçı" doorNumber:@"10"],
                                                        [Neighbour neighbourWithName:@"Hakan Özcan" doorNumber:@"13"],
                                                        [Neighbour neighbourWithName:@"Meral Ayduğan" doorNumber:@"17"]]]);
    });
}

@end
