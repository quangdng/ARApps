//
//  RootViewController.h
//  ARApps
//
//  Created by Dang Quang Nguyen on 17/05/2015.
//  Copyright (c) 2015 Quang Nguyen. All rights reserved.
//

/*
 * This is the entry point of the mobile applications and 
 * is responsible for managing all navigation involved within
 * the application.
 */

#import <UIKit/UIKit.h>
#import "BButton.h"

@interface RootViewController : UIViewController

// Two button properties to customize buttons visual appearance
@property (strong, nonatomic) IBOutlet BButton *TRex;
@property (strong, nonatomic) IBOutlet BButton *infoEx;

@end
