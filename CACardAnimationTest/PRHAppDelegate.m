//
//  PRHAppDelegate.m
//  CACardAnimationTest
//
//  Created by Peter Hosey on 2014-01-04.
//  Copyright (c) 2014 Peter Hosey. All rights reserved.
//

#import "PRHAppDelegate.h"
#import "PRHCardTableWindowController.h"

@implementation PRHAppDelegate
{
	PRHCardTableWindowController *_wc;
}

- (void) applicationWillFinishLaunching:(NSNotification *)notification {
	_wc = [PRHCardTableWindowController new];
	[_wc showWindow:nil];
}

- (void) applicationWillTerminate:(NSNotification *)notification {
	[_wc close];
	_wc = nil;
}

@end
