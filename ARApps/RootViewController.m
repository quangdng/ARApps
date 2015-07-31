//
//  RootViewController.m
//  ARApps
//
//  Created by Thiên Phong on 17/05/2015.
//  Copyright (c) 2015 Quang Nguyen. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setting up buttons appearance
    [_TRex setType:BButtonTypePrimary];
    [_TRex setStyle:BButtonStyleBootstrapV2];
    [_TRex setTitle:@"Comprehensive Learning" forState:UIControlStateNormal];
    [_TRex addAwesomeIcon:FAPencil beforeTitle:YES];

    [_infoEx setType:BButtonTypeSuccess];
    [_infoEx setStyle:BButtonStyleBootstrapV2];
    [_infoEx setTitle:@"Information Exchange" forState:UIControlStateNormal];
    [_infoEx addAwesomeIcon:FAMailForward beforeTitle:YES];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
