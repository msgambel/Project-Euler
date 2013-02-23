//  Global.h

#ifndef Project_Euler_Global_h
#define Project_Euler_Global_h

#ifndef IBOutletCollection
#define IBOutletCollection(ClassName)
#endif

#define TotalNumberSolved 54
#define NumberOfButtonsInQuestionCell 5

#define MaxSizeOfSieveOfAtkinson 500000
#define MaxSizeOfSieveOfEratosthenes 100000000

#define MaxCardValue 14
#define NumberOfCardsInPokerHand 5
#define MaxCardValuePlus1 (MaxCardValue + 1)

// Enumeration to hold the possible suits a card can have.
typedef enum{
  CardSuit_None,
  CardSuit_Spades,
  CardSuit_Hearts,
  CardSuit_Diamonds,
  CardSuit_Clubs
}CardSuit;

// Enumeration to hold the possible ranks a poker hand can have.
typedef enum {
  CardRank_None,
  CardRank_HighCard,
  CardRank_OnePair,
  CardRank_TwoPairs,
  CardRank_ThreeOfAKind,
  CardRank_Straight,
  CardRank_Flush,
  CardRank_FullHouse,
  CardRank_FourOfAKind,
  CardRank_StraightFlush,
  CardRank_RoyalFlush
}CardRank;

#endif