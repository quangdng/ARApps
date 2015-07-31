//
//  TextureViewController.m
//  ARApps
//
//  Created by Dang Quang Nguyen on 11/05/2015.
//  Copyright (c) 2015 Quang Nguyen. All rights reserved.
//

#import "TextureViewController.h"

@interface TextureViewController () {
    SystemSoundID roar;
}

@end

@implementation TextureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initiate class variables
    angleLeft = 0.05;
    angleRight = 0.05;
    isClose = false;
    loaded = false;
    
    
    // Load tracking configuration data
    NSString* trackData = [[NSBundle mainBundle] pathForResource:@"Tracking_TREX"
                                                          ofType:@"xml"
                                                     inDirectory:@"TrackingReferences/"];
    
    // Load model resource
    NSString* tRexModel = [[NSBundle mainBundle] pathForResource:@"trex"
                                                              ofType:@"mfbx"
                                                         inDirectory:@"Model/"];
    
    const char* utf8Path = [tRexModel UTF8String];
    model = m_pMetaioSDK->createGeometry(metaio::Path::fromUTF8(utf8Path));
    model->setScale(metaio::Vector3d(.5f, .5f, .5f)); // Trex
    
    // Double check resource
    if (trackData)
    {
        const char *utf8Path = [trackData UTF8String];
        if (!m_pMetaioSDK->setTrackingConfiguration(metaio::Path::fromUTF8(utf8Path))) {
            NSLog(@"No tracking data");
        } else {
            NSLog(@"Loaded tracking data");
        }
    } else
        NSLog(@"No tracking data");
    
    // Rotate model to fit the current pose
    model->setRotation(metaio::Rotation(M_PI_2,0,M_PI_2));
    model->setVisible(false);
    
    
    // Load roar sound data
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"roar"
                                                          ofType:@"wav"
                                                     inDirectory:@"Sound/"];
    AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain([NSURL fileURLWithPath: soundPath]), &roar);
    
    // Initiate timer to repeatedly check the distance between model and cameras
    NSTimer *t = [NSTimer scheduledTimerWithTimeInterval: 0.01
                                                  target: self
                                                selector:@selector(timerLoop)
                                                userInfo: nil repeats:YES];
    [t fire];
    
    // Assign callback when tracking target is detected
    [self onTrackingEvent:m_pMetaioSDK->getTrackingValues()];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 * Peform left rotation of the model
 */
- (IBAction)leftRotate:(id)sender {
    angleLeft += 0.05;
    model->setRotation(metaio::Rotation(M_PI_2,0,M_PI_2 + angleLeft));
    
}

/**
 * Peform right rotation of the model
 */
- (IBAction)rightRotate:(id)sender {
    angleLeft -= 0.05;
    model->setRotation(metaio::Rotation(M_PI_2,0,M_PI_2 + angleLeft));
    
    
}

/**
 *  Event callback method whenever a tracking target is detected
 *
 *  @param trackingValues Current tracking values of the system
 */
- (void)onTrackingEvent:(const metaio::stlcompat::Vector<metaio::TrackingValues>&)trackingValues
{
    if (trackingValues.empty() || !trackingValues[0].isTrackingState()) {
        
    }
    else {
        if (!loaded) {
            MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
            [self.navigationController.view addSubview:hud];
            
            hud.labelText = @"Visualizing your T-Rex! Be careful!!!";
            
            [hud showAnimated:YES whileExecutingBlock:^{
                [NSThread sleepForTimeInterval:3];
                
            } completionBlock:^{
                [hud removeFromSuperview];
                // Set QR mode to false
                loaded = true;
                if (model) {
                    model->setVisible(true);
                }
            }];
        }
    }
    
}

/**
 *  Logic for check distance from camera to tracking target
 */
- (void) checkDistanceToTarget
{
    // Get the current tracking values for current tracking target
    metaio::TrackingValues currentPose = m_pMetaioSDK->getTrackingValues(1);
    

    if (currentPose.quality > 0)
    {
        // Get the translation part of the pose
        metaio::Vector3d poseTranslation = currentPose.translation;
        
        // Calculate the distance
        float distanceToTarget = sqrt(poseTranslation.x * poseTranslation.x +
                                      poseTranslation.y * poseTranslation.y +
                                      poseTranslation.z * poseTranslation.z
                                      );
        NSLog(@"%f", distanceToTarget);
        
        // Threshold distance
        float threshold = 2000;
        
        if (isClose)
        {
            // If distance is larger than threshol
            if (distanceToTarget > threshold + 10)
            {
                // Flip boolean var
                isClose = false;
                
                // play sound
                AudioServicesPlaySystemSound(roar);
            }
        }
        else
        {
            // Check again if not close yet
            if (distanceToTarget < threshold)
            {
                // Flip boolean var
                isClose = true;
                
                // Play sound
                AudioServicesPlaySystemSound(roar);
            }
        }
    }
}

/**
 *  Timer method
 */
- (void) timerLoop {
    if (loaded) {
        [self checkDistanceToTarget];
    }
}


@end
