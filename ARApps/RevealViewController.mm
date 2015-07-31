//
//  RevealViewController.m
//  ARApps
//
//  Created by Dang Quang Nguyen on 17/05/2015.
//  Copyright (c) 2015 Quang Nguyen. All rights reserved.
//

#import "RevealViewController.h"

@interface RevealViewController ()

@end

@implementation RevealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Start by tracking QR first
    bool success = m_pMetaioSDK->setTrackingConfiguration("QRCODE");
    if( !success) {
        NSLog(@"No success loading the tracking configuration");
    } else {
        isQR = true;
    }
    
    // Load movie message
    NSString* messagePath = [[NSBundle mainBundle] pathForResource:@"hi_VN"
                                                            ofType:@"3g2"
                                                       inDirectory:@"Movies/"];
    
    if(messagePath)
    {
        const char *utf8Path = [messagePath UTF8String];
        movie = m_pMetaioSDK->createGeometryFromMovie(metaio::Path::fromUTF8(utf8Path), true);
        movie->setVisible(false);
        // Check for message loading
        if(movie) {
            NSLog(@"Loaded message");
            
            // Scale up movie message to fit A4 size
            movie->setScale(metaio::Vector3d(2.1f, 2.2f, 1.0f));
            
            
            [self onTrackingEvent:m_pMetaioSDK->getTrackingValues()];
            
        } else
        {
            NSLog(@"No message loaded");
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  Event callback method whenever a tracking target is detected
 *
 *  @param trackingValues Current tracking values of the system
 */
- (void)onTrackingEvent:(const metaio::stlcompat::Vector<metaio::TrackingValues>&)trackingValues
{
    // Get QR User ID Value
    if (isQR) {
        for (int i = 0; i < trackingValues.size(); i++)
        {
            metaio::TrackingValues tv = trackingValues[i];
            if (tv.isTrackingState())
            {
                NSString* values = [NSString stringWithUTF8String:tv.additionalValues.c_str()];
                NSArray* list = [values componentsSeparatedByString:@"::"];
                
                if (list.count > 1) {
                    
                    // Print retrieved user ID
                    NSLog(@"User ID: %@", list[1]);
                    
                    // Load tracking data
                    NSString* trackData = [[NSBundle mainBundle] pathForResource:@"Tracking_QR"
                                                                          ofType:@"xml"
                                                                     inDirectory:@"TrackingReferences/"];
                    
                    // Double check resource
                    if (trackData)
                    {
                        const char *utf8Path = [trackData UTF8String];
                        if (!m_pMetaioSDK->setTrackingConfiguration(metaio::Path::fromUTF8(utf8Path))) {
                            NSLog(@"No tracking data");
                        } else {
                            NSLog(@"Loaded tracking data");
                            
                            
                            // Display sample system message for a particular user ID
                            MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
                            [self.navigationController.view addSubview:hud];
                            
                            hud.labelText = @"Rendering message for Quang Nguyen";
                            
                            [hud showAnimated:YES whileExecutingBlock:^{
                                [NSThread sleepForTimeInterval:3];

                            } completionBlock:^{
                                [hud removeFromSuperview];
                                // Set QR mode to false and start playing movie
                                isQR = false;
                                movie->setVisible(true);
                                movie->startMovieTexture();
                            }];
                        }
                    }
                    else
                        NSLog(@"No tracking data");
                    
                }
                
            }
        }
    }
    
    // Adjust movie playback according to user actions
    else {
        if (trackingValues.empty() || !trackingValues[0].isTrackingState())
        {
            if (movie)
                movie->pauseMovieTexture();
        }
        else
        {
            if (movie)
                movie->startMovieTexture(true);
        }
    }
}

@end
