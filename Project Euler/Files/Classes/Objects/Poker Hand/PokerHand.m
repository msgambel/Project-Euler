//  PokerHand.m

#import "PokerHand.h"

@interface PokerHand (Private)

- (void)getRank;
- (void)orderCards;
- (void)printCards;
- (BOOL)isAFlush;
- (BOOL)isAStraight;

@end

@implementation PokerHand

@synthesize cardRank = _cardRank;
@synthesize handValue = _handValue;
@synthesize handValue2 = _handValue2;
@synthesize numberOfCardsInHand = _numberOfCardsInHand;

#pragma mark - Init

- (id)init; {
  if((self = [super init])){
    // Set the default rank to None.
    _cardRank = CardRank_None;
    
    // Set the default hands value to a non valid value.
    _handValue = MaxCardValuePlus1;
    
    // Set the default hands second value to a non valid value.
    _handValue2 = MaxCardValuePlus1;
  }
  return self;
}

#pragma mark - Methods

- (void)addCard:(NSString *)aCard; {
  // If we don't have enough cards in the hand yet,
  if(_numberOfCardsInHand < NumberOfCardsInPokerHand){
    // If the cards length has a suit and a value,
    if(aCard.length == 2){
      // Grab the cards suit.
      NSString * cardSuit = [aCard substringWithRange:NSMakeRange(1, 1)];
      
      // Grab the cards value.
      NSString * cardValue = [aCard substringWithRange:NSMakeRange(0, 1)];
      
      // If the cards suit is an S,
      if([cardSuit isEqualToString:@"S"]){
        // Set the suit to spades.
        _cardSuits[_numberOfCardsInHand] = CardSuit_Spades;
      }
      // If the cards suit is an H,
      else if([cardSuit isEqualToString:@"H"]){
        // Set the suit to hearts.
        _cardSuits[_numberOfCardsInHand] = CardSuit_Hearts;
      }
      // If the cards suit is a D,
      else if([cardSuit isEqualToString:@"D"]){
        // Set the suit to diamonds.
        _cardSuits[_numberOfCardsInHand] = CardSuit_Diamonds;
      }
      // If the cards suit is a C,
      else if([cardSuit isEqualToString:@"C"]){
        // Set the suit to clubs.
        _cardSuits[_numberOfCardsInHand] = CardSuit_Clubs;
      }
      // If the cards suit is NOT a valid character,
      else{
        // Leave the method.
        return;
      }
      // If the cards value is an A,
      if([cardValue isEqualToString:@"A"]){
        // Set the cards value to 14.
        _cardValues[_numberOfCardsInHand] = 14;
      }
      // If the cards value is a K,
      else if([cardValue isEqualToString:@"K"]){
        // Set the cards value to 13.
        _cardValues[_numberOfCardsInHand] = 13;
      }
      // If the cards value is a Q,
      else if([cardValue isEqualToString:@"Q"]){
        // Set the cards value to 12.
        _cardValues[_numberOfCardsInHand] = 12;
      }
      // If the cards value is a J,
      else if([cardValue isEqualToString:@"J"]){
        // Set the cards value to 11.
        _cardValues[_numberOfCardsInHand] = 11;
      }
      // If the cards value is a T,
      else if([cardValue isEqualToString:@"T"]){
        // Set the cards value to 10.
        _cardValues[_numberOfCardsInHand] = 10;
      }
      // If the cards value is something else,
      else{
        // Get a set of characters that are not decimal numbers.
        NSCharacterSet * nonNumbers = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        
        // Get the range of any characters that are in the non numbers set.
        NSRange range = [cardValue rangeOfCharacterFromSet:nonNumbers];
        
        // If there is only decimal numbers in the cards value,
        if(range.location == NSNotFound){
          // Set the cards value to the decimal number the card is.
          _cardValues[_numberOfCardsInHand] = [cardValue intValue];
        }
        // If there is a non-decimal number in the cards value,
        else{
          // Leave the method.
          return;
        }
      }
      // Incrememnt the number of cards in the hand by 1.
      _numberOfCardsInHand++;
      
      // If the hand is full,
      if(_numberOfCardsInHand == NumberOfCardsInPokerHand){
        // Get the rank of the hand.
        [self getRank];
      }
    }
  }
}

- (BOOL)isBetterThanHand:(PokerHand *)aHand; {
  // If there are NOT enough cards in this hand to compare them,
  if(self.numberOfCardsInHand != NumberOfCardsInPokerHand){
    // Log that there are not enough cards in this hand to compare.
    NSLog(@"Cannot compare! There are only %d cards in the first hand!", self.numberOfCardsInHand);
    
    // Return that this hand is NOT better than the inputted hand.
    return NO;
  }
  // If there are NOT enough cards in the inputted hand to compare them,
  if(aHand.numberOfCardsInHand != NumberOfCardsInPokerHand){
    // Log that there are not enough cards in the inputted hand to compare.
    NSLog(@"Cannot compare! There are only %d cards in the second hand!", aHand.numberOfCardsInHand);
    
    // Return that this hand is NOT better than the inputted hand.
    return NO;
  }
  // If the hands rank is greater than the inputted hands rank,
  if(self.cardRank > aHand.cardRank){
    // Return that this hand IS better than the inputted hand.
    return YES;
  }
  // If the hands rank is less than the inputted hands rank,
  else if(self.cardRank < aHand.cardRank){
    // Return that this hand is NOT better than the inputted hand.
    return NO;
  }
  // If the hands rank is equal to the inputted hands rank,
  else{
    // Variable to mark if the hand is better than the inputted hand.
    BOOL isBetter = YES;
    
    // Variable to mark if we need to compare the highest card.
    BOOL compareHighestCard = NO;
    
    // If the hand's value is greater than the inputted hands value,
    if(self.handValue > aHand.handValue){
      // Mark that this hand IS better than the inputted hand.
      isBetter = YES;
    }
    // If the hand's value is less than the inputted hands value,
    else if(self.handValue < aHand.handValue){
      // Mark that this hand is NOT better than the inputted hand.
      isBetter = NO;
    }
    // If the hand's value is equal to than the inputted hands value,
    else{
      // If this hand is a two-pair,
      if(_cardRank == CardRank_TwoPairs){
        // If the lower pairs value is greater than the inputted hands lower
        // pairs value,
        if(self.handValue2 > aHand.handValue2){
          // Mark that this hand IS better than the inputted hand.
          isBetter = YES;
        }
        // If the lower pairs value is less than the inputted hands lower pairs
        // value,
        else if(self.handValue2 < aHand.handValue2){
          // Mark that this hand is NOT better than the inputted hand.
          isBetter = NO;
        }
        // If the lower pairs value is equal to than the inputted hands lower
        // pairs value,
        else{
          // Mark that we need to compare the highest card.
          compareHighestCard = YES;
        }
      }
      // If the hand is NOT a two-pair,
      else{
        // Mark that we need to compare the highest card.
        compareHighestCard = YES;
      }
      // If we should compare the highest card.
      if(compareHighestCard){
        // Note: Here, we can just compare every card in the hand to see which
        //       hand has a higher value. The reason is because the hands are
        //       both ordered. Therefore, the cards that contribute to the hands
        //       rank will be ignored while doing this.
        
        // For all the cards in the hand, starting with the highest,
        for(int cardIndex = (NumberOfCardsInPokerHand - 1); cardIndex > 0; cardIndex--){
          // If the cards value is greater than the inputted cards value,
          if([self cardValueForIndex:cardIndex] > [aHand cardValueForIndex:cardIndex]){
            // Mark that this hand IS better than the inputted hand.
            isBetter = YES;
            
            // Break out of the loop.
            break;
          }
          // If the cards value is less than the inputted cards value,
          else if([self cardValueForIndex:cardIndex] < [aHand cardValueForIndex:cardIndex]){
            // Mark that this hand is NOT better than the inputted hand.
            isBetter = NO;
            
            // Break out of the loop.
            break;
          }
        }
      }
    }
    // Return
    return isBetter;
  }
}

- (uint)cardValueForIndex:(uint)aIndex; {
  // If the cards index is valid,
  if(aIndex < NumberOfCardsInPokerHand){
    // Return the cards value.
    return _cardValues[aIndex];
  }
  // If the cards index is NOT valid,
  else{
    // Log that the index is too large.
    NSLog(@"Index %d is too large!", aIndex);
    
    // Return a non valid value.
    return MaxCardValuePlus1;
  }
}

@end

#pragma mark - Private Methods

@implementation PokerHand (Private)

- (void)getRank; {
  // If there are NOT enough cards in this hand to rank it,
  if(self.numberOfCardsInHand != NumberOfCardsInPokerHand){
    // Log that there are not enough cards in this hand to rank it.
    NSLog(@"Cannot rank! There are only %d cards in the hand!", self.numberOfCardsInHand);
    
    // Leave the method.
    return;
  }
  // Order the hand.
  [self orderCards];
  
  // If the hand IS a Straight,
  if([self isAStraight]){
    // If the hand IS a Flush,
    if([self isAFlush]){
      // If the value of the highest card in the hand IS an Ace,
      if(_cardValues[(NumberOfCardsInPokerHand - 1)] == MaxCardValue){
        // Set the rank of the hand to a Royal Flush. Sweet!
        _cardRank = CardRank_RoyalFlush;
      }
      // If the value of the highest card in the hand is NOT an Ace,
      else{
        // Set the rank of the hand to a Straigt Flush.
        _cardRank = CardRank_StraightFlush;
      }
    }
    // If the hand is NOT a Flush,
    else{
      _cardRank = CardRank_Straight;
    }
  }
  // If the hand IS a Flush,
  else if([self isAFlush]){
    // Set the rank of the hand to a Flush.
    _cardRank = CardRank_Flush;
  }
  // If the hand IS a Four of a Kind,
  else if([self isAQuad]){
    // Set the rank of the hand to a Four of a Kind.
    _cardRank = CardRank_FourOfAKind;
  }
  // If the hand IS a Full House,
  else if([self isAFullHouse]){
    // Set the rank of the hand to a Full House.
    _cardRank = CardRank_FullHouse;
  }
  // If the hand IS a Triple,
  else if([self isATriple]){
    // Set the rank of the hand to a Triple.
    _cardRank = CardRank_ThreeOfAKind;
  }
  // If the hand IS a Two Pair,
  else if([self isATwoPair]){
    // Set the rank of the hand to a Two Pair.
    _cardRank = CardRank_TwoPairs;
  }
  // If the hand IS a Pair,
  else if([self isAPair]){
    // Set the rank of the hand to a Pair.
    _cardRank = CardRank_OnePair;
  }
  // If the hand IS a High Card,
  else{
    // Set the rank of the hand to a High Card.
    _cardRank = CardRank_HighCard;
  }
}

- (void)orderCards; {
  // If there are NOT enough cards in this hand to order it,
  if(self.numberOfCardsInHand != NumberOfCardsInPokerHand){
    // Log that there are not enough cards in this hand to order it.
    NSLog(@"Cannot order! There are only %d cards in the hand!", self.numberOfCardsInHand);
    
    // Leave the method.
    return;
  }
  // Variable to hold the current minimum cards index.
  int minCardIndex = 0;
  
  // Variable to hold the current minimum cards value.
  int minCardValue = MaxCardValuePlus1;
  
  // Variable to hold the current minimum cards value.
  CardSuit minCardSuit = CardSuit_None;
  
  // Variable array to hold the ordered cards values.
  int orderedValues[NumberOfCardsInPokerHand];
  
  // Variable array to hold the ordered cards suits.
  CardSuit orderedSuits[NumberOfCardsInPokerHand];
  
  // For all the cards in the hand,
  for(int orderedIndex = 0; orderedIndex < NumberOfCardsInPokerHand; orderedIndex++){
    // Reset the minimum card value to be greater than the maximum value.
    minCardValue = MaxCardValuePlus1;
    
    // For all the remaining cards in the hand,
    for(int cardIndex = 0; cardIndex < (NumberOfCardsInPokerHand - orderedIndex); cardIndex++){
      // If the current cards value is less than the current minimum card value,
      if(_cardValues[cardIndex] < minCardValue){
        // Store the current index as the new minimum cards index.
        minCardIndex = cardIndex;
        
        // Set the current cards suit as the minimum cards suit.
        minCardSuit = _cardSuits[cardIndex];
        
        // Set the current cards value as the minimum cards value.
        minCardValue = _cardValues[cardIndex];
      }
    }
    // Set the current lowest cards suit as the current minimum cards suit.
    orderedSuits[orderedIndex] = minCardSuit;
    
    // Set the minimum cards suit to the suit of the last card in the array.
    _cardSuits[minCardIndex] = _cardSuits[(NumberOfCardsInPokerHand - 1 - orderedIndex)];
    
    // Set the last card in the array to be None.
    _cardSuits[(NumberOfCardsInPokerHand - 1 - orderedIndex)] = CardSuit_None;
    
    // Set the current lowest cards value as the current minimum cards value.
    orderedValues[orderedIndex] = minCardValue;
    
    // Set the minimum cards value to the value of the last card in the array.
    _cardValues[minCardIndex] = _cardValues[(NumberOfCardsInPokerHand - 1 - orderedIndex)];
    
    // Set the last card in the array to be greater than the maximum value.
    _cardValues[(NumberOfCardsInPokerHand - 1 - orderedIndex)] = MaxCardValuePlus1;
  }
  // For all the cards in the hand,
  for(int cardIndex = 0; cardIndex < NumberOfCardsInPokerHand; cardIndex++){
    // Set the cards suit to be the ordred suit.
    _cardSuits[cardIndex] = orderedSuits[cardIndex];
    
    // Set the cards value to be the ordred value.
    _cardValues[cardIndex] = orderedValues[cardIndex];
  }
}

- (void)printCards; {
  // Constant array to hold the characters for each suit.
  const NSArray * cardSuits = [NSArray arrayWithObjects:@"N", @"S", @"H", @"D", @"C", nil];
  
  // Variable to hold the hand's cards as a string.
  NSString * handString = @"";
  
  // For all the cards in the hand,
  for(int cardIndex = 0; cardIndex < NumberOfCardsInPokerHand; cardIndex++){
    // Add the cards value and suit as a string to the hand string.
    handString = [NSString stringWithFormat:@"%@%d%@ ", handString, _cardValues[cardIndex], [cardSuits objectAtIndex:_cardSuits[cardIndex]]];
  }
  // Log the hand as a string to the console.
  NSLog(@"%@", handString);
}

- (BOOL)isAPair; {
  // The hand is ordered. Therefore, we need only check if the neighbour to the
  // right has the same value. If it does, it must be a pair!
  
  // Variable to mark if the hand is a Pair.
  BOOL isAPair = NO;
  
  // For all the other cards in the hand,
  for(int cardIndex = 0; cardIndex < (NumberOfCardsInPokerHand - 1); cardIndex++){
    //currentCardsValue = _cardValues[startCardIndex];
    
    // If the current cards value is equal to the cards value to the right,
    if(_cardValues[cardIndex] == _cardValues[(cardIndex + 1)]){
      // Mark that it is a pair.
      isAPair = YES;
      
      // Set the hands value to be the value of the pair.
      _handValue = _cardValues[cardIndex];
      
      // Break out of the loop.
      break;
    }
  }
  // Return if the hand is a Pair or NOT.
  return isAPair;
}

- (BOOL)isAQuad; {
  // The hand is ordered, so there are only 2 cases:
  //
  // Case 1: The quads value is less than the single cards value.
  //
  // This only happens when card 0 equals card 3.
  //
  // Case 2: The quads value is greater than the single cards value.
  //
  // This only happens when card 1 equals card 4.
  
  // If there is a quad whose value is lower than the single card,
  if(_cardValues[0] == _cardValues[3]){
    // Set the value of the hand to be the quads value.
    _handValue = _cardValues[0];
    
    // Return that the hand IS a Quad.
    return YES;
  }
  else if(_cardValues[1] == _cardValues[4]){
    // Set the value of the hand to be the quads value.
    _handValue = _cardValues[1];
    
    // Return that the hand IS a Quad.
    return YES;
  }
  // Return that the hand is NOT a Quad.
  return NO;
}

- (BOOL)isAFlush; {
  // Variable to mark is the hand is a Flush.
  BOOL isAFlush = YES;
  
  // Grab the suit of the lowest card in the hand.
  CardSuit suit = _cardSuits[0];
  
  // For all the other cards in the hand,
  for(int cardIndex = 1; cardIndex < NumberOfCardsInPokerHand; cardIndex++){
    // If the cards suit is NOT the same as the lowest cards suit,
    if(_cardSuits[cardIndex] != suit){
      // Mark that the hand is NOT a flush.
      isAFlush = NO;
      
      // Break out of the loop.
      break;
    }
  }
  // If the hand IS a Flush,
  if(isAFlush){
    // Set the value of the hand to the highest cards value.
    _handValue = _cardValues[4];
  }
  // Return if the hand is a Flush or NOT.
  return isAFlush;
}

- (BOOL)isATriple; {
  // The hand is ordered, so there are only 3 cases:
  //
  // Case 1: The triples value is less than the other cards values.
  //
  // This only happens when card 0 equals card 2.
  //
  // Case 2: The triples value is inbetween the other cards values.
  //
  // This only happens when card 1 equals card 3.
  //
  // Case 3: The triples value is less than the other cards values.
  //
  // This only happens when card 2 equals card 4.
  
  // If there is a triple in the hand that has a lower value than the other
  // cards values,
  if(_cardValues[0] == _cardValues[2]){
    // Set the hands value to be the triples value.
    _handValue = _cardValues[0];
    
    // Return that the hand IS a Triple.
    return YES;
  }
  // If there is a triple in the hand is inbetween the values of the other cards,
  else if(_cardValues[1] == _cardValues[3]){
    // Set the hands value to be the triples value.
    _handValue = _cardValues[1];
    
    // Return that the hand IS a Triple.
    return YES;
  }
  // If there is a triple in the hand that has a greater value than the other
  // cards,
  else if(_cardValues[2] == _cardValues[4]){
    // Set the hands value to be the triples value.
    _handValue = _cardValues[2];
    
    // Return that the hand IS a Triple.
    return YES;
  }
  // Return that the hand is NOT a Triple.
  return NO;
}

- (BOOL)isATwoPair; {
  // The hand is ordered, so there are only 3 cases:
  //
  // Case 1: The pairs values are less than the other cards value.
  //
  // This only happens when card 0 equals card 1 AND card 2 equals card 3.
  //
  // Case 2: The other cards value is inbetween the pairs values.
  //
  //  This only happens when card 0 equals card 1 AND card 3 equals card 4.
  //
  // Case 3: The pairs values are greater than the other cards value.
  //
  // This only happens when card 1 equals card 2 AND card 3 equals card 4.
  
  // If there are 2 pairs with a single card greater than both values,
  if((_cardValues[0] == _cardValues[1]) && (_cardValues[2] == _cardValues[3])){
    // Store the hands value as the highest pairs value.
    _handValue = _cardValues[2];
    
    // Store the hands second value as the lowest pairs value.
    _handValue2 = _cardValues[0];
    
    // Return that the hand IS a Two Pair.
    return YES;
  }
  // If there are 2 pairs with a single card inbetween than both values,
  if((_cardValues[0] == _cardValues[1]) && (_cardValues[3] == _cardValues[4])){
    // Store the hands value as the highest pairs value.
    _handValue = _cardValues[3];
    
    // Store the hands second value as the lowest pairs value.
    _handValue2 = _cardValues[0];
    
    // Return that the hand IS a Two Pair.
    return YES;
  }
  // If there are 2 pairs with a single card less than both values,
  if((_cardValues[1] == _cardValues[2]) && (_cardValues[3] == _cardValues[4])){
    // Store the hands value as the highest pairs value.
    _handValue = _cardValues[3];
    
    // Store the hands second value as the lowest pairs value.
    _handValue2 = _cardValues[1];
    
    // Return that the hand IS a Two Pair.
    return YES;
  }
  // Return that the hand is NOT a Two Pair.
  return NO;
}

- (BOOL)isAStraight; {
  // The hand is ordered. Therefore, we only need to check if every cards value
  // is 1 greater than its neightbour on the left.
  
  // Variable to mark is the hand is a Straight.
  BOOL isAStraight = YES;
  
  // Grab the value of the lowest card in the hand.
  uint lowestCard = _cardValues[0];
  
  // For all the other cards in the hand,
  for(int cardIndex = 1; cardIndex < NumberOfCardsInPokerHand; cardIndex++){
    // If the cards value is NOT equal to the lowerest cards value plus its
    // index in the hand,
    if(_cardValues[cardIndex] != (lowestCard + cardIndex)){
      // Mark that the hand is NOT a Straight.
      isAStraight = NO;
      
      // Break out of the loop.
      break;
    }
  }
  // If the hand IS a Straight,
  if(isAStraight){
    // Set the value of the hand to the highest cards value.
    _handValue = _cardValues[4];
  }
  // Return if the hand is a Straight or NOT.
  return isAStraight;
}

- (BOOL)isAFullHouse; {
  // The hand is ordered, so there are only 2 cases:
  //
  // Case 1: The triples value is less than the pairs value.
  //
  // This only happens when card 0 equals card 2, and card 3 equals card 4.
  //
  // Case 2: The triples value is greater than the pairs value.
  //
  // This only happens when card 2 equals card 4, and card 0 equals card 1.
  
  // If there is a triple in the hand that has a lower value than the other
  // cards values,
  if(_cardValues[0] == _cardValues[2]){
    // If there is a pair in the hand that is greater than the triples value,
    if(_cardValues[3] == _cardValues[4]){
      // Set the hands value to be the triples value.
      _handValue = _cardValues[0];
      
      // Return that the hand is a Full House.
      return YES;
    }
  }
  // If there is a triple in the hand that has a higher value than the other
  // cards values,
  if(_cardValues[2] == _cardValues[4]){
    // If there is a pair in the hand that is less than the triples value,
    if(_cardValues[0] == _cardValues[1]){
      // Set the hands value to be the triples value.
      _handValue = _cardValues[2];
      
      // Return that the hand is a Full House.
      return YES;
    }
  }
  // Return that the hand is NOT a Full House.
  return NO;
}

@end