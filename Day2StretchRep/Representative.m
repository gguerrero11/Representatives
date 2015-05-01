//
//  Representative.m
//  Day2StretchRep
//
//  Created by Gabriel Guerrero on 4/7/15.
//  Copyright (c) 2015 Gabe Guerrero. All rights reserved.
//

#import "Representative.h"

@implementation Representative

- (id) initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _districtString = dict[districtKey];
        _linkString = dict[linkKey];
        _name = dict[nameKey];
        _officeString = dict[officeKey];
        _partyString = dict[partyKey];
        _phoneNumber = dict[phoneNumberKey];
        _stateString = dict[stateKey];
    }
    return self;
}

@end
