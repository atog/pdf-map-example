//
//  MapAppDelegate.h
//  Map Example
//
//  Created by Jelle Vandebeeck on 08/10/10.
//  Copyright 2010 10to1. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MapViewController;

@interface MapAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MapViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MapViewController *viewController;

@end

