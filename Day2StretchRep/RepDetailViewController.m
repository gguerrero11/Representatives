//
//  RepDetailViewController.m
//  Day2StretchRep
//
//  Created by Gabriel Guerrero on 4/30/15.
//  Copyright (c) 2015 Gabe Guerrero. All rights reserved.
//

#import "RepDetailViewController.h"
#import "RepController.h"
#import "Representative.h"

@interface RepDetailViewController ()

@property (nonatomic,strong) Representative *repSelected;

@end

@implementation RepDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.repSelected = [RepController sharedInstance].arrayOfRep[self.indexOfRep];
    self.title = self.repSelected.name;
    [self setUpLabels];
}

- (void)setUpLabels {
    [self createLabelWithTitle:nameKey withText:self.repSelected.name atYOrigin:80];
    [self createLabelWithTitle:districtKey withText:self.repSelected.districtString atYOrigin:120];
    [self createLabelWithTitle:officeKey withText:self.repSelected.officeString atYOrigin:160];
    [self createLabelWithTitle:partyKey withText:self.repSelected.partyString atYOrigin:200];
    [self createLabelWithTitle:stateKey withText:self.repSelected.stateString atYOrigin:240];
    [self createLabelWithTitle:phoneNumberKey withText:self.repSelected.phoneNumber atYOrigin:280];
    
    
}

// this method will be used to create all the labels (more modular)
- (void)createLabelWithTitle:(NSString *)title withText:(NSString *)string atYOrigin:(double)yOrigin {
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(40, yOrigin, self.view.frame.size.width, 40)];
    label.text = [NSString stringWithFormat:@"%@: %@", title, string];
    [self.view addSubview:label];
}

- (void)createLinkWithText:(NSString *)string atYOrigin:(double)yOrigin {
    UIButton *link = [[UIButton alloc]initWithFrame:CGRectMake(40, yOrigin, self.view.frame.size.width, 40)];
    //link addTarget:<#(id)#> action:<#(SEL)#> forControlEvents:<#(UIControlEvents)#>
}

- (void)pressedPhoneNumber {
    
}

- (void)weblinkPressed {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
