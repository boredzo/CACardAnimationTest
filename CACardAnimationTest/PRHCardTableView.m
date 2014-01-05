//
//  PRHCardTableView.m
//  CACardAnimationTest
//
//  Created by Peter Hosey on 2014-01-04.
//  Copyright (c) 2014 Peter Hosey. All rights reserved.
//

#import "PRHCardTableView.h"

@interface PRHCardTableView ()

@end

@implementation PRHCardTableView

- (id) initWithFrame:(NSRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		CALayer *cardTableLayer = [CALayer new];

		CGColorRef greenFelt = CGColorCreateGenericRGB(15.0/255.0, 69.0/255.0, 11.0/255.0, 1.0);
		cardTableLayer.backgroundColor = greenFelt;
		CGColorRelease(greenFelt);

		self.layer = cardTableLayer;
		self.wantsLayer = YES;
	}

	return self;
}

- (void) viewDidChangeBackingProperties {
	self.layer.contentsScale = self.window.backingScaleFactor;
}

- (void) setCards:(NSArray *)cards {
	_cards = [cards copy];

	CGFloat backingScaleFactor = self.window.backingScaleFactor;
	[self.cards setValue:@(backingScaleFactor) forKey:@"contentsScale"];
	self.layer.sublayers = self.cards;

	[self.layer setNeedsLayout];
}

- (void) setLayoutManager:(id)layoutManager {
	_layoutManager = layoutManager;

	self.layer.layoutManager = layoutManager;
}

- (IBAction) deal:(id)sender {
	[self.cards setValue:@YES forKey:@"dealt"];
	[self.layer setNeedsLayout];
}

- (IBAction) undeal:(id)sender {
	[self.cards setValue:@NO forKey:@"dealt"];
	[self.layer setNeedsLayout];
}

@end
