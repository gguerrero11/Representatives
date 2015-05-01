//
//  ViewControllerDataSource.m
//  Day2StretchRep
//
//  Created by Gabriel Guerrero on 4/7/15.
//  Copyright (c) 2015 Gabe Guerrero. All rights reserved.
//

#import "SavedRepTableDataSource.h"
#import "RepController.h"
#import "Representative.h"

static NSString * const cellIdentifier = @"cell";

@interface SavedRepTableDataSource ()

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation SavedRepTableDataSource

- (void)registerTableView:(UITableView *)tableView {
    self.tableView = tableView;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //    NSLog(@"number of reps %lu", [RepController sharedInstance].arrayOfRep.count);
    return [RepController sharedInstance].arrayOfRep.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    Representative *rep = [RepController sharedInstance].arrayOfRep[indexPath.row];
    cell.textLabel.text = rep.name;
    NSString *subtitleText = [NSString stringWithFormat:@"District: %@    Party:%@    State:%@", rep.districtString, rep.partyString, rep.stateString];
    cell.detailTextLabel.text = subtitleText;
    
    return cell;
}


@end
