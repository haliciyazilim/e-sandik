//
//  Voter.h
//  e-Sandik
//
//  Created by Alperen Kavun on 08.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Voter : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *school;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *chest;
@property (nonatomic, strong) NSString *chestIndex;
@property (nonatomic, strong) NSArray *fellowsInBuilding;
@property (nonatomic, strong) NSArray *fellowsInChest;
@property (nonatomic, strong) NSString *electionYear;
@property BOOL isInformationsOld;

+ (id) voterFromDictionary:(NSDictionary *)aDictionary;

+ (id) voterWithName:(NSString *)name
              school:(NSString *)school
            province:(NSString *)province
               chest:(NSString *)chest
          chestIndex:(NSString *)chestIndex;

+ (id) voterWithName:(NSString *)name
              school:(NSString *)school
            province:(NSString *)province
               chest:(NSString *)chest
          chestIndex:(NSString *)chestIndex
   fellowsInBuilding:(NSArray *)fellowsInBuilding
      fellowsInChest:(NSArray *)fellowsInChest;

- (id) initFromDictionary:(NSDictionary *)aDictionary;

- (id) initWithName:(NSString *)name
             school:(NSString *)school
           province:(NSString *)province
              chest:(NSString *)chest
         chestIndex:(NSString *)chestIndex;

- (id) initWithName:(NSString *)name
             school:(NSString *)school
           province:(NSString *)province
              chest:(NSString *)chest
         chestIndex:(NSString *)chestIndex
  fellowsInBuilding:(NSArray *)fellowsInBuilding
     fellowsInChest:(NSArray *)fellowsInChest;

@end
