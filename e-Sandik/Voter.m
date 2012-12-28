//
//  Voter.m
//  e-Sandik
//
//  Created by Alperen Kavun on 08.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "Voter.h"
#import "Neighbour.h"

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
        NSArray *buildingArray = [aDictionary objectForKey:@"AyniBinadakiler"];
        NSArray *chestArray = [aDictionary objectForKey:@"AyniSandiktakiler"];
        
        _name = [NSString stringWithFormat:@"%@ %@", [kunyeDictionary objectForKey:@"Ad"], [kunyeDictionary objectForKey:@"Soyad"]];
        _province = [NSString stringWithFormat:@"%@ %@ %@", [kunyeDictionary objectForKey:@"Il"], [kunyeDictionary objectForKey:@"Ilce"], [kunyeDictionary objectForKey:@"Mahalle"]];
        _school = [kunyeDictionary objectForKey:@"SandikAlani"];
        _chest = [NSString stringWithFormat:@"%@", [kunyeDictionary objectForKey:@"SandikNo"]];
        _chestIndex = [NSString stringWithFormat:@"%@", [kunyeDictionary objectForKey:@"SandikSiraNo"]];
        if([aDictionary objectForKey:@"EskiListe"]){
            _isInformationsOld = [[aDictionary objectForKey:@"EskiListe"] boolValue];
        }
        else{
            _isInformationsOld = YES;
        }
        if([aDictionary objectForKey:@"SecimYili"]){
            _electionYear = [aDictionary objectForKey:@"SecimYili"];
        }
        else{
            _electionYear = @"2011";
        }
        
        
        
        NSMutableArray *fellowsInBuildingArray = [NSMutableArray array];
        
        for (NSDictionary *fellow in buildingArray) {
            [fellowsInBuildingArray addObject:[Neighbour neighbourFromDictionary:fellow]];
        }
        
        _fellowsInBuilding = fellowsInBuildingArray;
        
        
        
        NSMutableArray *fellowsInChestArray = [NSMutableArray array];
        
        for (NSDictionary *fellow in chestArray) {
            [fellowsInChestArray addObject:[Neighbour neighbourFromDictionary:fellow]];
        }
        
        _fellowsInChest = fellowsInChestArray;
        
        
        
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
