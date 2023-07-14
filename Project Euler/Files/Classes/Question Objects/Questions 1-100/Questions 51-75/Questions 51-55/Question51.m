//  Question51.m

#import "Question51.h"

@implementation Question51

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"29 August 2003";
  self.hint = @"It's a 6 digit prime.";
  self.link = @"https://en.wikipedia.org/wiki/Prime_number";
  self.text = @"By replacing the 1st digit of *3, it turns out that six of the nine possible values: 13, 23, 43, 53, 73, and 83, are all prime.\n\nBy replacing the 3rd and 4th digits of 56**3 with the same digit, this 5-digit number is the first example having seven primes among the ten generated numbers, yielding the family: 56003, 56113, 56333, 56443, 56663, 56773, and 56993. Consequently 56003, being the first member of this family, is the smallest prime with this property.\n\nFind the smallest prime which, by replacing part of the number (not necessarily adjacent digits) with the same digit, is part of an eight prime value family.";
  self.isFun = YES;
  self.title = @"Prime digit replacements";
  self.answer = @"121313";
  self.number = @"51";
  self.rating = @"5";
  self.category = @"Primes";
  self.isUseful = NO;
  self.keywords = @"prime,value,family,digit,replacements,number,eight,8,*,smallest,property";
  self.solveTime = @"600";
  self.technique = @"Recursion";
  self.difficulty = @"Medium";
  self.usesBigInt = NO;
  self.commentCount = @"63";
  self.attemptsCount = @"1";
  self.isChallenging = YES;
  self.isContestMath = NO;
  self.startedOnDate = @"20/02/13";
  self.trickRequired = YES;
  self.educationLevel = @"High School";
  self.solvableByHand = NO;
  self.canBeSimplified = YES;
  self.completedOnDate = @"20/02/13";
  self.solutionLineCount = @"75";
  self.usesCustomObjects = NO;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = YES;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = YES;
  self.hasMultipleSolutions = NO;
  self.estimatedComputationTime = @"0.794";
  self.relatedToAnotherQuestion = YES;
  self.shouldInvestigateFurther = NO;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"0.794";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply construct the all the possible 6 digit numbers to see if
  // they belong to an 8 prime family with repeating digits. We know that it
  // must be a 6 digit prime because of the following:
  //
  // 1) Let n be the number of repeating digits of an integer x. If x belongs
  //    to an 8 prime family of repeating digits, then 3|n.
  //
  // Proof: Let a be the sum the of the non-repeating digits of x mod 3. Then
  //        a = 1 or 2. If a = 0, then when the repeating digits are 3, 6 or 9,
  //        3 | x => x is NOT prime. Therefore, at most 7 other integers can be
  //        prime.
  //
  //        Case 1: n = 1 mod 3.
  //
  //        If n is even, and the repeating digits are 1, 4, or 7, x is NOT
  //        prime. Therefore, at most 7 other integers can be prime.
  //
  //        If n is odd, and the repeating digits are 2, 5, or 8, x is NOT
  //        prime. Therefore, at most 7 other integers can be prime.
  //
  //        Case 2: n = 2 mod 3.
  //
  //        If n is even, and the repeating digits are 2, 5, or 8, x is NOT
  //        prime. Therefore, at most 7 other integers can be prime.
  //
  //        If n is odd, and the repeating digits are 1, 4, or 7, x is NOT
  //        prime. Therefore, at most 7 other integers can be prime.
  //
  //                                                                      Q.E.D.
  //
  // Therefore, the number of repeating digits must be a multiple of 3. It is
  // easy to check that the 4 and 5 digit primes do not have a family (just take
  // the method below and make a few small changes to all the cases), so they
  // are left out of the computation for clarity.
  //
  // There are 10 forms the prime numbers can be in. They are described below
  // when they are constructed.
  //
  // We use string concatenation to make construct the numbers. We also remove
  // the leading 0's before checking, as if they were included, the question
  // text would have included 03 in the example of the family of primes of the
  // for *3.
  
  // Note: If we include numbers of the form 000abe, then the smallest number to
  //       have a family of 8 is 109!
  
  // Variable to mark if we have found the prime family or not.
  BOOL familyFound = NO;
  
  // Set the maxaimum size for the prime numbers.
  uint maxSize = 1000000;
  
  // Set the minimum size for the prime numbers.
  uint minSize = 10000;
  
  // Variable to hold the number of primes in a given family.
  uint primeCount = 0;
  
  // Variable to hold the required number of primes in a given family.
  uint requiredCount = 8;
  
  // Variable to hold the smallest prime in the family.
  uint smallestPrimeInFamily = 0;
  
  // Variable to hold the possible end digits of the primes that can be in the
  // family we are looking for.
  uint endNumber[4] = {1, 3, 7, 9};
  
  // Variable to hold the concatenated prime number for the result.
  NSString * concatenatedPrimeNumber = nil;
  
  // Array to hold all the prime numbers found.
  NSMutableArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:maxSize];
  
  // Array to hold all the primes between the minimum and maximum sizes.
  NSMutableArray * updatedPrimeNumbersArray = [[NSMutableArray alloc] init];
  
  // Hash table to easily check if a number is prime of not.
  NSMutableDictionary * primesDictionary = [[NSMutableDictionary alloc] init];
  
  // If the user has not cancelled the computation at this point,
  if(_isComputing){
    // For all the prime numbers found,
    for(NSNumber * primeNumber in primeNumbersArray){
      // If the prime number is greater than the minimum size,
      if([primeNumber intValue] > minSize){
        // Add it to the updated prime numbers array.
        [updatedPrimeNumbersArray addObject:primeNumber];
      }
    }
    // For all the prime numbers between the minimum and maximum sizes,
    for(NSNumber * primeNumber in updatedPrimeNumbersArray){
      // Add the prime number as a key to the Hash Table to easily look if the number
      // is prime or not.
      [primesDictionary setObject:[NSNumber numberWithBool:YES] forKey:[primeNumber stringValue]];
    }
  }
  // If the user has not cancelled the computation at this point,
  if(_isComputing){
    // For all the possible 10 arrangements,
    for(int arrangementIndex = 9; arrangementIndex >= 0; arrangementIndex--){
      // For all the first extra, non-repeating digits 0-9,
      for(int extraDigit = 0; extraDigit <= 9; extraDigit++){
        // For all the second extra, non-repeating digits 0-9,
        for(int secondExtraDigit = 0; secondExtraDigit <= 9; secondExtraDigit++){
          // For all the possible end digits the prime could have,
          for(int endNumberIndex = 0; endNumberIndex < 4; endNumberIndex++){
            // Reset the prime count to 0.
            primeCount = 0;
            
            // For all the repeating digits 0-9,
            for(int repeatingDigit = 0; repeatingDigit <= 9; repeatingDigit++){
              
              // Define;
              //
              // * : the repeating digit.
              // a : the first extra digit.
              // b : the second extra digit.
              // e : the end digit.
              //
              // Based on the index, we switch the the arrangement of the number
              // into one of 10 forms.
              
              switch(arrangementIndex){
                case 0:
                  // Put the number in form: ***abe
                  concatenatedPrimeNumber = [NSString stringWithFormat:@"%d%d%d%d%d%d", repeatingDigit, repeatingDigit, repeatingDigit, extraDigit, secondExtraDigit, endNumber[endNumberIndex]];
                  break;
                case 1:
                  // Put the number in form: a***be
                  concatenatedPrimeNumber = [NSString stringWithFormat:@"%d%d%d%d%d%d", extraDigit, repeatingDigit, repeatingDigit, repeatingDigit, secondExtraDigit, endNumber[endNumberIndex]];
                  break;
                case 2:
                  // Put the number in form: ab***e
                  concatenatedPrimeNumber = [NSString stringWithFormat:@"%d%d%d%d%d%d", extraDigit, secondExtraDigit, repeatingDigit, repeatingDigit, repeatingDigit, endNumber[endNumberIndex]];
                  break;
                case 3:
                  // Put the number in form: **a*be
                  concatenatedPrimeNumber = [NSString stringWithFormat:@"%d%d%d%d%d%d", repeatingDigit, repeatingDigit, extraDigit, repeatingDigit, secondExtraDigit, endNumber[endNumberIndex]];
                  break;
                case 4:
                  // Put the number in form: a**b*e
                  concatenatedPrimeNumber = [NSString stringWithFormat:@"%d%d%d%d%d%d", extraDigit, repeatingDigit, repeatingDigit, secondExtraDigit, repeatingDigit, endNumber[endNumberIndex]];
                  break;
                case 5:
                  // Put the number in form: **ab*e
                  concatenatedPrimeNumber = [NSString stringWithFormat:@"%d%d%d%d%d%d", repeatingDigit, repeatingDigit, extraDigit, secondExtraDigit, repeatingDigit, endNumber[endNumberIndex]];
                  break;
                case 6:
                  // Put the number in form: *a**be
                  concatenatedPrimeNumber = [NSString stringWithFormat:@"%d%d%d%d%d%d", repeatingDigit, extraDigit, repeatingDigit, repeatingDigit, secondExtraDigit, endNumber[endNumberIndex]];
                  break;
                case 7:
                  // Put the number in form: a*b**e
                  concatenatedPrimeNumber = [NSString stringWithFormat:@"%d%d%d%d%d%d", extraDigit, repeatingDigit, secondExtraDigit, repeatingDigit, repeatingDigit, endNumber[endNumberIndex]];
                  break;
                case 8:
                  // Put the number in form: *ab**e
                  concatenatedPrimeNumber = [NSString stringWithFormat:@"%d%d%d%d%d%d", repeatingDigit, extraDigit, secondExtraDigit, repeatingDigit, repeatingDigit, endNumber[endNumberIndex]];
                  break;
                case 9:
                  // Put the number in form: *a*b*e
                  concatenatedPrimeNumber = [NSString stringWithFormat:@"%d%d%d%d%d%d", repeatingDigit, extraDigit, repeatingDigit, secondExtraDigit, repeatingDigit, endNumber[endNumberIndex]];
                  break;
                default:
                  break;
              }
              // Remove the leading zeros from the number.
              concatenatedPrimeNumber = [NSString stringWithFormat:@"%d", [concatenatedPrimeNumber intValue]];
              
              // If the number is a prime between the minimum size and the maximum
              // size,
              if([[primesDictionary objectForKey:concatenatedPrimeNumber] boolValue]){
                // Increment the prime count by 1.
                primeCount++;
                
                // If the prime count is 1,
                if(primeCount == 1){
                  // This is the first prime in the family, so save the number.
                  smallestPrimeInFamily = [concatenatedPrimeNumber intValue];
                }
                // If the prime count is the required prime count,
                else if(primeCount == requiredCount){
                  // We have found the family, so mark it as such.
                  familyFound = YES;
                  
                  // Break out of the loop.
                  break;
                }
              }
            }
            // If the family has been found,
            if(familyFound){
              // Break out of the loop.
              break;
            }
          }
          // If the family has been found,
          if(familyFound){
            // Break out of the loop.
            break;
          }
        }
        // If the family has been found,
        if(familyFound){
          // Break out of the loop.
          break;
        }
      }
      // If the family has been found,
      if(familyFound){
        // Break out of the loop.
        break;
      }
      // If we are no longer computing,
      if(!_isComputing){
        // Break out of the loop.
        break;
      }
    }
  }
  // If the user has not cancelled the computation at this point,
  if(_isComputing){
    // Set the answer string to the smallest prime in the family of 8.
    self.answer = [NSString stringWithFormat:@"%d", smallestPrimeInFamily];
    
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
  
  // Here, we simply construct the all the possible 6 digit numbers to see if
  // they belong to an 8 prime family with repeating digits. We know that it
  // must be a 6 digit prime because of the following:
  //
  // 1) Let n be the number of repeating digits of an integer x. If x belongs
  //    to an 8 prime family of repeating digits, then 3|n.
  //
  // Proof: Let a be the sum the of the non-repeating digits of x mod 3. Then
  //        a = 1 or 2. If a = 0, then when the repeating digits are 3, 6 or 9,
  //        3 | x => x is NOT prime. Therefore, at most 7 other integers can be
  //        prime.
  //
  //        Case 1: n = 1 mod 3.
  //
  //        If n is even, and the repeating digits are 1, 4, or 7, x is NOT
  //        prime. Therefore, at most 7 other integers can be prime.
  //
  //        If n is odd, and the repeating digits are 2, 5, or 8, x is NOT
  //        prime. Therefore, at most 7 other integers can be prime.
  //
  //        Case 2: n = 2 mod 3.
  //
  //        If n is even, and the repeating digits are 2, 5, or 8, x is NOT
  //        prime. Therefore, at most 7 other integers can be prime.
  //
  //        If n is odd, and the repeating digits are 1, 4, or 7, x is NOT
  //        prime. Therefore, at most 7 other integers can be prime.
  //
  //                                                                      Q.E.D.
  //
  // Therefore, the number of repeating digits must be a multiple of 3. It is
  // easy to check that the 4 and 5 digit primes do not have a family (just take
  // the method below and make a few small changes to all the cases), so they
  // are left out of the computation for clarity.
  //
  // There are 10 forms the prime numbers can be in. They are described below
  // when they are constructed.
  //
  // We use string concatenation to make construct the numbers. We also remove
  // the leading 0's before checking, as if they were included, the question
  // text would have included 03 in the example of the family of primes of the
  // for *3.
  
  // Note: If we include numbers of the form 000abe, then the smallest number to
  //       have a family of 8 is 109!
  
  // Variable to mark if we have found the prime family or not.
  BOOL familyFound = NO;
  
  // Set the maxaimum size for the prime numbers.
  uint maxSize = 1000000;
  
  // Set the minimum size for the prime numbers.
  uint minSize = 10000;
  
  // Variable to hold the number of primes in a given family.
  uint primeCount = 0;
  
  // Variable to hold the required number of primes in a given family.
  uint requiredCount = 8;
  
  // Variable to hold the smallest prime in the family.
  uint smallestPrimeInFamily = 0;
  
  // Variable to hold the possible end digits of the primes that can be in the
  // family we are looking for.
  uint endNumber[4] = {1, 3, 7, 9};
  
  // Variable to hold the concatenated prime number for the result.
  NSString * concatenatedPrimeNumber = nil;
  
  // Array to hold all the prime numbers found.
  NSMutableArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:maxSize];
  
  // Array to hold all the primes between the minimum and maximum sizes.
  NSMutableArray * updatedPrimeNumbersArray = [[NSMutableArray alloc] init];
  
  // Hash table to easily check if a number is prime of not.
  NSMutableDictionary * primesDictionary = [[NSMutableDictionary alloc] init];
  
  // If the user has not cancelled the computation at this point,
  if(_isComputing){
    // For all the prime numbers found,
    for(NSNumber * primeNumber in primeNumbersArray){
      // If the prime number is greater than the minimum size,
      if([primeNumber intValue] > minSize){
        // Add it to the updated prime numbers array.
        [updatedPrimeNumbersArray addObject:primeNumber];
      }
    }
    // For all the prime numbers between the minimum and maximum sizes,
    for(NSNumber * primeNumber in updatedPrimeNumbersArray){
      // Add the prime number as a key to the Hash Table to easily look if the number
      // is prime or not.
      [primesDictionary setObject:[NSNumber numberWithBool:YES] forKey:[primeNumber stringValue]];
    }
  }
  // If the user has not cancelled the computation at this point,
  if(_isComputing){
    // For all the possible 10 arrangements,
    for(int arrangementIndex = 9; arrangementIndex >= 0; arrangementIndex--){
      // For all the first extra, non-repeating digits 0-9,
      for(int extraDigit = 0; extraDigit <= 9; extraDigit++){
        // For all the second extra, non-repeating digits 0-9,
        for(int secondExtraDigit = 0; secondExtraDigit <= 9; secondExtraDigit++){
          // For all the possible end digits the prime could have,
          for(int endNumberIndex = 0; endNumberIndex < 4; endNumberIndex++){
            // Reset the prime count to 0.
            primeCount = 0;
            
            // For all the repeating digits 0-9,
            for(int repeatingDigit = 0; repeatingDigit <= 9; repeatingDigit++){
              
              // Define;
              //
              // * : the repeating digit.
              // a : the first extra digit.
              // b : the second extra digit.
              // e : the end digit.
              //
              // Based on the index, we switch the the arrangement of the number
              // into one of 10 forms.
              
              switch(arrangementIndex){
                case 0:
                  // Put the number in form: ***abe
                  concatenatedPrimeNumber = [NSString stringWithFormat:@"%d%d%d%d%d%d", repeatingDigit, repeatingDigit, repeatingDigit, extraDigit, secondExtraDigit, endNumber[endNumberIndex]];
                  break;
                case 1:
                  // Put the number in form: a***be
                  concatenatedPrimeNumber = [NSString stringWithFormat:@"%d%d%d%d%d%d", extraDigit, repeatingDigit, repeatingDigit, repeatingDigit, secondExtraDigit, endNumber[endNumberIndex]];
                  break;
                case 2:
                  // Put the number in form: ab***e
                  concatenatedPrimeNumber = [NSString stringWithFormat:@"%d%d%d%d%d%d", extraDigit, secondExtraDigit, repeatingDigit, repeatingDigit, repeatingDigit, endNumber[endNumberIndex]];
                  break;
                case 3:
                  // Put the number in form: **a*be
                  concatenatedPrimeNumber = [NSString stringWithFormat:@"%d%d%d%d%d%d", repeatingDigit, repeatingDigit, extraDigit, repeatingDigit, secondExtraDigit, endNumber[endNumberIndex]];
                  break;
                case 4:
                  // Put the number in form: a**b*e
                  concatenatedPrimeNumber = [NSString stringWithFormat:@"%d%d%d%d%d%d", extraDigit, repeatingDigit, repeatingDigit, secondExtraDigit, repeatingDigit, endNumber[endNumberIndex]];
                  break;
                case 5:
                  // Put the number in form: **ab*e
                  concatenatedPrimeNumber = [NSString stringWithFormat:@"%d%d%d%d%d%d", repeatingDigit, repeatingDigit, extraDigit, secondExtraDigit, repeatingDigit, endNumber[endNumberIndex]];
                  break;
                case 6:
                  // Put the number in form: *a**be
                  concatenatedPrimeNumber = [NSString stringWithFormat:@"%d%d%d%d%d%d", repeatingDigit, extraDigit, repeatingDigit, repeatingDigit, secondExtraDigit, endNumber[endNumberIndex]];
                  break;
                case 7:
                  // Put the number in form: a*b**e
                  concatenatedPrimeNumber = [NSString stringWithFormat:@"%d%d%d%d%d%d", extraDigit, repeatingDigit, secondExtraDigit, repeatingDigit, repeatingDigit, endNumber[endNumberIndex]];
                  break;
                case 8:
                  // Put the number in form: *ab**e
                  concatenatedPrimeNumber = [NSString stringWithFormat:@"%d%d%d%d%d%d", repeatingDigit, extraDigit, secondExtraDigit, repeatingDigit, repeatingDigit, endNumber[endNumberIndex]];
                  break;
                case 9:
                  // Put the number in form: *a*b*e
                  concatenatedPrimeNumber = [NSString stringWithFormat:@"%d%d%d%d%d%d", repeatingDigit, extraDigit, repeatingDigit, secondExtraDigit, repeatingDigit, endNumber[endNumberIndex]];
                  break;
                default:
                  break;
              }
              // Remove the leading zeros from the number.
              concatenatedPrimeNumber = [NSString stringWithFormat:@"%d", [concatenatedPrimeNumber intValue]];
              
              // If the number is a prime between the minimum size and the maximum
              // size,
              if([[primesDictionary objectForKey:concatenatedPrimeNumber] boolValue]){
                // Increment the prime count by 1.
                primeCount++;
                
                // If the prime count is 1,
                if(primeCount == 1){
                  // This is the first prime in the family, so save the number.
                  smallestPrimeInFamily = [concatenatedPrimeNumber intValue];
                }
                // If the prime count is the required prime count,
                else if(primeCount == requiredCount){
                  // We have found the family, so mark it as such.
                  familyFound = YES;
                  
                  // Break out of the loop.
                  break;
                }
              }
            }
            // If the family has been found,
            if(familyFound){
              // Break out of the loop.
              break;
            }
          }
          // If the family has been found,
          if(familyFound){
            // Break out of the loop.
            break;
          }
        }
        // If the family has been found,
        if(familyFound){
          // Break out of the loop.
          break;
        }
      }
      // If the family has been found,
      if(familyFound){
        // Break out of the loop.
        break;
      }
      // If we are no longer computing,
      if(!_isComputing){
        // Break out of the loop.
        break;
      }
    }
  }
  // If the user has not cancelled the computation at this point,
  if(_isComputing){
    // Set the answer string to the smallest prime in the family of 8.
    self.answer = [NSString stringWithFormat:@"%d", smallestPrimeInFamily];
    
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