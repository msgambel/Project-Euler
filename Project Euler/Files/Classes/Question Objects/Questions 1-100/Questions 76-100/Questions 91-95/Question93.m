//  Question93.m

#import "Question93.h"
#import "Enumerations.h"

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
  self.hint = @"Reverse Polish Notation should do the trick.";
  self.text = @"By using each of the digits from the set, {1, 2, 3, 4}, exactly once, and making use of the four arithmetic operations (+, -, *, /) and brackets/parentheses, it is possible to form different positive integer targets.\n\nFor example,\n\n8 = (4 * (1 + 3)) / 2\n14 = 4 * (3 + 1 / 2)\n19 = 4 * (2 + 3) - 1\n36 = 3 * 4 * (2 + 1)\n\nNote that concatenations of the digits, like 12 + 34, are not allowed.\n\nUsing the set, {1, 2, 3, 4}, it is possible to obtain thirty-one different target numbers of which 36 is the maximum, and each of the numbers 1 to 28 can be obtained before encountering the first non-expressible number.\n\nFind the set of four distinct digits, a < b < c < d, for which the longest set of consecutive positive integers, 1 to n, can be obtained, giving your answer as a string: abcd.";
  self.isFun = NO;
  self.title = @"Arithmetic expressions";
  self.answer = @"1258";
  self.number = @"93";
  self.rating = @"5";
  self.keywords = @"arithmetic,expressions,reverse,polish,notation,set,notation,1,2,3,4,one,two,three,four,consecutive,positive,integers,string,distinct,digits";
  self.difficulty = @"Medium";
  self.solutionLineCount = @"117";
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
  // Variable to mark if there is a larger permuation.
  BOOL nextPermutationExists = NO;
  
  // Variable to mark the index of the first number to swap.
  int index1 = aSize - 1;
  
  // Variable to mark the index of the second number to swap.
  int index2 = aSize;
  
  // For all the indices up to the second last index,
  for(int index = 0; index < (aSize - 1); index++){
    // If the number at the current index is smaller then the number in the next
    // index,
    if(aPermutation[index] < aPermutation[index + 1]){
      // Mark that there is a larger permutation.
      nextPermutationExists = YES;
      
      // Break out of the loop.
      break;
    }
  }
  // If a larger permuation does NOT exist,
  if(nextPermutationExists == NO){
    // Set the number in the first index to 0 to mark that we have iterated
    // through all of the possible permutations.
    aPermutation[0] = 0;
    
    // Return our of the method.
    return;
  }
  // While the number at the current index is smaller than the number at the
  // previous index,
  while(aPermutation[index1 - 1] >= aPermutation[index1]){
    // Decrement the first index by 1.
    index1--;
  }
  // While the number at the current second index is smaller than the number at
  // index to the left of the first index,
  while(aPermutation[index2 - 1] <= aPermutation[index1 - 1]){
    // Decrement the second index by 1.
    index2--;
  }
  // Swap the index to the left of the first index with the index to the left of
  // the second index.
  [self swapIndex1:(index1 - 1) withIndex2:(index2 - 1) inArray:aPermutation];
  
  // Increment the first index by 1.
  index1++;
  
  // Reset the second index to the index to the right of the last index.
  index2 = aSize;
  
  // While the first index is less than the second index,,
  while(index1 < index2){
    // Swap the index to the left of the first index with the index to the left of
    // the second index.
    [self swapIndex1:(index1 - 1) withIndex2:(index2 - 1) inArray:aPermutation];
    
    // Increment the first index by 1.
    index1++;
    
    // Decrement the second index by 1.
    index2--;
  }
}

- (double)reversePolishNotation:(NSString *)aEquation; {
  // This method compute a Reverse Polish Notation Equation. If a valid integer
  // is computed, it is returned. Otherwise, a default value of 0.5 is returned,
  // signifiying that the result is NOT an integer.
  
  // Constant array to hold all the operators.
  const NSArray * operators = [NSArray arrayWithObjects:@"+", @"-", @"*", @"/", nil];
  
  // Variable to mark if the equation resulted in a division by 0 or not.
  BOOL dividedByZero = NO;
  
  // Variable to mark the index of the operator in the operators array when
  // parsing through an equation.
  long long int operatorIndex = 0;
  
  // Variable to hold the result of the Reverse Polish Notation Equation.
  double result = 0.0f;
  
  // Variable to hold the character index in the equation.
  uint characterIndex = 0;
  
  // Variable to hold the index and length of the current character.
  NSRange subStringRange;
  
  // Variable to hold the current element of the equation.
  NSString * element = nil;
  
  // Variable to hold the left hand side of the current pass of the equation.
  NSString * leftHandSide = nil;
  
  // Variable to hold the right hand side of the current pass of the equation.
  NSString * rightHandSide = nil;
  
  // Variable array to hold the elements of the equation for computing later.
  NSMutableArray * stack = [[NSMutableArray alloc] init];
  
  // While the character index is less than the length of the equation,
  while(characterIndex < aEquation.length){
    // Compute the range of the next character.
    subStringRange = NSMakeRange(characterIndex, 1);
    
    // Grab the element of the equation at the current index.
    element = [aEquation substringWithRange:subStringRange];
    
    // Grab the index in the operators array of the element.
    operatorIndex = (uint)[operators indexOfObject:element];
    
    // If the index is valid,
    if(operatorIndex != NSNotFound){
      // Grab the left hand side of the current pass of the equation.
      leftHandSide = [stack lastObject];
      
      // Remove the left hand side from the equation.
      [stack removeLastObject];
      
      // Grab the left hand side of the current pass of the equation.
      rightHandSide = [stack lastObject];
      
      // Remove the right hand side from the equation.
      [stack removeLastObject];
      
      // Depending on the operator,
      switch(operatorIndex){
          // If the operator is Addition,
        case OperatorType_Addition:
          // Add the left hand side and right hand side of the equation.
          result = [leftHandSide doubleValue] + [rightHandSide doubleValue];
          
          // Break out of the switch statement.
          break;
          // If the operator is Subtraction,
        case OperatorType_Subtraction:
          // Subtract the left hand side and right hand side of the equation.
          result = [leftHandSide doubleValue] - [rightHandSide doubleValue];
          
          // Break out of the switch statement.
          break;
          // If the operator is Multiplication,
        case OperatorType_Multiplication:
          // Multiply the left hand side and right hand side of the equation.
          result = [leftHandSide doubleValue] * [rightHandSide doubleValue];
          
          // Break out of the switch statement.
          break;
          // If the operator is Division,
        case OperatorType_Division:
          // If the right hand side of the equation is 0,
          if([rightHandSide doubleValue] == 0.0){
            // Mark that the equation tried to divide by 0.
            dividedByZero = YES;
          }
          // If the right hand side of the equation is NOT 0,
          else{
            // Divide the left hand side and right hand side of the equation.
            result = [leftHandSide doubleValue] / [rightHandSide doubleValue];
          }
          // Break out of the switch statement.
          break;
          // If the operator is NOT valid,
        default:
          // Break out of the switch statement.
          break;
      }
      // If the equation tried to divide by 0,
      if(dividedByZero){
        // Break out of the loop.
        break;
      }
      // Add the result of the left hand side and the right hand side to the
      // equation.
      [stack addObject:[NSString stringWithFormat:@"%f", result]];
    }
    // If the index is NOT valid,
    else{
      // Add the value to the equation.
      [stack addObject:element];
    }
    // Increment the character index by 1.
    characterIndex++;
  }
  // If the equation tried to divide by 0,
  if(dividedByZero){
    // Return the default value of 0.5 to signify the equation was not valid.
    return 0.5;
  }
  // Grab the result of the equation.
  result = [[stack lastObject] doubleValue];
  
  // If the equation is NOT an integer,
  if(result != ((double)((uint)result))){
    // Return the default value of 0.5 to signify the equation was not valid.
    return 0.5;
  }
  // If the equation is an integer,
  else{
    // Return the valid result of the equation.
    return result;
  }
}

@end