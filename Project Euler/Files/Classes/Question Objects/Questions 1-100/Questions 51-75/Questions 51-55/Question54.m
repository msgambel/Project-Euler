//  Question54.m

#import "Question54.h"
#import "PokerHand.h"

@implementation Question54

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"10 October 2003";
  self.hint = @"Make an object that can score a hand and compare itself with other hands.";
  self.link = @"https://en.wikipedia.org/wiki/Poker";
  self.text = @"In the card game poker, a hand consists of five cards and are ranked, from lowest to highest, in the following way:\n\nHigh Card: Highest value card.\nOne Pair: Two cards of the same value.\nTwo Pairs: Two different pairs.\nThree of a Kind: Three cards of the same value.\nStraight: All cards are consecutive values.\nFlush: All cards of the same suit.\nFull House: Three of a kind and a pair.\nFour of a Kind: Four cards of the same value.\nStraight Flush: All cards are consecutive values of same suit.\nRoyal Flush: Ten, Jack, Queen, King, Ace, in same suit.\n\nThe cards are valued in the order:\n2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace.\n\nIf two players have the same ranked hands then the rank made up of the highest value wins; for example, a pair of eights beats a pair of fives (see example 1 below). But if two ranks tie, for example, both players have a pair of queens, then highest cards in each hand are compared (see example 4 below); if the highest cards tie then the next highest cards are compared, and so on.\n\nConsider the following five hands dealt to two players:\n\nHand	 	Player 1	 	Player 2	 	Winner\n1	 	5H 5C 6S 7S KD\nPair of Fives\n2C 3S 8S 8D TD\nPair of Eights\nPlayer 2\n2	 	5D 8C 9S JS AC\nHighest card Ace\n2C 5C 7D 8S QH\nHighest card Queen\nPlayer 1\n3	 	2D 9C AS AH AC\nThree Aces\n3D 6D 7D TD QD\nFlush with Diamonds\nPlayer 2\n4	 	4D 6S 9H QH QC\nPair of Queens\nHighest card Nine\n3D 6D 7H QD QS\nPair of Queens\nHighest card Seven\nPlayer 1\n5	 	2H 2D 4C 4D 4S\nFull House\nWith Three Fours\n3C 3D 3S 9S 9D\nFull House\nwith Three Threes\nPlayer 1\n\nThe file, poker.txt, contains one-thousand random hands dealt to two players. Each line of the file contains ten cards (separated by a single space): the first five are Player 1's cards and the last five are Player 2's cards. You can assume that all hands are valid (no invalid characters or repeated cards), each player's hand is in no specific order, and in each hand there is a clear winner.\n\nHow many hands does Player 1 win?";
  self.isFun = YES;
  self.title = @"Poker hands";
  self.answer = @"376";
  self.number = @"54";
  self.rating = @"5";
  self.category = @"Patterns";
  self.keywords = @"poker,hands,two,player,import,rank,compare,5,five,clear,winner,specific,order";
  self.solveTime = @"300";
  self.technique = @"OOP";
  self.difficulty = @"Easy";
  self.commentCount = @"24";
  self.isChallenging = YES;
  self.completedOnDate = @"23/02/13";
  self.solutionLineCount = @"51";
  self.usesHelperMethods = YES;
  self.estimatedComputationTime = @"3.43e-02";
  self.estimatedBruteForceComputationTime = @"3.43e-02";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply use a PokerHand object which handles figuring out the hands
  // value, as well as comparing itself with another hand.
  //
  // We read in the file and make two new PokerHand's for each line in the file.
  
  // Variable to hold the number of times the first poker hand beats the second
  // poker hand.
  uint numberOfHandsPlayer1Wins = 0;
  
  // Variable to hold the path to the file that holds the poker hand data.
  NSString * path = [[NSBundle mainBundle] pathForResource:@"pokerQuestion54" ofType:@"txt"];
  
  // Variable to hold the data from the above file as a string.
  NSString * listOfPokerHands = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
  
  // Variable array to the list of poker hands contained in the above string.
  NSArray * handsArray = [listOfPokerHands componentsSeparatedByString:@"\n"];
  
  // Variable to hold the cards for both hands to compare in each line.
  NSArray * cardsArray = nil;
  
  // Variable to hold the first poker hand.
  PokerHand * pokerHand1 = nil;
  
  // Variable to hold the second poker hand.
  PokerHand * pokerHand2 = nil;
  
  // For all the hands to compare,
  for(NSString * allCards in handsArray){
    // Get the individual cards in both hands.
    cardsArray = [allCards componentsSeparatedByString:@" "];
    
    // Initialize a new poker hand for player 1.
    pokerHand1 = [[PokerHand alloc] init];
    
    // Initialize a new poker hand for player 2.
    pokerHand2 = [[PokerHand alloc] init];
    
    // For all the cards in a Poker Hand,
    for(int cardIndex = 0; cardIndex < NumberOfCardsInPokerHand; cardIndex++){
      // Add a card from the first 5 cards to the first Poker Hand.
      [pokerHand1 addCard:[cardsArray objectAtIndex:cardIndex]];
      
      // Add a card from the second 5 cards to the first Poker Hand.
      [pokerHand2 addCard:[cardsArray objectAtIndex:(cardIndex + NumberOfCardsInPokerHand)]];
    }
    // If the first Poker Hand is better than the second Poker Hand,
    if([pokerHand1 isBetterThanHand:pokerHand2]){
      // Incremenr the number of player 1 wins by 1.
      numberOfHandsPlayer1Wins++;
    }
  }
  // Set the answer string to the number of hands that player1 wins.
  self.answer = [NSString stringWithFormat:@"%d", numberOfHandsPlayer1Wins];
  
  // Get the amount of time that has passed while the computation was happening.
  NSTimeInterval computationTime = [[NSDate date] timeIntervalSinceDate:startTime];
  
  // Set the estimated computation time to the calculated value. We use scientific
  // notation here, as the run time should be very short.
  self.estimatedComputationTime = [NSString stringWithFormat:@"%.03g", computationTime];
  
  // Tell the delegate we have finished the computation.
  [self.delegate finishedComputing];
  
  // Set that we have finished the computation.
  _isComputing = NO;
}

- (void)computeAnswerByBruteForce; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Note: This is the same algorithm as the optimal one. I can't think of a more
  //       brute force way to do this!
  
  // Here, we simply use a PokerHand object which handles figuring out the hands
  // value, as well as comparing itself with another hand.
  //
  // We read in the file and make two new PokerHand's for each line in the file.
  
  // Variable to hold the number of times the first poker hand beats the second
  // poker hand.
  uint numberOfHandsPlayer1Wins = 0;
  
  // Variable to hold the path to the file that holds the poker hand data.
  NSString * path = [[NSBundle mainBundle] pathForResource:@"pokerQuestion54" ofType:@"txt"];
  
  // Variable to hold the data from the above file as a string.
  NSString * listOfPokerHands = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
  
  // Variable array to the list of words contained in the above string.
  NSArray * handsArray = [listOfPokerHands componentsSeparatedByString:@"\n"];
  
  // Variable to hold the cards for both hands to compare in each line.
  NSArray * cardsArray = nil;
  
  // Variable to hold the first poker hand.
  PokerHand * pokerHand1 = nil;
  
  // Variable to hold the second poker hand.
  PokerHand * pokerHand2 = nil;
  
  // For all the hands to compare,
  for(NSString * allCards in handsArray){
    // Get the individual cards in both hands.
    cardsArray = [allCards componentsSeparatedByString:@" "];
    
    // Initialize a new poker hand for player 1.
    pokerHand1 = [[PokerHand alloc] init];
    
    // Initialize a new poker hand for player 2.
    pokerHand2 = [[PokerHand alloc] init];
    
    // For all the cards in a Poker Hand,
    for(int cardIndex = 0; cardIndex < NumberOfCardsInPokerHand; cardIndex++){
      // Add a card from the first 5 cards to the first Poker Hand.
      [pokerHand1 addCard:[cardsArray objectAtIndex:cardIndex]];
      
      // Add a card from the second 5 cards to the first Poker Hand.
      [pokerHand2 addCard:[cardsArray objectAtIndex:(cardIndex + NumberOfCardsInPokerHand)]];
    }
    // If the first Poker Hand is better than the second Poker Hand,
    if([pokerHand1 isBetterThanHand:pokerHand2]){
      // Incremenr the number of player 1 wins by 1.
      numberOfHandsPlayer1Wins++;
    }
  }
  // Set the answer string to the number of hands that player1 wins.
  self.answer = [NSString stringWithFormat:@"%d", numberOfHandsPlayer1Wins];
  
  // Get the amount of time that has passed while the computation was happening.
  NSTimeInterval computationTime = [[NSDate date] timeIntervalSinceDate:startTime];
  
  // Set the estimated computation time to the calculated value. We use scientific
  // notation here, as the run time should be very short.
  self.estimatedBruteForceComputationTime = [NSString stringWithFormat:@"%.03g", computationTime];
  
  // Tell the delegate we have finished the computation.
  [self.delegate finishedComputing];
  
  // Set that we have finished the computation.
  _isComputing = NO;
}

@end