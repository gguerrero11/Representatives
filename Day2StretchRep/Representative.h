//
//  Representative.h
//  Day2StretchRep
//
//  Created by Gabriel Guerrero on 4/7/15.
//  Copyright (c) 2015 Gabe Guerrero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

// create static constants to prevent typos when getting values for keys
static NSString * const districtKey = @"district";
static NSString * const linkKey = @"link";
static NSString * const nameKey = @"name";
static NSString * const officeKey = @"office";
static NSString * const partyKey = @"party";
static NSString * const phoneNumberKey = @"phone";
static NSString * const stateKey = @"state";

@interface Representative : NSManagedObject

@property (nonatomic,strong) NSString *districtString;
@property (nonatomic,strong) NSString *linkString;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *officeString;
@property (nonatomic,strong) NSString *partyString;
@property (nonatomic,strong) NSString *phoneNumber;
@property (nonatomic,strong) NSString *stateString;

@end
