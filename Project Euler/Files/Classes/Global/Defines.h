//  Defines.h

#ifndef Project_Euler_Defines_h
#define Project_Euler_Defines_h

// Defines an IBOutletCollection, in case it is not already defined.
#ifndef IBOutletCollection
#define IBOutletCollection(ClassName)
#endif

// Defines for UI Layout.
#define NumberOfButtonsInQuestionCell 5
#define TotalNumberOfPossibleQuestions 1000

// Defines for Sieve's.
#define MaxSizeOfSieveOfAtkinson 500000
#define MaxSizeOfSieveOfEratosthenes 100000000

// Defines for Poker Object.
#define MaxCardValue 14
#define NumberOfCardsInPokerHand 5
#define MaxCardValuePlus1 (MaxCardValue + 1)

// Define to hold the number of cards in the Chance and Community Chest piles.
#define NumberOfChanceOrCommunityChestCardsToChooseFrom 16

// Define for the total number of valid entries in a Sudoku Group (0-9, where
// 0 represents the unknown square).
#define PotentialNumbers 10

// Define for checking the version number of iOS currently being used.
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] \
compare:v options:NSNumericSearch] == NSOrderedAscending)

#endif