//
//  Neighbour.m
//  e-Sandik
//
//  Created by Alperen Kavun on 09.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "Neighbour.h"

@implementation Neighbour

- (id) initWithName:(NSString *)name doorNumber:(NSString *)doorNumber {
    
    if(self = [super init]) {
        _name = name;
        _doorNumber = doorNumber;
        
        return self;
    }
    return nil;
}

@end
