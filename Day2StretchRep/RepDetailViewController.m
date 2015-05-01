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
    self.title = self.repSelected.name;
    [self setUpLabels];
    [self addNavBarButton];
}

// this method was added so if the user is selecting a rep from either the saved list or the search list, it displays correct information based on the instance rather than from the selected index.
- (void) updateRepresentative:(Representative *)passedRep {
    self.repSelected = passedRep;
}

// if the user is coming from the list of searched reps, it an Add to saved list will appear.
- (void)addNavBarButton {
    if (self.fromSearchList == YES) {
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:
                                      UIBarButtonSystemItemAdd target:self action:@selector(addRepToSavedList)];
        self.navigationItem.rightBarButtonItem = addButton;
    }
}

- (void) addRepToSavedList {
    if ([self duplicatePresent] == NO) {
    // creates a temporary mutable array to add the Representative (it sets this mutable array to the sharedInstance saved list
    // It protects the savedList's NSArray integrity of objects (prevents random adding/removing of objects)
    NSMutableArray *mArray = [[NSMutableArray alloc]initWithArray:[RepController sharedInstance].savedList];
    [mArray addObject:self.repSelected];
    [RepController sharedInstance].savedList = mArray;
    
    // alert that notifies user that the rep has been saved
    NSString *message = [NSString stringWithFormat:@"%@ has been added to your Saved List.", self.repSelected.name];
    UIAlertView *addedAlert = [[UIAlertView alloc]initWithTitle:@"Added to Saved List" message:message delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [addedAlert show];
        
    // save it to Core Data
    [self save];    
    }

}

-(void)save {
    [[Stack sharedInstance].managedObjectContext save:nil];
}

- (BOOL)duplicatePresent {
    // checks if the rep is in the list already (checks by name, district and state just in case there are people with same name)
    // if not, it will add it to the list
    for (Representative *repInSavedList in [RepController sharedInstance].savedList) {
        if ([self.repSelected.name isEqualToString:repInSavedList.name] &&
            [self.repSelected.districtString isEqualToString:repInSavedList.districtString] &&
            [self.repSelected.stateString isEqualToString:repInSavedList.stateString]) {
            
            NSString *message = [NSString stringWithFormat:@"%@ is already in your Saved List.", self.repSelected.name];
            UIAlertView *addedAlert = [[UIAlertView alloc]initWithTitle:@"Name Already Saved." message:message delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            [addedAlert show];
            return YES;
        }
    }
    return NO;
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
