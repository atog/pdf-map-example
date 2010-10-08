//
//  MapAppDelegate.m
//  Map Example
//
//  Created by Jelle Vandebeeck on 08/10/10.
//  Copyright 2010 10to1. All rights reserved.
//

#import "MapAppDelegate.h"
#import "MapViewController.h"

@implementation MapAppDelegate

@synthesize window;
@synthesize viewController;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after app launch. 
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];

	return YES;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}

@end
