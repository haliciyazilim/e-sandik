//
//  Voter.m
//  e-Sandik
//
//  Created by Alperen Kavun on 08.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "Voter.h"

@implementation Voter

+ (id) voterFromDictionary:(NSDictionary *)aDictionary {
    return [[Voter alloc] initFromDictionary:aDictionary];
}

+ (id) voterWithName:(NSString *)name
             school:(NSString *)school
           province:(NSString *)province
              chest:(NSString *)chest
         chestIndex:(NSString *)chestIndex {
    return [[Voter alloc] initWithName:name
                                school:school
                              province:province
                                 chest:chest
                            chestIndex:chestIndex];
}

+ (id) voterWithName:(NSString *)name
              school:(NSString *)school
            province:(NSString *)province
               chest:(NSString *)chest
          chestIndex:(NSString *)chestIndex
   fellowsInBuilding:(NSArray *)fellowsInBuilding
      fellowsInChest:(NSArray *)fellowsInChest {
    return [[Voter alloc] initWithName:name
                                school:school
                              province:province
                                 chest:chest
                            chestIndex:chestIndex
                     fellowsInBuilding:fellowsInBuilding
                        fellowsInChest:fellowsInChest];
}

- (id) initFromDictionary:(NSDictionary *)aDictionary {
    if(self = [super init]) {
        
        NSDictionary *kunyeDictionary = [aDictionary objectForKey:@"KisiBilgisi"];
        _name = [NSString stringWithFormat:@"%@ %@", [kunyeDictionary objectForKey:@"Ad"], [kunyeDictionary objectForKey:@"Soyad"]];
        _school = [NSString stringWithFormat:@"%@ %@ %@", [kunyeDictionary objectForKey:@"Il"], [kunyeDictionary objectForKey:@"Ilce"], [kunyeDictionary objectForKey:@"Mahalle"]];
        _province = [kunyeDictionary objectForKey:@"SandikAlani"];
        _chest = [kunyeDictionary objectForKey:@"SandikNo"];
        _chestIndex = [kunyeDictionary objectForKey:@"SandikSiraNo"];
        
        return self;
    }
    
    return nil;
}

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
