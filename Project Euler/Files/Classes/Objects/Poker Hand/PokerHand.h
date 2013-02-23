//  PokerHand.h

#import <Foundation/Foundation.h>
#import "Global.h"

@interface PokerHand : NSObject {
  uint     _handValue;
  uint     _handValue2;
  uint     _numberOfCardsInHand;
  CardRank _cardRank;
  uint     _cardValues[NumberOfCardsInPokerHand];
  CardSuit _cardSuits[NumberOfCardsInPokerHand];
}

@property (nonatomic, readonly) uint     handValue;
@property (nonatomic, readonly) uint     handValue2;
@property (nonatomic, readonly) uint     numberOfCardsInHand;
@property (nonatomic, readonly) CardRank cardRank;

- (void)addCard:(NSString *)aCard;
- (BOOL)isBetterThanHand:(PokerHand *)aHand;
- (uint)cardValueForIndex:(uint)aIndex;

@end