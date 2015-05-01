//
//  RepDetailViewController.h
//  Day2StretchRep
//
//  Created by Gabriel Guerrero on 4/30/15.
//  Copyright (c) 2015 Gabe Guerrero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Representative.h"

@interface RepDetailViewController : UIViewController

// set an representative that will be passed from the RepTableListVC
@property (nonatomic,strong) Representative *repSelected;

@end
