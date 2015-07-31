//
//  TextureViewController.h
//  ARApps
//
//  Created by Dang Quang Nguyen on 11/05/2015.
//  Copyright (c) 2015 Quang Nguyen. All rights reserved.
//

/*
 * This class is responsible for detecting T-Rex texture,
 * renders it 3D using Metal framework. In addtion, AudioToolbox
 * framework is used for playing roar sound when we get closer to
 * the generated T-Rex model
 */

#import "ViewController.h"
#include <metaioSDK/IMetaioSDK.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"

@interface TextureViewController : ViewController <MBProgressHUDDelegate> {
    
    // The T-Rex model holder
    metaio::IGeometry*  model;
    
    // Control the angle of the model
    float angleLeft;
    float angleRight;
    
    // Boolean to check the distance threshold to play roar sound
    bool isClose;
    
    // Check if model is loaded
    bool loaded;
}
- (IBAction)leftRotate:(id)sender;
- (IBAction)rightRotate:(id)sender;

- (void) checkDistanceToTarget;

@end
