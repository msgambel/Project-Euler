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

// This number returns if it is a perfect square or not.
- (BOOL)isNumberAPerfectSquare:(uint)aNumber;

// This helper method returns if a string is a palindrome or not.
- (BOOL)isStringAPalindrome:(NSString *)aString;

// This helper method returns if a number is 9-lexographic.
- (BOOL)isNumberLexographic:(long long int)aNumber countZero:(BOOL)doesCountZero;

// This helper method returns the gcd of 2 numbers.
- (uint)gcdOfA:(uint)aA b:(uint)aB;

// This helper method will take in a number as a string and return the sum of
// its digits.
- (uint)digitSumOfNumber:(NSString *)aNumber;

// This helper method calculates the log of a number in any base.
- (double)log:(double)x withBase:(double)aBase;

// This helper method calculates the floored log of a number in any base.
- (double)flooredLog:(double)x withBase:(double)aBase;

// This helper method rotates a string's characters to the left by 1 character.
- (NSString *)rotateStringLeftByOne:(NSString *)aString;

// These helper methods are added so that any Question object can easily compute
// the primes up to a given limit or size. They have been added to the super
// class, as it seems there are a bunch of questions that rely on the primes. It
// also makes it much easier to change/improve later.

- (NSMutableArray *)arrayOfPrimeNumbersOfSize:(uint)aSize;
- (NSMutableArray *)arrayOfPrimeNumbersLessThan:(uint)aLimit;

@end