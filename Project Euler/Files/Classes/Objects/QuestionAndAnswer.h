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

@end