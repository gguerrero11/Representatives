//
//  RepDetailViewController.m
//  Day2StretchRep
//
//  Created by Gabriel Guerrero on 4/30/15.
//  Copyright (c) 2015 Gabe Guerrero. All rights reserved.
//

#import "RepDetailViewController.h"
#import "RepController.h"


@interface RepDetailViewController ()

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
    [self createLinkWithTitle:phoneNumberKey withText:self.repSelected.phoneNumber atYOrigin:280 isWeblink:NO];
    [self createLinkWithTitle:linkKey withText:self.repSelected.linkString atYOrigin:320 isWeblink:YES];
}

// this method will be used to create all the labels (more modular)
- (void)createLabelWithTitle:(NSString *)title withText:(NSString *)string atYOrigin:(double)yOrigin {
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(40, yOrigin, self.view.frame.size.width, 40)];
    label.text = [NSString stringWithFormat:@"%@: %@", title, string];
    [self.view addSubview:label];
}

- (void)createLinkWithTitle:(NSString *)title withText:(NSString *)string atYOrigin:(double)yOrigin isWeblink:(BOOL)weblink{
    // use the same method but without text (it will be a button)
    [self createLabelWithTitle:title withText:@"" atYOrigin:yOrigin];
    
    // create the link (either a phone number or weblink, depending on the type)
    UIButton *link = [[UIButton alloc]initWithFrame:CGRectMake(0, yOrigin, self.view.frame.size.width, 40)];
    [link setTitle:string forState:UIControlStateNormal];
    [link setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:link];
    
    // if its a weblink button, it will open safari, otherwise call the number
    if (weblink == YES) [link addTarget:self action:@selector(weblinkPressed:) forControlEvents:UIControlEventTouchDown];
    else [link addTarget:self action:@selector(pressedPhoneNumber:) forControlEvents:UIControlEventTouchDown];
}

- (void)weblinkPressed:(id)sender {
    // pass in the button so that we can get the text (weblink) from it
    UIButton *button = sender;
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:button.titleLabel.text]];
}

- (void)pressedPhoneNumber:(id)sender {
    UIButton *button = sender;
    NSString *phoneNumberWithoutDashes = [button.titleLabel.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSString *phoneNumber = [NSString stringWithFormat:@"tel://%@", phoneNumberWithoutDashes];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
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
