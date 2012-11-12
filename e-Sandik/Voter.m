//
//  Voter.m
//  e-Sandik
//
//  Created by Alperen Kavun on 08.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "Voter.h"

@implementation Voter

- (id) initWithName:(NSString *)name school:(NSString *)school province:(NSString *)province chest:(NSString *)chest chestIndex:(NSString *)chestIndex {
    
    if(self = [super init]) {
        _name = name;
        _school = school;
        _province = province;
        _chest = chest;
        _chestIndex = chestIndex;
        
        return self;
    }
    
    return nil;
}
- (id) initWithName:(NSString *)name school:(NSString *)school province:(NSString *)province chest:(NSString *)chest chestIndex:(NSString *)chestIndex fellowsInBuilding:(NSArray *)fellowsInBuilding fellowsInChest:(NSArray *)fellowsInChest {
    
    if(self = [super init]) {
        _name = name;
        _school = school;
        _province = province;
        _chest = chest;
        _chestIndex = chestIndex;
        _fellowsInBuilding = fellowsInBuilding;
        _fellowsInChest = fellowsInChest;
        
        return self;
    }
    
    return nil;
}

@end
