//
//  RepController.h
//  Day2StretchRep
//
//  Created by Gabriel Guerrero on 4/7/15.
//  Copyright (c) 2015 Gabe Guerrero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Representative.h"
#import "CoreDataHelper.h"

@interface RepController : NSObject

@property (nonatomic,strong) NSDictionary *representativesDict;
@property (nonatomic,strong) NSArray *arrayOfRep;
@property (nonatomic,strong) NSArray *savedList;

+ (RepController *) sharedInstance;
- (void) getRepresentativesFromZip:(NSString *)string;

- (Representative *)addRepesentativeWithDictionary:(NSDictionary *)dict;

- (void)removeRep:(Representative *)rep;

- (void)save;

@end
