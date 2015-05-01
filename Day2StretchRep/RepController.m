//
//  RepController.m
//  Day2StretchRep
//
//  Created by Gabriel Guerrero on 4/7/15.
//  Copyright (c) 2015 Gabe Guerrero. All rights reserved.
//

#import "RepController.h"
#import <UIKit/UIKit.h>
#import "Representative.h"

@interface RepController () <UIAlertViewDelegate>

@end

@implementation RepController

+ (RepController *) sharedInstance {
    static RepController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [RepController new];
    });
    return sharedInstance;
}

- (void) getRepresentativesFromZip:(NSString *)string {
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    // query that data in the background return as NSData
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://whoismyrepresentative.com/getall_mems.php?zip=%@&output=json", string]] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data == nil) NSLog(@"nothing");
        
        if (!error) {
            
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        [RepController sharedInstance].representativesDict = json;
        [self createArrayOfRepresentativesWithDictionary:json];
        //NSLog(@"%@", json);
            
        } else {
            // notify the user there was an error in retrieving data
            NSString *errorString = [NSString stringWithFormat:@"There was a problem retrieving the data. \n%@", error];
            UIAlertView *errorAlertView = [[UIAlertView alloc]initWithTitle:@"Error"
                                                               message:errorString
                                                              delegate:self cancelButtonTitle:@"Okay"
                                                     otherButtonTitles:nil];
            [errorAlertView show];
        
        }
        // Notify the tableview to reload the table since the query is done
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateTable" object:nil];
    }];
    // essential in order the Task to actually query data
    [dataTask resume];
}

- (void) createArrayOfRepresentativesWithDictionary:(NSDictionary *) dict {
    
    // Create mutable array to add instances of Representative
    NSMutableArray *arrayOfRepInstances = [NSMutableArray new];
    
    // Create instance of Representative and add it to the mutable array
    NSArray *array = [dict valueForKey:@"results"];
    for (NSDictionary *dictionary in array) {
    Representative *representative = [[Representative alloc]initWithDictionary:dictionary];
    [arrayOfRepInstances addObject:representative];
    self.arrayOfRep = arrayOfRepInstances;
    }

}


@end
