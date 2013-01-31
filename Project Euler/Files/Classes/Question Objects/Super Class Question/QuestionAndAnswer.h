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

// This helper method returns if a number is 9-lexographic.
- (BOOL)isNumberLexographic:(long long int)aNumber countZero:(BOOL)doesCountZero;

// This helper method will take in a number as a string and return the sum of
// its digits.
- (uint)digitSumOfNumber:(NSString *)aNumber;

// These helper methods are added so that any Question object can easily compute
// the primes up to a given limit or size. They have been added to the super
// class, as it seems there are a bunch of questions that rely on the primes. It
// also makes it much easier to change/improve later.

- (NSMutableArray *)arrayOfPrimeNumbersOfSize:(uint)aSize;
- (NSMutableArray *)arrayOfPrimeNumbersLessThan:(uint)aLimit;

@end