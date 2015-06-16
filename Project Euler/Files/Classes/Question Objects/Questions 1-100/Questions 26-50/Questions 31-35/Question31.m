//  Question31.m

#import "Question31.h"

@interface Question31 (Private)

- (uint)numberOfCombinationsOfValue:(uint)aValue fromIndex:(uint)aIndex;

@end

@implementation Question31

#define NumberOfDenominations 8

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"22 November 2002";
  self.hint = @"Use a recursive method to figure out the number of combinations of coins for a given currency value.";
  self.text = @"In England the currency is made up of pound, £, and pence, p, and there are eight coins in general circulation:\n\n1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).\n\nIt is possible to make £2 in the following way:\n\n1£1 + 150p + 220p + 15p + 12p + 31p\n\nHow many different ways can £2 be made using any number of coins?";
  self.isFun = NO;
  self.title = @"Coin sums";
  self.answer = @"73682";
  self.number = @"31";
  self.rating = @"4";
  self.keywords = @"pounds,coins,sums,currency,different,unique,ways,two,2,number,combinations,England,pence,general,circulation";
  self.difficulty = @"Medium";
  self.estimatedComputationTime = @"1.54e-04";
  self.estimatedBruteForceComputationTime = @"1.54e-04";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply use a helper method to give us the total number of unique
  // combinations for the given starting value. The helper method explains how
  // it arrives at each value.
  
  // Variable to hold the starting value we are interested in finding the number
  // of unique combinations of the given denominations.
  uint startingValue = 200;
  
  // Variable to hold the number of combinations of the given value.
  uint numberOfCombinationsOfValue = 0;
  
  // For all the different denominations,
  for(int i = 0; i < NumberOfDenominations; i++){
    // Add the number of combinations for this number returned from the helper method.
    numberOfCombinationsOfValue += [self numberOfCombinationsOfValue:startingValue fromIndex:i];
  }
  // Set the answer string to the number of combinations of the value.
  self.answer = [NSString stringWithFormat:@"%d", numberOfCombinationsOfValue];
  
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
  
  // Here, we simply use a helper method to give us the total number of unique
  // combinations for the given starting value. The helper method explains how
  // it arrives at each value.
  
  // Variable to hold the starting value we are interested in finding the number
  // of unique combinations of the given denominations.
  uint startingValue = 200;
  
  // Variable to hold the number of combinations of the given value.
  uint numberOfCombinationsOfValue = 0;
  
  // For all the different denominations,
  for(int i = 0; i < NumberOfDenominations; i++){
    // Add the number of combinations for this number returned from the helper method.
    numberOfCombinationsOfValue += [self numberOfCombinationsOfValue:startingValue fromIndex:i];
  }
  // Set the answer string to the number of combinations of the value.
  self.answer = [NSString stringWithFormat:@"%d", numberOfCombinationsOfValue];
  
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

@implementation Question31 (Private)

- (uint)numberOfCombinationsOfValue:(uint)aValue fromIndex:(uint)aIndex; {
  // This algorithm is pretty straight-forward. We first check to see if the index
  // returned yields a valid denomination. If it does, we continuously remove
  // the current denomination from the value and sum the number of each combinations
  // together to give the result.
  //
  // As an example, suppose the value is 10, and the index is 2 (i.e.: a
  // denomination of 5). Then we have:
  //
  // 10 can be subtracted by 5 twice.
  //
  // The first subtraction gives us a remainder of 5.
  //
  // We then call the method to give us the number of combinations 5 can be written
  // as from the index 1 (i.e.: a denomination of 2).
  //
  // This returns 2, which corresponds to the numbers 2,2,1, and 2,1,1,1.
  //
  // We then add the total number of ways 5 can be written as from the index 0,
  // which is 1.
  //
  // We then subtract off 5 from (10 - 5), giving us 0. Since 5 | 10 (we know
  // this because the remainder is 0), we add one, as 10 can be written as 5,5.
  //
  // Therefore, the total number of ways that one can write write is:
  //
  // 2 + 1 + 1 = 4, which corresponds to (5,5), (5,2,2,1), (5,2,1,1,1), (5,1,1,1,1,1).
  //
  // This process is repeated for every denomination, and the values are totalled.
  
  // Constant array to hold the different denominations.
  const int denominations[NumberOfDenominations] = {1, 2, 5, 10, 20, 50, 100, 200};
  
  // If the index if too large,
  if(aIndex >= NumberOfDenominations){
    // There are no combinations that can be made from this denomination, so return 0.
    return 0;
  }
  // If the index is 0,
  else if(aIndex == 0){
    // There is only 1 way to use the base index to make the value, so return 1.
    return 1;
  }
  // Variable to hold the current value while iterating and subtracting the different
  // denominations.
  int currentValue = aValue;
  
  // Variable to hold the number of combinations to return.
  int numberOfCombinations = 0;
  
  // Variable to hold the current denomination.
  int denomination = denominations[aIndex];
  
  // If the current denomination is greater than the value,
  if(denomination > aValue){
    // There are no combinations that can be made from this denomination, so return 0.
    return 0;
  }
  // If the denomination value is 2,
  else if(denomination == 2){
    // Return the different possible combinations when using 2, which is just
    // half the value.
    return ((uint)(aValue / 2));
  }
  // Decrement the current value by the current denomination.
  currentValue -= denomination;
  
  // While the current value is greater than 0,
  while(currentValue > 0){
    // For all the denominations less than the current denomination,
    for(int i = 0; i < aIndex; i++){
      // Increment the number of combinations by the amount of unique combinations
      // of the current value and all lower denominations.
      numberOfCombinations += [self numberOfCombinationsOfValue:currentValue fromIndex:i];
    }
    // Decrement the current value by the current denomination.
    currentValue -= denomination;
  }
  // If the current value is equal to 0, there is an one more unique way to write
  // the value based on the current denomination, namely, using ONLY the current
  // denomation.
  if(currentValue == 0){
    // Increment the number of combinations by 1.
    numberOfCombinations++;
  }
  // Return the number of combinations.
  return numberOfCombinations;
}

@end