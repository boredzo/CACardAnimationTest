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

	NSSize cardSize = { PRHCardWidth, PRHCardHeight };

	NSPoint undealtPilePosition = { 10.0 + cardSize.width, 100.0 + cardSize.height };
	NSPoint dealtPilePosition = undealtPilePosition;
	dealtPilePosition.y -= cardSize.height + 10.0;

	for (PRHCardLayer *card in view.cards) {
		if (card.dealt) {
			card.position = dealtPilePosition;
			dealtPilePosition.x += cardSize.width * 0.4;
			card.transform = CATransform3DIdentity;
		} else {
			card.position = undealtPilePosition;
			card.transform = CATransform3DMakeRotation(M_PI, 0.0, +1.0, 0.0);
		}
//		NSLog(@"Set bounds of card %@ to %@", card, NSStringFromRect(card.bounds));
	}
}

@end
