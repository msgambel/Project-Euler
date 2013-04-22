//  Question93.m

#import "Question93.h"

@interface Question93 (Private)

- (void)nextPermutation:(int *)aPermutation size:(uint)aSize;
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
  
  // Here, we simply use Reverse Polish Notation in order to make all of the
  // various permuations. The reason we do this is to avoid using the brackets,
  // which cleans up the code dramtically! We also use a simple permuation
  // method to change the order of the four values. Finally, in order to find
  // all the unique values, we simply store all the values in an NSArray, and
  // use an NSSet to remove all of the copies. We re-order the values, and then
  // iterate through until we find a skipped number. For more information about
  // Reverse Polish Notation, visit:
  //
  // http://en.wikipedia.org/wiki/Reverse_Polish_notation
  
  // Variable to hold the largest consecutive number found for all the different
  // permutations of the four digits.
  uint largestConsecutiveNumber = 0;
  
  // Variable to hold the result of the current Reverse Polish Notation Equation.
  double result = 0.0;
  
  // Variable array to hold the current permutation of the different
  // permutations of the four digits.
  int permutation[4] = {0};
  
  // Variable array to hold the unique results of all the different permutations
  // of the four digits.
  NSArray * uniqueResults = nil;
  
  // Variable to hold the current number of the results of the Reverse Polish
  // Notation Equations for all the different permutations of the four digits.
  NSNumber * currentNumber = nil;
  
  // Variable to hold the Equation of all the different permutations of the four
  // digits.
  NSString * equation = nil;
  
  // Variable to hold the concatenated four digits
  NSString * concatenatedDigits = nil;
  
  // Variable to hold the results of all the different permutations of the four
  // digits.
  NSMutableArray * results = [[NSMutableArray alloc] init];
  
  // Constant array to hold all the operators.
  const NSArray * operators = [NSArray arrayWithObjects:@"+", @"-", @"*", @"/", nil];
  
  // Variable to sort the NSNumbers from lowest to highest.
  NSSortDescriptor * lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
  
  // For all the digits from 1 to 6,
  for(int a = 1; a < 7; a++){
    // For all the digits from (a + 1) to 7,
    for(int b = (a + 1); b < 8; b++){
      // For all the digits from (b + 1) to 8,
      for(int c = (b + 1); c < 9; c++){
        // For all the digits from (c + 1) to 9,
        for(int d = (c + 1); d < 10; d++){
          // Remove all the results of the previous four digits.
          [results removeAllObjects];
          
          // For all the operators in the operators array,
          for(NSString * operator1 in operators){
            // For all the operators in the operators array,
            for(NSString * operator2 in operators){
              // For all the operators in the operators array,
              for(NSString * operator3 in operators){
                // Set the first element of the permuation to the smallest digit.
                permutation[0] = a;
                
                // Set the second element of the permuation to the second
                // smallest digit.
                permutation[1] = b;
                
                // Set the third element of the permuation to the second largest
                // digit.
                permutation[2] = c;
                
                // Set the fourth element of the permuation to the largest digit.
                permutation[3] = d;
                
                // While we still have a valid permutation,
                while(permutation[0] != 0){
                  // Set the Reverse Polish Notation Equation of the current
                  // permutation of the four digits.
                  equation = [NSString stringWithFormat:@"%d%d%d%@%d%@%@", permutation[0], permutation[1], permutation[2], operator1, permutation[3], operator2, operator3];
                  
                  // Grab the result of the computation of the Reverse Polish
                  // Notation Equation.
                  result = [self reversePolishNotation:equation];
                  
                  // If the result is a non-negative integer,
                  if((result != 0.5) && (result > 0.0)){
                    // Add the result to the results array.
                    [results addObject:[NSNumber numberWithInt:((uint)result)]];
                  }
                  // Compute the next permutation of the four digits.
                  [self nextPermutation:permutation size:4];
                }
              }
            }
          }
          // Use an NSSet to remove all of the copies, and put the unique set
          // into a new array.
          uniqueResults = [[NSSet setWithArray:results] allObjects];
          
          // Put the results into an NSMutable array for sorting.
          results = [[NSMutableArray alloc] initWithArray:uniqueResults];
          
          // Sort the numbers in increasing order.
          [results sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
          
          // For all the numbers in the sorted results array,
          for(int number = 0; number < [results count]; number++){
            // Grab the current number in the sorted results array.
            currentNumber = [results objectAtIndex:number];
            
            // If the number is NOT equal to its index (add 1, as the array is
            // 0 indexed),
            if([currentNumber intValue] != (number + 1)){
              // If the largest consecutive number is less than the current
              // largest consecutive number,
              if(largestConsecutiveNumber < number){
                // Set the largest consecutive number found to the current
                // number.
                largestConsecutiveNumber = number;
                
                // Set the digits that create the largest consecutive number to
                // the current four numbers.
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
  
  // Here, we simply use Reverse Polish Notation in order to make all of the
  // various permuations. The reason we do this is to avoid using the brackets,
  // which cleans up the code dramtically! We also use a simple permuation
  // method to change the order of the four values. Finally, in order to find
  // all the unique values, we simply store all the values in an NSArray, and
  // use an NSSet to remove all of the copies. We re-order the values, and then
  // iterate through until we find a skipped number. For more information about
  // Reverse Polish Notation, visit:
  //
  // http://en.wikipedia.org/wiki/Reverse_Polish_notation
  
  // Variable to hold the largest consecutive number found for all the different
  // permutations of the four digits.
  uint largestConsecutiveNumber = 0;
  
  // Variable to hold the result of the current Reverse Polish Notation Equation.
  double result = 0.0;
  
  // Variable array to hold the current permutation of the different
  // permutations of the four digits.
  int permutation[4] = {0};
  
  // Variable array to hold the unique results of all the different permutations
  // of the four digits.
  NSArray * uniqueResults = nil;
  
  // Variable to hold the current number of the results of the Reverse Polish
  // Notation Equations for all the different permutations of the four digits.
  NSNumber * currentNumber = nil;
  
  // Variable to hold the Equation of all the different permutations of the four
  // digits.
  NSString * equation = nil;
  
  // Variable to hold the concatenated four digits
  NSString * concatenatedDigits = nil;
  
  // Variable to hold the results of all the different permutations of the four
  // digits.
  NSMutableArray * results = [[NSMutableArray alloc] init];
  
  // Constant array to hold all the operators.
  const NSArray * operators = [NSArray arrayWithObjects:@"+", @"-", @"*", @"/", nil];
  
  // Variable to sort the NSNumbers from lowest to highest.
  NSSortDescriptor * lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
  
  // For all the digits from 1 to 6,
  for(int a = 1; a < 7; a++){
    // For all the digits from (a + 1) to 7,
    for(int b = (a + 1); b < 8; b++){
      // For all the digits from (b + 1) to 8,
      for(int c = (b + 1); c < 9; c++){
        // For all the digits from (c + 1) to 9,
        for(int d = (c + 1); d < 10; d++){
          // Remove all the results of the previous four digits.
          [results removeAllObjects];
          
          // For all the operators in the operators array,
          for(NSString * operator1 in operators){
            // For all the operators in the operators array,
            for(NSString * operator2 in operators){
              // For all the operators in the operators array,
              for(NSString * operator3 in operators){
                // Set the first element of the permuation to the smallest digit.
                permutation[0] = a;
                
                // Set the second element of the permuation to the second
                // smallest digit.
                permutation[1] = b;
                
                // Set the third element of the permuation to the second largest
                // digit.
                permutation[2] = c;
                
                // Set the fourth element of the permuation to the largest digit.
                permutation[3] = d;
                
                // While we still have a valid permutation,
                while(permutation[0] != 0){
                  // Set the Reverse Polish Notation Equation of the current
                  // permutation of the four digits.
                  equation = [NSString stringWithFormat:@"%d%d%d%@%d%@%@", permutation[0], permutation[1], permutation[2], operator1, permutation[3], operator2, operator3];
                  
                  // Grab the result of the computation of the Reverse Polish
                  // Notation Equation.
                  result = [self reversePolishNotation:equation];
                  
                  // If the result is a non-negative integer,
                  if((result != 0.5) && (result > 0.0)){
                    // Add the result to the results array.
                    [results addObject:[NSNumber numberWithInt:((uint)result)]];
                  }
                  // Compute the next permutation of the four digits.
                  [self nextPermutation:permutation size:4];
                }
              }
            }
          }
          // Use an NSSet to remove all of the copies, and put the unique set
          // into a new array.
          uniqueResults = [[NSSet setWithArray:results] allObjects];
          
          // Put the results into an NSMutable array for sorting.
          results = [[NSMutableArray alloc] initWithArray:uniqueResults];
          
          // Sort the numbers in increasing order.
          [results sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
          
          // For all the numbers in the sorted results array,
          for(int number = 0; number < [results count]; number++){
            // Grab the current number in the sorted results array.
            currentNumber = [results objectAtIndex:number];
            
            // If the number is NOT equal to its index (add 1, as the array is
            // 0 indexed),
            if([currentNumber intValue] != (number + 1)){
              // If the largest consecutive number is less than the current
              // largest consecutive number,
              if(largestConsecutiveNumber < number){
                // Set the largest consecutive number found to the current
                // number.
                largestConsecutiveNumber = number;
                
                // Set the digits that create the largest consecutive number to
                // the current four numbers.
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
    self.estimatedBruteForceComputationTime = [NSString stringWithFormat:@"%.03g", computationTime];
  }
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