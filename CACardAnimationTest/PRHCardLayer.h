//
//  PRHCardLayer.h
//  CACardAnimationTest
//
//  Created by Peter Hosey on 2014-01-04.
//  Copyright (c) 2014 Peter Hosey. All rights reserved.
//

#define PRHNumberedCard(n) PRHCardRank##n = n
typedef NS_ENUM(NSUInteger, PRHCardRank) {
	PRHCardRankAce = 1,
	PRHNumberedCard(2),
	PRHNumberedCard(3),
	PRHNumberedCard(4),
	PRHNumberedCard(5),
	PRHNumberedCard(6),
	PRHNumberedCard(7),
	PRHNumberedCard(8),
	PRHNumberedCard(9),
	PRHNumberedCard(10),
	PRHCardRankJack = 11,
	PRHCardRankQueen,
	PRHCardRankKing,
};

typedef NS_ENUM(unichar, PRHCardSuit) {
	PRHCardSuitSpade = 0x2660,
	PRHCardSuitHeart = 0x2661,
	PRHCardSuitDiamond = 0x2662,
	PRHCardSuitClub = 0x2663,
};

extern const CGFloat PRHCardWidth, PRHCardHeight;

@interface PRHCardLayer : CALayer

+ (instancetype) cardLayerWithSuit:(PRHCardSuit)suit rank:(PRHCardRank)rank;
- (instancetype) initWithSuit:(PRHCardSuit)suit rank:(PRHCardRank)rank;

+ (PRHCardSuit) suitAtIndex:(NSUInteger)idx;

@property(readonly) PRHCardSuit suit;
@property(readonly) PRHCardRank rank;

@property(getter=isDealt) bool dealt;

@end
