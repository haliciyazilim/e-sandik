//
//  Neighbour.h
//  e-Sandik
//
//  Created by Alperen Kavun on 09.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Neighbour : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *doorNumber;

+ (id)neighbourFromDictionary:(NSDictionary *)aDictionary;

+ (id)neighbourWithName:(NSString *)name
             doorNumber:(NSString *)doorNumber;

- (id)initWithDictionary:(NSDictionary *)aDictionary;

- (id)initWithName:(NSString *)name
        doorNumber:(NSString *)doorNumber;

- (id)copyWithZone:(NSZone *)zone;

@end
