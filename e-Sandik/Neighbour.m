//
//  Neighbour.m
//  e-Sandik
//
//  Created by Alperen Kavun on 09.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "Neighbour.h"

@implementation Neighbour

+ (id) neighbourFromDictionary:(NSDictionary *)aDictionary {
    return [[Neighbour alloc] initWithDictionary:aDictionary];
}

+ (id) neighbourWithName:(NSString *)name
              doorNumber:(NSString *)doorNumber {
    return [[Neighbour alloc] initWithName:name
                                doorNumber:doorNumber];
}

- (id) initWithDictionary:(NSDictionary *)aDictionary {
    if(self = [super init]) {
        _name = [NSString stringWithFormat:@"%@ %@", [aDictionary objectForKey:@"Ad"], [aDictionary objectForKey:@"Soyad"]];
        _doorNumber = [NSString stringWithFormat:@"%@", [aDictionary objectForKey:@"DaireNo"]];
        
        return self;
    }
    return nil;
}

- (id) initWithName:(NSString *)name doorNumber:(NSString *)doorNumber {
    
    if(self = [super init]) {
        _name = name;
        _doorNumber = doorNumber;
        
        return self;
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone {
    return [[Neighbour allocWithZone:zone] initWithName:self.name
                                             doorNumber:self.doorNumber];
}

@end
