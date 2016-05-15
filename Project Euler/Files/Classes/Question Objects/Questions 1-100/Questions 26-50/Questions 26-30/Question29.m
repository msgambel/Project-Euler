//  Question29.m

#import "Question29.h"
#import "BigInt.h"
#import "Global.h"

@implementation Question29

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"25 October 2002";
  self.hint = @"Reduce the base/power forms into prime powers, and remove the duplicates.";
  self.text = @"Consider all integer combinations of a^b for 2 ≤ a ≤ 5 and 2 ≤ b ≤ 5:\n\n2²=4, 2³=8, 2⁴=16, 2⁵=32\n3²=9, 3³=27, 3⁴=81, 3⁵=243\n4²=16, 4³=64, 4⁴=256, 4⁵=1024\n5²=25, 5³=125, 5⁴=625, 5⁵=3125\n\nIf they are then placed in numerical order, with any repeats removed, we get the following sequence of 15 distinct terms:\n\n4, 8, 9, 16, 25, 27, 32, 64, 81, 125, 243, 256, 625, 1024, 3125\n\nHow many distinct terms are in the sequence generated by a^b for 2 ≤ a ≤ 100 and 2 ≤ b ≤ 100?";
  self.isFun = YES;
  self.title = @"Distinct powers";
  self.answer = @"9183";
  self.number = @"29";
  self.rating = @"3";
  self.keywords = @"base,power,unique,integer,combinations,numerical,order,distinct,sequence,repeats,removed,terms,generated,pairs,one,hundred,100";
  self.solveTime = @"60";
  self.difficulty = @"Easy";
  self.completedOnDate = @"29/01/13";
  self.solutionLineCount = @"45";
  self.estimatedComputationTime = @"7.52e-03";
  self.estimatedBruteForceComputationTime = @"8.77";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we check all the numbers from the minimum base/power pair to the
  // maximum base/power pair, and mark which pairs can be reduced to a lower
  // form. For example, 4 can be reduced, as 2² = 4.
  //
  // Therefore, by marking the numbers that need to be checked, we can simply
  // reduce them to lowest base/power form, check them against all the numbers
  // that may also cause a duplicate, and ignore the copies.
  //
  // The only numbers that may cause issues are the ones less than or equal to
  // the inverse of the minimum power of the maximum base (In this case, 1/2,
  // or square root), as the only numbers that could have a potentially equal
  // base are the ones whose first few powers are less than the maximum base.
  
  // Variable to hold the result of a base to a power. Used only in finding the
  // duplicate pairs.
  uint result = 0;
  
  // Variable to hold the maximum base we are looking at.
  uint maxBase = 100;
  
  // Variable to hold the minimum base we are looking at.
  uint minBase = 2;
  
  // Variable to hold the maximum power we are looking at.
  uint maxPower = 100;
  
  // Variable to hold the minimum power we are looking at.
  uint minPower = 2;
  
  // Variable to hold the total number of unchecked base/power pairs.
  uint totalUnchecked = 0;
  
  // Variable to hold the maximum number of potential powers we will have given
  // the above variable (Note: +1 because the list is inclusive).
  uint maxPotentialPowers = (maxBase - minBase + 1) * (maxPower - minPower + 1);
  
  // Variable to hold the number of unique base/power pairs currently found.
  uint currentNumberOfUniquePowers = 0;
  
  // Variable to hold the maximum number of exception numbers we need to look at.
  uint maxBaseToCheck = ((uint)pow(((double)maxBase), (1.0 / ((double)minPower))));
  
  // Variable to hold the current base/power pair.
  PrimePower currentPower = PrimePowerZero;
  
  // Variable to hold if the current number is a potential duplicate number that
  // needs to be handled separately (e.g.: 4 is, as 2² = 4).
  PrimePower numberIsAPower[(maxBase + 1)];
  
  // Variable array to hold the unique base/power pairs currently found.
  PrimePower uniquePowers[maxPotentialPowers];
  
  // For all the bases from the minimum base to the maximum base inclusive,
  for(int base = minBase; base <= maxBase; base++){
    // Default the base to be 0, and the power to be 1.
    numberIsAPower[base] = PrimePowerMake(0, 1);
  }
  // For all the bases from the minimum base to the maximum base inclusive,
  for(int base = minBase; base <= maxBase; base++){
    // If the base is less than or equal to the maximum base to check,
    if(base <= maxBaseToCheck){
      // If the number has not already been marked, (e.g.: 16 could be marked by
      // 2 and 4, as 2⁴ = 4² = 16).
      if(numberIsAPower[base].primeNumber == 0){
        // For all the powers from the minimum power to the maximum power inclusive,
        for(int power = minPower; power <= maxPower; power++){
          // Compute the result of the base to the current power.
          result = (uint)pow(((double)base), ((double)power));
          
          // If the result is a valid base to check,
          if(result <= maxBase){
            // Mark the current base as it's true base, and the power that it is
            // (i.e.: 4 would be (2,2)).
            numberIsAPower[result] = PrimePowerMake(base, power);
          }
          // If the result is NOT a valid base to check,
          else{
            // Break out of the loop.
            break;
          }
        }
      }
    }
    // If the base is greater than the maximum base to check,
    else{
      // Break out of the loop.
      break;
    }
  }
  // For all the bases from the minimum base to the maximum base inclusive,
  for(int base = minBase; base <= maxBase; base++){
    // If the current number is has been detected above as a potential duplicate
    // base/power pair,
    if(numberIsAPower[base].primeNumber != 0){
      // For all the powers from the minimum power to the maximum power inclusive,
      for(int power = minPower; power <= maxPower; power++){
        // Compute the current base/power pair.
        currentPower = PrimePowerMake(numberIsAPower[base].primeNumber, (numberIsAPower[base].power * power));
        
        // For all the currently detected unique base/power pairs,
        for(int index = 0; index < currentNumberOfUniquePowers; index++){
          // If the current base/power pair is equal to a previously found one,
          if(PrimePowersAreEqual(currentPower, uniquePowers[index])){
            // Set the current power to zero.
            currentPower = PrimePowerZero;
            
            // Break out of the loop.
            break;
          }
        }
        // If the current base/power is not equal to zero,
        if(PrimePowersAreEqual(currentPower, PrimePowerZero) == NO){
          // Add the current base/power to the list of unique found base/power
          // pairs.
          uniquePowers[currentNumberOfUniquePowers] = currentPower;
          
          // Increment the number of found base/power pairs by 1.
          currentNumberOfUniquePowers++;
        }
      }
    }
    // If the current number is has NOT been detected above as a potential
    // duplicate base/power pair,
    else{
      // If the base is less than or equal to the maximum base to check,
      if(base <= maxBaseToCheck){
        // For all the powers from the minimum power to the maximum power inclusive,
        for(int power = minPower; power <= maxPower; power++){
          // Compute the current base/power pair.
          currentPower = PrimePowerMake(base, power);
          
          // Add the current base/power to the list of unique found base/power
          // pairs.
          uniquePowers[currentNumberOfUniquePowers] = currentPower;
          
          // Increment the number of found base/power pairs by 1.
          currentNumberOfUniquePowers++;
        }
      }
      // If the base is greater than the maximum base to check,
      else{
        // We need only add the unique number of times the base/power pairs
        // occur for each power. They do NOT need to be checked against anything.
        totalUnchecked += (maxPower - minPower + 1);
      }
    }
  }
  // Add the total number of unchecked base/power pairs to the total number of
  // unique base/power pairs.
  currentNumberOfUniquePowers += totalUnchecked;
  
  // Set the answer string to the current number of unique powers.
  self.answer = [NSString stringWithFormat:@"%d", currentNumberOfUniquePowers];
  
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
  
  // Here, we just use a BigInt data model to handle the multiplication of all
  // the bases and powers. Then, we take the results as NSStrings, and store
  // them in an array. Finally, we create an NSSet from the array to get rid
  // of all the duplicates, and then use it's count to figure out the answer.
  
  // Variable to hold the maximum base we are looking at.
  uint maxBase = 100;
  
  // Variable to hold the minimum base we are looking at.
  uint minBase = 2;
  
  // Variable to hold the maximum power we are looking at.
  uint maxPower = 100;
  
  // Variable to hold the minimum power we are looking at.
  uint minPower = 2;
  
  // Variable to hold the maximum number of potential powers we will have given
  // the above variable (Note: +1 because the list is inclusive).
  uint maxPotentialPowers = (maxBase - minBase + 1) * (maxPower - minPower + 1);
  
  // Variable to hold the current base number.
  BigInt * baseNumber = nil;
  
  // Variable to hold the result number of the multiplication. Start at the
  // default value of 1.
  BigInt * resultNumber = nil;
  
  // Temporary variable to hold the result of the multiplication.
  BigInt * temporaryNumber = nil;
  
  // Variable array to hold all the NSStrings of the result base/power pairs.
  NSMutableArray * allBigInts = [[NSMutableArray alloc] initWithCapacity:maxPotentialPowers];
  
  // For all the bases from the minimum base to the maximum base inclusive,
  for(int base = minBase; base <= maxBase; base++){
    // Set the base number to be the current base.
    baseNumber = [BigInt createFromInt:base];
    
    // Set the result number to be 1.
    resultNumber = [BigInt createFromInt:1];
    
    // For all the powers from 1 to the minimum power inclusive,
    for(int power = 1; power < minPower; power++){
      // Store the multiplication of the base number and the result number in
      // a temporary variable.
      temporaryNumber = [baseNumber multiply:resultNumber];
      
      // Set the result number to be the result of the above multiplication.
      resultNumber = temporaryNumber;
    }
    // For all the powers from the minimum power to the maximum power inclusive,
    for(int power = minPower; power <= maxPower; power++){
      // Store the multiplication of the base number and the result number in
      // a temporary variable.
      temporaryNumber = [baseNumber multiply:resultNumber];
      
      // Set the result number to be the result of the above multiplication.
      resultNumber = temporaryNumber;
      
      // Add the NSString of the resulting number to the array of big ints.
      [allBigInts addObject:[resultNumber toStringWithRadix:10]];
    }
    // If we are no longer computing,
    if(!_isComputing){
      // Break out of the loop.
      break;
    }
  }
  // If the user has not cancelled the computation at this point,
  if(_isComputing){
    // Set the answer string to the number of unique NSStrings in the array of BigInts.
    self.answer = [NSString stringWithFormat:@"%lu", (unsigned long)[[NSSet setWithArray:allBigInts] count]];
    
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