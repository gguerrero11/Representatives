//
//  CoreDataHelper.h
//  Representatives
//
//  Created by Gabriel Guerrero on 2/26/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface CoreDataHelper : NSObject

+ (CoreDataHelper *) sharedInstance;

- (NSManagedObjectContext *)managedObjectContext;

- (void) save;

@end
