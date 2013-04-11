//  Question93.m

#import "Question93.h"

@interface Question93 (Private)

- (void)nextPermutation:(int *)aPermutation size:(uint)aSize;
- (void)swapIndex1:(uint)aIndex1 withIndex2:(uint)aIndex2 inArray:(int *)aArray;
- (double)reversePolishNotation:(NSString *)aEquation;

@end

@implementation Question93

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"15 April 2005";
  self.text = @"By using each of the digits from the set, {1, 2, 3, 4}, exactly once, and making use of the four arithmetic operations (+, -, *, /) and brackets/parentheses, it is possible to form different positive integer targets.\n\nFor example,\n\n8 = (4 * (1 + 3)) / 2\n14 = 4 * (3 + 1 / 2)\n19 = 4 * (2 + 3) - 1\n36 = 3 * 4 * (2 + 1)\n\nNote that concatenations of the digits, like 12 + 34, are not allowed.\n\nUsing the set, {1, 2, 3, 4}, it is possible to obtain thirty-one different target numbers of which 36 is the maximum, and each of the numbers 1 to 28 can be obtained before encountering the first non-expressible number.\n\nFind the set of four distinct digits, a < b < c < d, for which the longest set of consecutive positive integers, 1 to n, can be obtained, giving your answer as a string: abcd.";
  self.title = @"Arithmetic expressions";
  self.answer = @"1258";
  self.number = @"93";
  self.estimatedComputationTime = @"7.38";
  self.estimatedBruteForceComputationTime = @"7.38";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply
  
  // http://en.wikipedia.org/wiki/Reverse_Polish_notation
  
  uint largestConsecutiveNumber = 0;
  
  double result = 0.0;
  
  int permutation[4] = {0};
  
  NSArray * sortedResults = nil;
  
  NSNumber * currentNumber = nil;
  
  NSString * equation = nil;
  
  NSString * concatenatedDigits = nil;
  
  NSMutableArray * results = [[NSMutableArray alloc] init];
  
  // Constant array to hold all the operators.
  const NSArray * operators = [NSArray arrayWithObjects:@"+", @"-", @"*", @"/", nil];
  
  NSSortDescriptor * lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
  
  for(int a = 1; a < 10; a++){
    for(int b = (a + 1); b < 10; b++){
      for(int c = (b + 1); c < 10; c++){
        for(int d = (c + 1); d < 10; d++){
          [results removeAllObjects];
          
          for(NSString * operator1 in operators){
            for(NSString * operator2 in operators){
              for(NSString * operator3 in operators){
                
                permutation[0] = a;
                permutation[1] = b;
                permutation[2] = c;
                permutation[3] = d;
                
                while(permutation[0] != 0){
                  equation = [NSString stringWithFormat:@"%d%d%d%@%d%@%@", permutation[0], permutation[1], permutation[2], operator1, permutation[3], operator2, operator3];
                  result = [self reversePolishNotation:equation];
                  
                  if((result != 0.5) && (result > 0.0)){
                    [results addObject:[NSNumber numberWithInt:((uint)result)]];
                  }
                  [self nextPermutation:permutation size:4];
                }
              }
            }
          }
          sortedResults = [[NSSet setWithArray:results] allObjects];
          
          results = [[NSMutableArray alloc] initWithArray:sortedResults];
          
          [results sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
          
          for(int number = 0; number < [results count]; number++){
            currentNumber = [results objectAtIndex:number];
          }
          
          for(int number = 0; number < [results count]; number++){
            currentNumber = [results objectAtIndex:number];
            
            if([currentNumber intValue] != (number + 1)){
              if(largestConsecutiveNumber < number){
                largestConsecutiveNumber = number;
                
                concatenatedDigits = [NSString stringWithFormat:@"%d%d%d%d", a, b, c, d];
              }
              // Break out of the loop.
              break;
            }
          }
          // If we are no longer computing,
          if(!_isComputing){
            // Break out of the loop.
            break;
          }
        }
        // If we are no longer computing,
        if(!_isComputing){
          // Break out of the loop.
          break;
        }
      }
      // If we are no longer computing,
      if(!_isComputing){
        // Break out of the loop.
        break;
      }
    }
    // If we are no longer computing,
    if(!_isComputing){
      // Break out of the loop.
      break;
    }
  }
  // If the user has not cancelled the computation at this point,
  if(_isComputing){
    // Set the answer string to the
    self.answer = concatenatedDigits;
    
    // Get the amount of time that has passed while the computation was happening.
    NSTimeInterval computationTime = [[NSDate date] timeIntervalSinceDate:startTime];
    
    // Set the estimated computation time to the calculated value. We use scientific
    // notation here, as the run time should be very short.
    self.estimatedComputationTime = [NSString stringWithFormat:@"%.03g", computationTime];
  }
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

#pragma mark - Private Methods

@implementation Question93 (Private)

- (void)nextPermutation:(int *)aPermutation size:(uint)aSize; {
  BOOL nextPermutationExists = NO;
  
  int index1 = aSize - 1;
  
  int index2 = aSize;
  
  for(int index = 0; index < (aSize - 1); index++){
    if(aPermutation[index] < aPermutation[index + 1]){
      nextPermutationExists = YES;
      
      break;
    }
  }
  if(nextPermutationExists == NO){
    aPermutation[0] = 0;
    
    return;
  }
  while(aPermutation[index1 - 1] >= aPermutation[index1]){
    index1--;
  }
  while(aPermutation[index2 - 1] <= aPermutation[index1 - 1]){
    index2--;
  }
  [self swapIndex1:(index1 - 1) withIndex2:(index2 - 1) inArray:aPermutation];
  
  index1++;
  index2 = aSize;
  
  while(index1 < index2){
    [self swapIndex1:(index1 - 1) withIndex2:(index2 - 1) inArray:aPermutation];
    index1++;
    index2--;
  }
}

- (void)swapIndex1:(uint)aIndex1 withIndex2:(uint)aIndex2 inArray:(int *)aArray; {
  aArray[aIndex1] += aArray[aIndex2];
  aArray[aIndex2] = aArray[aIndex1] - aArray[aIndex2];
  aArray[aIndex1] -= aArray[aIndex2];
}

- (double)reversePolishNotation:(NSString *)aEquation; {
  // Constant array to hold all the operators.
  const NSArray * operators = [NSArray arrayWithObjects:@"+", @"-", @"*", @"/", nil];
  
  BOOL dividedByZero = NO;
  
  uint operatorIndex = 0;
  
  double result = 0.0f;
  
  uint stringIndex = 0;
  
  // Variable to hold the index and length of the current character.
  NSRange subStringRange;
  
  NSString * element = nil;
  
  NSString * leftHandSide = nil;
  
  NSString * rightHandSide = nil;
  
  NSMutableArray * stack = [[NSMutableArray alloc] init];
  
  while(stringIndex < aEquation.length){
    // Compute the range of the next character.
    subStringRange = NSMakeRange(stringIndex, 1);
    
    element = [aEquation substringWithRange:subStringRange];
    
    operatorIndex = [operators indexOfObject:element];
    
    if(operatorIndex != NSNotFound){
      leftHandSide = [stack lastObject];
      [stack removeLastObject];
      rightHandSide = [stack lastObject];
      [stack removeLastObject];
      switch(operatorIndex){
        case 0:
          result = [leftHandSide doubleValue] + [rightHandSide doubleValue];
          break;
        case 1:
          result = [leftHandSide doubleValue] - [rightHandSide doubleValue];
          break;
        case 2:
          result = [leftHandSide doubleValue] * [rightHandSide doubleValue];
          break;
        case 3:
          if([rightHandSide doubleValue] == 0.0){
            dividedByZero = YES;
          }
          else{
            result = [leftHandSide doubleValue] / [rightHandSide doubleValue];
          }
          break;
        default:
          break;
      }
      if(dividedByZero){
        break;
      }
      [stack addObject:[NSString stringWithFormat:@"%f", result]];
    }
    else{
      [stack addObject:element];
    }
    stringIndex++;
  }
  if(dividedByZero){
    return 0.5;
  }
  result = [[stack lastObject] doubleValue];
  
  if(result != ((double)((uint)result))){
    return 0.5;
  }
  else{
    return result;
  }
}

@end