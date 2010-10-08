//
//  MapViewController.h
//  Map Example
//
//  Created by Jelle Vandebeeck on 08/10/10.
//  Copyright 2010 10to1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MapViewController : UIViewController <UIScrollViewDelegate> {
	CGPDFDocumentRef documentRef;
	CGPDFPageRef pageRef;
	
	UIView *mapView;
}

@end

