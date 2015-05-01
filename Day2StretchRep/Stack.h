//
//  Stack.m
//
//  Created by Joshua Howland on 6/12/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//


#import <Foundation/Foundation.h>
@import CoreData;

@interface Stack : NSObject

+ (Stack *)sharedInstance;

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

// this object context will only be for searched results; it will not be saved
@property (nonatomic, strong, readonly) NSManagedObjectContext *temporaryManagedObjectContext;

@end