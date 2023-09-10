//  QuestionAndAnswer.h

#import <Foundation/Foundation.h>
#import "Structures.h"

@protocol QuestionAndAnswerDelegate <NSObject>

- (void)finishedComputing;

@end

@interface QuestionAndAnswer : NSObject {
  id <QuestionAndAnswerDelegate> __weak   _delegate;
  BOOL                                    _isFun;
  BOOL                                    _isUseful;
  BOOL                                    _loadsFile;
  BOOL                                    _usesBigInt;
  BOOL                                    _isComputing;
  BOOL                                    _isChallenging;
  BOOL                                    _isContestMath;
  BOOL                                    _trickRequired;
  BOOL                                    _solvableByHand;
  BOOL                                    _canBeSimplified;
  BOOL                                    _usesCustomObjects;
  BOOL                                    _usesCustomStructs;
  BOOL                                    _usesHelperMethods;
  BOOL                                    _learnedSomethingNew;
  BOOL                                    _requiresMathematics;
  BOOL                                    _hasMultipleSolutions;
  BOOL                                    _relatedToAnotherQuestion;
  BOOL                                    _shouldInvestigateFurther;
  BOOL                                    _usesFunctionalProgramming;
  NSString                              * _date;
  NSString                              * _hint;
  NSString                              * _link;
  NSString                              * _text;
  NSString                              * _title;
  NSString                              * _answer;
  NSString                              * _number;
  NSString                              * _rating;
  NSString                              * _category;
  NSString                              * _keywords;
  NSString                              * _solveTime;
  NSString                              * _technique;
  NSString                              * _difficulty;
  NSString                              * _commentCount;
  NSString                              * _attemptsCount;
  NSString                              * _startedOnDate;
  NSString                              * _educationLevel;
  NSString                              * _completedOnDate;
  NSString                              * _solutionLineCount;
  NSString                              * _estimatedComputationTime;
  NSString                              * _estimatedBruteForceComputationTime;
}

@property (nonatomic, weak)   id <QuestionAndAnswerDelegate>   delegate;
@property (nonatomic, assign) BOOL                             isFun;
@property (nonatomic, assign) BOOL                             isUseful;
@property (nonatomic, assign) BOOL                             loadsFile;
@property (nonatomic, assign) BOOL                             usesBigInt;
@property (nonatomic, assign) BOOL                             isComputing;
@property (nonatomic, assign) BOOL                             isChallenging;
@property (nonatomic, assign) BOOL                             isContestMath;
@property (nonatomic, assign) BOOL                             trickRequired;
@property (nonatomic, assign) BOOL                             solvableByHand;
@property (nonatomic, assign) BOOL                             canBeSimplified;
@property (nonatomic, assign) BOOL                             usesCustomObjects;
@property (nonatomic, assign) BOOL                             usesCustomStructs;
@property (nonatomic, assign) BOOL                             usesHelperMethods;
@property (nonatomic, assign) BOOL                             learnedSomethingNew;
@property (nonatomic, assign) BOOL                             requiresMathematics;
@property (nonatomic, assign) BOOL                             hasMultipleSolutions;
@property (nonatomic, assign) BOOL                             relatedToAnotherQuestion;
@property (nonatomic, assign) BOOL                             shouldInvestigateFurther;
@property (nonatomic, assign) BOOL                             usesFunctionalProgramming;
@property (nonatomic, strong) NSString                       * date;
@property (nonatomic, strong) NSString                       * hint;
@property (nonatomic, strong) NSString                       * link;
@property (nonatomic, strong) NSString                       * text;
@property (nonatomic, strong) NSString                       * title;
@property (nonatomic, strong) NSString                       * answer;
@property (nonatomic, strong) NSString                       * number;
@property (nonatomic, strong) NSString                       * rating;
@property (nonatomic, strong) NSString                       * category;
@property (nonatomic, strong) NSString                       * keywords;
@property (nonatomic, strong) NSString                       * solveTime;
@property (nonatomic, strong) NSString                       * technique;
@property (nonatomic, strong) NSString                       * difficulty;
@property (nonatomic, strong) NSString                       * commentCount;
@property (nonatomic, strong) NSString                       * attemptsCount;
@property (nonatomic, strong) NSString                       * startedOnDate;
@property (nonatomic, strong) NSString                       * educationLevel;
@property (nonatomic, strong) NSString                       * completedOnDate;
@property (nonatomic, strong) NSString                       * solutionLineCount;
@property (nonatomic, strong) NSString                       * estimatedComputationTime;
@property (nonatomic, strong) NSString                       * estimatedBruteForceComputationTime;

// Super methods for setup.
- (void)initialize;
- (void)computeAnswer;
- (void)computeAnswerByBruteForce;

// This method swaps two indices in an int array.
- (void)swapIndex1:(uint)aIndex1 withIndex2:(uint)aIndex2 inArray:(int *)aArray;

// This helper method returns if a number os prime or not.
- (BOOL)isPrime:(int)aNumber;

// This helper method returns if a string is a palindrome or not.
- (BOOL)isStringAPalindrome:(NSString *)aString;

// This helper method returns if it is a perfect square or not.
- (BOOL)isNumberAPerfectSquare:(long long int)aNumber;

// This helper method returns if the current QuestionAndAnswer object is equal
// to a given QuestionAndAnswer object.
- (BOOL)isEqualToQuestionAndAnswer:(QuestionAndAnswer *)aQuestionAndAnswer;

// This helper method returns if a number is 9-lexographic.
- (BOOL)isNumberLexographic:(long long int)aNumber countZero:(BOOL)doesCountZero;

// This helper method checks if an int is a permutation of another int.
- (BOOL)anInt:(uint)aNumber isAPermutationOfInt:(int)aSecondNumber;

// This helper method checks if a number is a permutation of another number.
- (BOOL)number:(long long int)aNumber isAPermutationOfNumber:(long long int)aSecondNumber;

// This helper method returns if a number is lexographic, and only up to a
// maximum digit.
- (BOOL)isNumberLexographic:(long long int)aNumber countZero:(BOOL)doesCountZero maxDigit:(uint)aMaxDigit;

// This helper method returns the gcd of 2 numbers.
- (uint)gcdOfA:(uint)aA b:(uint)aB;

// This helper method returns the smallest factor of a number.
- (uint)leastFactorOf:(uint)aNumber;

// This helper method will take in a number and return the sum of its digits.
- (uint)sumOfDigits:(long long int)aNumber;

// This helper method sums the factorials of the digits of a number.
- (uint)sumOfDigitsFactorials:(uint)aNumber;

// This helper method will take in a number as a string and return the sum of
// its digits.
- (uint)digitSumOfNumber:(NSString *)aNumber;

// This helper method returns a name score for the 26 letters of the alphabet.
- (uint)nameScoreForString:(NSString *)aString;

// This helper method sums all the prime powers of a given prime power.
- (uint)sumOfPowersForPrimePower:(PrimePower)aPrimePower;

// This helper method returns the gcd of 2 numbers using an inputted prime numbers
// array.
- (uint)gcdOfA:(uint)aA b:(uint)aB primeNumbersArray:(NSArray *)aPrimeNumbersArray;

// This helper method calculates the log of a number in any base.
- (double)log:(double)x withBase:(double)aBase;

// This helper method calculates the floored log of a number in any base.
- (double)flooredLog:(double)x withBase:(double)aBase;

// This helper method returns the inputted string reversed.
- (NSString *)reversedString:(NSString *)aString;

// This helper method rotates a string's characters to the left by 1 character.
- (NSString *)rotateStringLeftByOne:(NSString *)aString;

// These helper methods are added so that any Question object can easily compute
// the primes up to a given limit or size. They have been added to the super
// class, as it seems there are a bunch of questions that rely on the primes. It
// also makes it much easier to change/improve later.

- (NSMutableArray *)arrayOfPrimeNumbersOfSize:(uint)aSize;
- (NSMutableArray *)arrayOfPrimeNumbersLessThan:(uint)aLimit;

@end