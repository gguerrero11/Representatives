//
//  CoreDataHelper.m
//  Representatives
//
//  Created by Gabriel Guerrero on 2/26/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "CoreDataHelper.h"
#import "AppDelegate.h"


@implementation CoreDataHelper

+ (CoreDataHelper *) sharedInstance {
    static CoreDataHelper *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [CoreDataHelper new];
    });
    return sharedInstance;
}

- (NSManagedObjectContext *)managedObjectContext {
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    
    return managedObjectContext;
}

- (void) save {
    [[self managedObjectContext] save:NULL];
}


@end
