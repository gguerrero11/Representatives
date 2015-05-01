//
//  ViewController.m
//  Day2StretchRep
//
//  Created by Gabriel Guerrero on 4/7/15.
//  Copyright (c) 2015 Gabe Guerrero. All rights reserved.
//

#import "RepTableListViewController.h"
#import "RepController.h"
#import "ViewControllerDataSource.h"
#import "RepDetailViewController.h"

@interface RepTableListViewController () <UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) ViewControllerDataSource *dataSource;
@property (nonatomic,strong) UIActivityIndicatorView *loadCircle;

@end

@implementation RepTableListViewController

- (void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTable) name:@"updateTable" object:nil];
}

- (void)reloadTable {
    // Put the reloadData in the main queue so it automatically reloads the table without the user having to interact with it.
    dispatch_async(dispatch_get_main_queue(), ^{
    [self.tableView reloadData];
    [self.loadCircle stopAnimating];
            });
}

// This notifies user the data is being retrieved
- (void)showActivityIcon {
    self.loadCircle = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.loadCircle.frame = CGRectMake(self.view.frame.size.height / 2 - 50, self.view.frame.size.width / 2 - 50, 100, 100);
    self.loadCircle.center = self.view.center;
    self.loadCircle.backgroundColor = [UIColor colorWithWhite:.1 alpha:.35];
    [self.loadCircle startAnimating];
    [self.view addSubview:self.loadCircle];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Search";
    [self registerForNotifications];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    [self getTableViewData];
    [self showActivityIcon];
}

- (void) getTableViewData {
    self.dataSource = [ViewControllerDataSource new];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    [self.dataSource registerTableView:self.tableView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // create a detail view controller and pass the index of which cell was selected by the user.
    RepDetailViewController *repDetailVC = [RepDetailViewController new];
    repDetailVC.repSelected = [RepController sharedInstance].arrayOfRep[indexPath.row];
    repDetailVC.fromSearchList = YES;
    [self.navigationController pushViewController:repDetailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
