//
//  ZipCodePutterViewController.m
//  Day2StretchRep
//
//  Created by Gabriel Guerrero on 4/7/15.
//  Copyright (c) 2015 Gabe Guerrero. All rights reserved.
//

#import "ZipCodeInputViewController.h"
#import "RepTableListViewController.h"
#import "RepController.h"

@interface ZipCodeInputViewController () <UITextFieldDelegate>

@end

@implementation ZipCodeInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Intstantiate the text field
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake( 30 , self.view.frame.size.height / 2, self.view.frame.size.width - 60, 30)];
    [self.textField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.textField setKeyboardType:UIKeyboardTypeNumberPad];
    self.textField.placeholder = @"Zip Code";
    [self.view addSubview:self.textField];
    self.textField.delegate = self;
    
    // Create search button and add it to the view.
    self.searchButton = [[UIButton alloc]initWithFrame:CGRectMake( 0, self.textField.frame.origin.y + 50, self.view.frame.size.width, 30)];
    [self.searchButton addTarget:self action:@selector(searchPressed) forControlEvents:UIControlEventTouchDown];
    [self.searchButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.searchButton setTitle:@"Search" forState:UIControlStateNormal];
    [self.view addSubview:self.searchButton];

}

- (void) searchPressed {
    
    // Checks to see if there's text in the textField before it pushes to the next view controller.
    if ([self.textField.text isEqualToString:@""]) {
        UIAlertView *emptyStringAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter a zip code" delegate:self
                                                        cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [emptyStringAlert show];

    } else {
    // Prepare the view controller that will be pushed onto the screen
    RepTableListViewController *viewController = [RepTableListViewController new];
    viewController.title = [NSString stringWithFormat:@"Representatives in %@", self.textField.text];
    // Query the representatives from the zip code entered by the user in the textfield
    [[RepController sharedInstance] getRepresentativesFromZip:self.textField.text];
    [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // when the user hits "return" on the keyboard, it also pushes to the new view
    NSLog(@"return pressed");
    [self searchPressed];
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
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
