//
//  PRHCardLayer.m
//  CACardAnimationTest
//
//  Created by Peter Hosey on 2014-01-04.
//  Copyright (c) 2014 Peter Hosey. All rights reserved.
//

#import "PRHCardLayer.h"

const CGFloat PRHCardWidth = 63.5;
const CGFloat PRHCardHeight = 88.9;

@interface PRHCardLayer ()
@property CALayer *frontLayer;
@property CATextLayer *frontTextLayer;
@property CALayer *backLayer;
@property CATextLayer *backTextLayer;
@end

@implementation PRHCardLayer

+ (instancetype) cardLayerWithSuit:(PRHCardSuit)suit rank:(PRHCardRank)rank {
	return [[self alloc] initWithSuit:suit rank:rank];
}

+ (CALayer *) blankCardLayer {
	CALayer *blankCard = [CALayer new];
	blankCard.cornerRadius = 2.0;
	blankCard.backgroundColor = CGColorGetConstantColor(kCGColorWhite);
	blankCard.borderWidth = 1.0;
	blankCard.borderColor = CGColorGetConstantColor(kCGColorBlack);
	return blankCard;
}

- (instancetype) initWithSuit:(PRHCardSuit)suit rank:(PRHCardRank)rank {
	self = [super init];
	if (self != nil) {
		_suit = suit;
		_rank = rank;

		CGColorRef temp = CGColorCreateGenericRGB(1.0, 0.0, 0.0, 1.0);
		self.backgroundColor = temp;
		CGColorRelease(temp);

		CALayer *backLayer = [[self class] blankCardLayer];
		CATransform3D transform = CATransform3DMakeRotation(M_PI, 0.0, +1.0, 0.0);
		backLayer.transform = transform;
		backLayer.doubleSided = NO;
		self.backLayer = backLayer;

		CATextLayer *backTextLayer = [CATextLayer new];
		NSString *backString = @"\U0001F60E";
		backTextLayer.string = [NSString stringWithFormat:@"\n%@", backString];
		backTextLayer.foregroundColor = CGColorGetConstantColor(kCGColorBlack);
		backTextLayer.contentsGravity = kCAGravityCenter;
		backTextLayer.alignmentMode = kCAAlignmentCenter;
		self.backTextLayer = backTextLayer;

		[self.backLayer addSublayer:self.backTextLayer];
		[self addSublayer:self.backLayer];

		CALayer *frontLayer = [[self class] blankCardLayer];
		frontLayer.doubleSided = NO;
		self.frontLayer = frontLayer;

		CATextLayer *frontTextLayer = [CATextLayer new];
		NSString *rankString = [self stringForRank:self.rank];
		NSString *suitString = [self stringForSuit:suit];
		frontTextLayer.string = [NSString stringWithFormat:@"%@\n%@", rankString, suitString];
		frontTextLayer.foregroundColor = CGColorGetConstantColor(kCGColorBlack);
		frontTextLayer.contentsGravity = kCAGravityCenter;
		self.frontTextLayer = frontTextLayer;

		[self.frontLayer addSublayer:self.frontTextLayer];
		[self addSublayer:self.frontLayer];

		NSRect bounds = { NSZeroPoint, { PRHCardWidth, PRHCardHeight } };
		self.bounds = bounds;
		self.frontLayer.bounds = bounds;
		self.frontTextLayer.bounds = bounds;
		self.backLayer.bounds = bounds;
		self.backTextLayer.bounds = bounds;
		NSPoint position = { bounds.size.width / 2.0, bounds.size.height / 2.0 };
		self.frontLayer.position = position;
		self.frontTextLayer.position = position;
		self.backLayer.position = position;
		self.backTextLayer.position = position;
	}

	return self;
}

- (void) setBounds:(CGRect)bounds {
	[super setBounds:bounds];

	self.frontLayer.bounds = bounds;
	self.frontTextLayer.bounds = bounds;
}

- (void) setContentsScale:(CGFloat)contentsScale {
	[super setContentsScale:contentsScale];

	for (CALayer *cardFaceLayer in self.sublayers) {
		for (CATextLayer *textLayer in cardFaceLayer.sublayers) {
			textLayer.contentsScale = contentsScale;
		}
	}
}

+ (PRHCardSuit) suitAtIndex:(NSUInteger)idx {
	static PRHCardSuit suits[] = {
		PRHCardSuitSpade,
		PRHCardSuitHeart,
		PRHCardSuitDiamond,
		PRHCardSuitClub,
	};
	return suits[idx];
}

- (NSString *) stringForRank:(PRHCardRank)rank {
	switch (rank) {
		case PRHCardRankAce:
			return @"A";
		case PRHCardRank2:
		case PRHCardRank3:
		case PRHCardRank4:
		case PRHCardRank5:
		case PRHCardRank6:
		case PRHCardRank7:
		case PRHCardRank8:
		case PRHCardRank9:
		case PRHCardRank10:
			return [NSString stringWithFormat:@"%lu", (unsigned long)rank];
		case PRHCardRankJack:
			return @"J";
		case PRHCardRankQueen:
			return @"Q";
		case PRHCardRankKing:
			return @"K";
	}
	return nil;
}

- (NSString *) stringForSuit:(PRHCardSuit)suit {
	return [NSString stringWithCharacters:(unichar const *)&suit length:1UL];
}

- (NSString *) description {
	return [NSString stringWithFormat:@"<%@ %p %@%@>", self.class, (__bridge void *)self,
		[self stringForRank:self.rank], [self stringForSuit:self.suit]
	];
}

@end
