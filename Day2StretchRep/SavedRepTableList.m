//
//  ViewController.m
//  Day2StretchRep
//
//  Created by Gabriel Guerrero on 4/7/15.
//  Copyright (c) 2015 Gabe Guerrero. All rights reserved.
//

#import "SavedRepTableList.h"
#import "RepController.h"
#import "SavedRepTableDataSource.h"
#import "RepDetailViewController.h"

@interface SavedRepTableList () <UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) SavedRepTableDataSource *dataSource;

@end

@implementation SavedRepTableList

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    [self getTableViewData];
}

- (void) getTableViewData {
    self.dataSource = [SavedRepTableDataSource new];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    [self.dataSource registerTableView:self.tableView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // create a detail view controller and pass the index of which cell was selected by the user.
    RepDetailViewController *repDetailVC = [RepDetailViewController new];
    repDetailVC.repSelected = [RepController sharedInstance].arrayOfRep[indexPath.row];
    repDetailVC.fromSearchList = NO;
    [self.navigationController pushViewController:repDetailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
