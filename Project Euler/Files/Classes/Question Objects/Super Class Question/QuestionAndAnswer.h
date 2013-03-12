//  QuestionAndAnswer.h

#import <Foundation/Foundation.h>

@protocol QuestionAndAnswerDelegate <NSObject>

- (void)finishedComputing;

@end

@interface QuestionAndAnswer : NSObject {
  id <QuestionAndAnswerDelegate> __weak _delegate;
  
  BOOL       _isComputing;
  NSString * _date;
  NSString * _text;
  NSString * _title;
  NSString * _answer;
  NSString * _number;
  NSString * _estimatedComputationTime;
  NSString * _estimatedBruteForceComputationTime;
}

@property (nonatomic, weak)   id <QuestionAndAnswerDelegate> delegate;

@property (nonatomic, assign) BOOL       isComputing;
@property (nonatomic, strong) NSString * date;
@property (nonatomic, strong) NSString * text;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * answer;
@property (nonatomic, strong) NSString * number;
@property (nonatomic, strong) NSString * estimatedComputationTime;
@property (nonatomic, strong) NSString * estimatedBruteForceComputationTime;

- (void)initialize;
- (void)computeAnswer;
- (void)computeAnswerByBruteForce;

// This helper method returns if a number os prime or not.
- (BOOL)isPrime:(int)aNumber;

// This helper method returns if it is a perfect square or not.
- (BOOL)isNumberAPerfectSquare:(long long int)aNumber;

// This helper method returns if a string is a palindrome or not.
- (BOOL)isStringAPalindrome:(NSString *)aString;

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

// This helper method will take in a number as a string and return the sum of
// its digits.
- (uint)digitSumOfNumber:(NSString *)aNumber;

// This helper method returns a name score for the 26 letters of the alphabet.
- (uint)nameScoreForString:(NSString *)aString;

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