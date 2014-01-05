//
//  PRHCardTableLayoutManager.m
//  CACardAnimationTest
//
//  Created by Peter Hosey on 2014-01-04.
//  Copyright (c) 2014 Peter Hosey. All rights reserved.
//

#import "PRHCardTableLayoutManager.h"
#import "PRHCardTableView.h"
#import "PRHCardLayer.h"

@implementation PRHCardTableLayoutManager

- (void) layoutSublayersOfLayer:(CALayer *)layer {
	PRHCardTableView *view = self.cardTableView;
	CALayer *cardTableLayer = view.layer;
	if (layer != cardTableLayer)
		return;
	CATransformLayer *transformLayer = [[cardTableLayer sublayers] objectAtIndex:0UL];

	NSRect bounds = view.bounds;
	cardTableLayer.bounds = bounds;
	transformLayer.bounds = bounds;
	transformLayer.position = (NSPoint){ bounds.size.width / 2.0, bounds.size.height / 2.0 };

	NSSize cardSize = { PRHCardWidth, PRHCardHeight };

	NSPoint undealtPilePosition = { 10.0 + cardSize.width, 100.0 + cardSize.height };
	NSPoint dealtPilePosition = undealtPilePosition;
	dealtPilePosition.y -= cardSize.height + 10.0;

	NSArray *allCards = view.cards;

	for (PRHCardLayer *card in allCards) {
		CALayer *backLayer = card.sublayers[0];
		CALayer *frontLayer = card.sublayers[1];

		CATransform3D facingForwardTransform = CATransform3DIdentity;
		CATransform3D facingAwayTransform = CATransform3DMakeRotation(M_PI, 0.0, +1.0, 0.0);

		if (card.dealt) {
			card.position = dealtPilePosition;
			dealtPilePosition.x += cardSize.width * 0.4;
			card.transform = facingForwardTransform;
			frontLayer.transform = facingForwardTransform;
			backLayer.transform = facingAwayTransform;
		} else {
			card.position = undealtPilePosition;
			card.transform = facingAwayTransform;
			frontLayer.transform = facingAwayTransform;
			backLayer.transform = facingForwardTransform;
		}
//		NSLog(@"Set bounds of card %@ to %@", card, NSStringFromRect(card.bounds));
	}
}

@end
