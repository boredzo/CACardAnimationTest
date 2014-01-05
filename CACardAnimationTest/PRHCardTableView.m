//
//  PRHCardTableView.m
//  CACardAnimationTest
//
//  Created by Peter Hosey on 2014-01-04.
//  Copyright (c) 2014 Peter Hosey. All rights reserved.
//

#import "PRHCardTableView.h"
#import "PRHCardLayer.h"

@interface PRHCardTableView ()

@property(strong) CALayer *cardTableLayer;
@property(strong) CATransformLayer *transformLayer;
@property dispatch_queue_t dealerQueue;
@end

@implementation PRHCardTableView

- (id) initWithFrame:(NSRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		CALayer *cardTableLayer = [CALayer new];

		CGColorRef greenFelt = CGColorCreateGenericRGB(15.0/255.0, 69.0/255.0, 11.0/255.0, 1.0);
		cardTableLayer.backgroundColor = greenFelt;
		CGColorRelease(greenFelt);

		self.cardTableLayer = cardTableLayer;

		CATransformLayer *transformLayer = [CATransformLayer new];
		self.transformLayer = transformLayer;
		[self.cardTableLayer addSublayer:self.transformLayer];

		self.layer = self.cardTableLayer;
		self.wantsLayer = YES;

		self.dealerQueue = dispatch_queue_create("org.boredzo.CACardAnimationTest.dealer", DISPATCH_QUEUE_SERIAL);
		dispatch_set_target_queue(self.dealerQueue, dispatch_get_main_queue());
	}

	return self;
}

- (void) viewDidChangeBackingProperties {
	self.cardTableLayer.contentsScale = self.window.backingScaleFactor;
}

- (void) setCards:(NSArray *)cards {
	_cards = [cards copy];

	CGFloat backingScaleFactor = self.window.backingScaleFactor;
	[self.cards setValue:@(backingScaleFactor) forKey:@"contentsScale"];

	self.transformLayer.sublayers = self.cards;
	[self.layer setNeedsLayout];
	[self.cards makeObjectsPerformSelector:@selector(setNeedsLayout)];
}

- (void) setLayoutManager:(id)layoutManager {
	_layoutManager = layoutManager;

	self.layer.layoutManager = layoutManager;
}

- (IBAction) deal:(id)sender {
	[self setDealtOfOneCardAtATimeTo:true reverseOrder:false];
}

- (IBAction) undeal:(id)sender {
	[self setDealtOfOneCardAtATimeTo:false reverseOrder:true];
}

- (void) setDealtOfOneCardAtATimeTo:(bool)dealt reverseOrder:(bool)reverse {
	//Note: totalDealTime is not subject to the shift key, because it's the time period over which we're going to *start* all of the card movements.
	//The cards' individual flights are what are subject to the shift key.
	NSTimeInterval totalDealTime = 0.5; //2.0 arguably looks cooler, but takes two whole seconds (plus flight times).
	NSTimeInterval timePerCard = totalDealTime / self.cards.count;

	bool shiftKeyDown = [NSApp currentEvent].modifierFlags & NSShiftKeyMask;

	__weak typeof(self) weakSelf = self;
	NSTimeInterval time = 0.0;
	for (PRHCardLayer *card in (reverse ? [self.cards reverseObjectEnumerator] : self.cards)) {
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), self.dealerQueue, ^{
			[CATransaction begin];
			if (shiftKeyDown)
				[CATransaction setAnimationDuration:5.0];

			card.dealt = dealt;
			[weakSelf.layer setNeedsLayout];
			[card setNeedsLayout];

			[CATransaction commit];
		});
		time += timePerCard;
	}
}

@end
