//
//  PRHCardTableWindowController.m
//  CACardAnimationTest
//
//  Created by Peter Hosey on 2014-01-04.
//  Copyright (c) 2014 Peter Hosey. All rights reserved.
//

#import "PRHCardTableWindowController.h"
#import "PRHCardLayer.h"
#import "PRHCardTableView.h"

@interface PRHCardTableWindowController ()

@property (weak) IBOutlet PRHCardTableView *cardTableView;

@end

@implementation PRHCardTableWindowController

- (id) init {
	return [self initWithWindowNibName:NSStringFromClass([self class]) owner:self];
}

- (void) awakeFromNib {
	enum { numCards = PRHCardRankKing };
	NSMutableArray *cards = [NSMutableArray arrayWithCapacity:(NSUInteger)numCards];
	for (PRHCardRank rank = PRHCardRankAce; rank <= numCards; ++rank) {
		PRHCardSuit suit = [PRHCardLayer suitAtIndex:arc4random_uniform(4U)];
		[cards addObject:[PRHCardLayer cardLayerWithSuit:suit rank:rank]];
	}

	self.cardTableView.cards = cards;
}

@end
