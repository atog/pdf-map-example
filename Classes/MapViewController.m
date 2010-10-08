//
//  MapViewController.m
//  Map Example
//
//  Created by Jelle Vandebeeck on 08/10/10.
//  Copyright 2010 10to1. All rights reserved.
//

#import "MapViewController.h"

@implementation MapViewController

#pragma mark -
#pragma mark Initialization methods

- (void)awakeFromNib {
	NSString *path = [[NSBundle mainBundle] pathForResource:@"tube" ofType:@"pdf"];
    NSURL *pdfURL = [NSURL fileURLWithPath:path];
	documentRef = CGPDFDocumentCreateWithURL((CFURLRef) pdfURL);
	pageRef = CGPDFDocumentGetPage(documentRef, 1);
}

#pragma mark -
#pragma mark View flow

- (void)viewDidLoad {
	// Created the tiled layer.
	CATiledLayer *tiledLayer = [CATiledLayer layer];
	// Be sure to set the delegate to self so this class can handle the cropping.
    tiledLayer.delegate = self;
	// Set the size of the tiles to be rendered.
    tiledLayer.tileSize = CGSizeMake(1024, 1024);
	
    tiledLayer.levelsOfDetail = 1000;
    tiledLayer.levelsOfDetailBias = 1000;
	
	// Set the size of 1 page of the PDF.
	CGRect pageRect = CGRectIntegral(CGPDFPageGetBoxRect(pageRef, kCGPDFCropBox));
    tiledLayer.frame = pageRect;
	
	// Create the view that will display the tiled layer, this view will also be returned as the "to zoom" view.
	mapView = [[UIView alloc] initWithFrame:pageRect];
    [mapView.layer addSublayer:tiledLayer];
	
	// Set the offset of the scrollview to fit the map
	CGFloat offsetX = ((mapView.frame.size.width - self.view.frame.size.width) / 2);
	CGFloat offsetY = ((mapView.frame.size.height - self.view.frame.size.height) / 2);
	((UIScrollView *) self.view).contentOffset = CGPointMake(offsetX, offsetY);
	((UIScrollView *) self.view).minimumZoomScale = ((UIScrollView *) self.view).zoomScale / (mapView.frame.size.height / self.view.frame.size.height);
    ((UIScrollView *) self.view).contentSize = pageRect.size;
	((UIScrollView *) self.view).maximumZoomScale = 1000;
	
	// Important to set the delegate if you want to enable zooming
	((UIScrollView *) self.view).delegate = self;
	
    [self.view addSubview:mapView];
}

#pragma mark -
#pragma mark Delegate methods from CATiledLayer

// This method takes care of the cropping.
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context {
	CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
	CGContextFillRect(context, CGContextGetClipBoundingBox(context));
 	CGContextTranslateCTM(context, 0.0, layer.bounds.size.height);
 	CGContextScaleCTM(context, 1.0, -1.0);
 	CGContextConcatCTM(context, CGPDFPageGetDrawingTransform(pageRef, kCGPDFCropBox, layer.bounds, 0, true));
    CGContextDrawPDFPage(context, pageRef);
}

#pragma mark -
#pragma mark Delegate methods from UIScrollView

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	// Return the view you wish to zoom into.
	return mapView;
}

#pragma mark -
#pragma mark Orientation methods

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

@end
