//
//  RevealViewController.h
//  ARApps
//
//  Created by Dang Quang Nguyen on 17/05/2015.
//  Copyright (c) 2015 Quang Nguyen. All rights reserved.
//

#import "ViewController.h"
#include <metaioSDK/IMetaioSDK.h>
#import "MBProgressHUD.h"

/*
 * This class is responsible for detecting QR Code marker, and 
 * render associated contents with that marker
 */

@interface RevealViewController : ViewController <MBProgressHUDDelegate> {
   
    // Holds movie for the message
    metaio::IGeometry*	movie;
    
    // Check for QR marker detection state
    bool isQR;
    
    // System message varibale
    MBProgressHUD *HUD;
}

@end
