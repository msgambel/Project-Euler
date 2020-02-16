//  Question43.m

#import "Question43.h"

@interface Question43 (Private)

- (BOOL)hasSubStringDivisibilityProperty:(long long int)aNumber;

@end

@implementation Question43

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"09 May 2003";
  self.hint = @"Switch between logic and brute force (d6 = 5).";
  self.link = @"https://en.wikipedia.org/wiki/Pandigital_number";
  self.text = @"The number, 1406357289, is a 0 to 9 pandigital number because it is made up of each of the digits 0 to 9 in some order, but it also has a rather interesting sub-string divisibility property.\n\nLet d1 be the 1st digit, d2 be the 2nd digit, and so on. In this way, we note the following:\n\nd2d3d4=406 is divisible by 2\nd3d4d5=063 is divisible by 3\nd4d5d6=635 is divisible by 5\nd5d6d7=357 is divisible by 7\nd6d7d8=572 is divisible by 11\nd7d8d9=728 is divisible by 13\nd8d9d10=289 is divisible by 17\n\nFind the sum of all 0 to 9 pandigital numbers with this property.";
  self.isFun = YES;
  self.title = @"Sub-string divisibility";
  self.answer = @"16695334890";
  self.number = @"43";
  self.rating = @"5";
  self.category = @"Logic";
  self.keywords = @"string,divisible,pandigital,sub,divisibility,sum,property,digit,numbers,hueristic,order";
  self.solveTime = @"900";
  self.technique = @"Logic";
  self.difficulty = @"Medium";
  self.commentCount = @"86";
  self.attemptsCount = @"1";
  self.isChallenging = YES;
  self.startedOnDate = @"12/02/13";
  self.completedOnDate = @"12/02/13";
  self.solutionLineCount = @"93";
  self.usesCustomObjects = NO;
  self.usesHelperMethods = YES;
  self.requiresMathematics = NO;
  self.hasMultipleSolutions = YES;
  self.estimatedComputationTime = @"8.54e-02";
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"354";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Note: This is the first time I use logic in tandem with the computer. The
  //       computer does the brute force checking, while I add in logic along
  //       the way to figure out the answer! Looking ahead, I'm thinking that
  //       this may be the way I solve some of the future questions as well.
  //
  // Here, we use a hueristic argument to get the all of the 9-digit and 10-digit
  // pandigital numbers with the substring divisibility property. We make note
  // of a few interesting properties:
  //
  // (1) d6 = 5.
  //
  // To see this, note that 5 | d4d5d6 => d6 = 0 or 5.
  //
  // But 11 | d6d7d8 => 11 | (d6 - d7 + d8).
  //
  // If d6 = 0, d7 = d8, but the number is pandigital. Contradiction.
  //
  // Therefore, the allowable pairs (d7,d8) are:
  //
  // (6,1), (7,2), (8,3), (9,4), (0,6), (1,7), (2,8), and (3,9)
  //
  // At this stage, we can use the fact that we know at least one of the digits
  // to improve the allowable numbers for the other digits. We can make a list
  // of all the allowable numbers for each of the substrings, and then remove
  // possiblities that cannot happen. For example,
  //
  // 13 | 26, but there are no multiples of 17 that are inbetween 259 and 271.
  //
  // Therefore, we can remove the values that cannot happen, which should
  // hopefully narrow down the options.
  
  // Variable to hold the tens digit of the current substring.
  int tensDigit = 0;
  
  // Variable to hold the units digit of the current substring.
  int unitsDigit = 0;
  
  // Variable to thold the hundreds digit of the current substring.
  int hundredsDigit = 0;
  
  // Variable to hold the sum of all the 9-digit and 10-digit pandigital numbers
  // with the substring divisibility property.
  long long int sum = 0;
  
  // Variable to mark if the current digits are allowed or not.
  BOOL isAllowed = YES;
  
  // Variable to hold the current index for the multiples we are looking at.
  uint index = 0;
  
  // Variable to hold the allowable last 2 digits for the given substring.
  uint lastTwoDigits = 0;
  
  // Constant array to hold the multiples we are interested in.
  const uint multiples[4] = {7, 11, 13, 17};
  
  // Variable array to hold the allowable digits for each given multiple.
  uint allowableDigits[4][500];
  
  // Variable array to hold the number of potential multiples for each multiple.
  uint numberOfMultiples[4];
  
  // For all the multiples,
  for(int i = 0; i < 4; i++){
    // Set the default number of multiples to 0.
    numberOfMultiples[i] = 0;
  }
  // For all the multiples, counting backwards,
  for(int mulitpleIndex = 3; mulitpleIndex >= 0; mulitpleIndex--){
    // Reset the index to 0.
    index = 0;
    
    // For all the numbers that are a multiple of the current multiple,
    for(int number = multiples[mulitpleIndex]; number < 1000; number += multiples[mulitpleIndex]){
      // Grab the units digit of the number.
      unitsDigit = number % 10;
      
      // Grab the tens digit of the number.
      tensDigit = ((number % 100) / 10);
      
      // Grab the hundreds digit of the number.
      hundredsDigit = number / 100;
      
      // If none of the digits are the same,
      if((hundredsDigit != unitsDigit) && (hundredsDigit != tensDigit) && (tensDigit != unitsDigit)){
        // If the multiple index is 3 (i.e.: 17),
        if(mulitpleIndex == 3){
          // If none of the digits are 5,
          if((hundredsDigit != 5) && (tensDigit != 5) && (unitsDigit != 5)){
            // Add the left-most digits to the allowable digits array.
            allowableDigits[mulitpleIndex][index] = ((uint)(number / 10));
            
            // Increment the number of allowable digits by 1.
            index++;
          }
        }
        // If the multiple index is NOT 3 (i.e.: 7, 11, or 13),
        else{
          // Set that the multiple is not allowed by default.
          isAllowed = NO;
          
          // Compute the last 2 digits of the current multiple.
          lastTwoDigits = number % 100;
          
          // For all the previous allowable multiples,
          for(int previousMultipleIndex = 0; previousMultipleIndex < numberOfMultiples[(mulitpleIndex + 1)]; previousMultipleIndex++){
            // If the first 2 digits of the previous multiple is equal to the
            // last 2 digits of the current multiple,
            if(allowableDigits[(mulitpleIndex + 1)][previousMultipleIndex] == lastTwoDigits){
              // Mark that this number is allowed.
              isAllowed = YES;
              
              // Break out of the loop.
              break;
            }
          }
          // If the number is allowed,
          if(isAllowed){
            // If the multiple index is 0 (i.e.: 7),
            if(mulitpleIndex == 0){
              // If the tens digit is equal to 5 (recall, d6 = 5),
              if(tensDigit == 5){
                // Add the left-most digits to the allowable digits array.
                allowableDigits[mulitpleIndex][index] = ((uint)(number / 10));
                
                // Increment the number of allowable digits by 1.
                index++;
              }
            }
            // If the multiple index is NOT 0 (i.e.: 11, or 13),
            else{
              // Add the left-most digits to the allowable digits array.
              allowableDigits[mulitpleIndex][index] = ((uint)(number / 10));
              
              // Increment the number of allowable digits by 1.
              index++;
            }
          }
        }
      }
    }
    // Print our the allowable multiples.
    NSLog(@"%d:", multiples[mulitpleIndex]);
    NSLog(@"-----");
    
    for(int i = 0; i < index; i++){
      NSLog(@"allowable: %d", allowableDigits[mulitpleIndex][i]);
    }
    NSLog(@" ");
    
    // Set the total number of allowable digits for the current multiple.
    numberOfMultiples[mulitpleIndex] = index;
  }
  
  // Looking at the above printout, the only allowable digits for d5 are 3 and 9.
  // This helps a lot, because we can deduce the allowable digits for d7, using
  // the fact that: 7 | d5d6d7, with d6 = 5.
  
  NSLog(@" ");
  NSLog(@"7 | d5 5 d7");
  NSLog(@"-----------");
  
  // For all the possible multiples of 7 less than 1000,
  for(int number = 7; number < 1000; number += 7){
    // Grab the units digit of the number.
    unitsDigit = number % 10;
    
    // Grab the tens digit of the number.
    tensDigit = ((number % 100) / 10);
    
    // Grab the hundreds digit of the number.
    hundredsDigit = number / 100;
    
    // If the tens digit (d6) is 5,
    if(tensDigit == 5){
      // If the hundreds digit (d4) is 3 or 9,
      if((hundredsDigit == 9) || (hundredsDigit == 3)){
        // If none of the digits are the same,
        if((hundredsDigit != unitsDigit) && (hundredsDigit != tensDigit) && (tensDigit != unitsDigit)){
          // Print out the number and the individual digits.
          NSLog(@"%d: d5: %d, d6: %d, d7: %d", number, hundredsDigit, tensDigit, unitsDigit);
        }
      }
    }
  }
  
  // Therefore, the only allowable digits for d7 are 0, 2 and 7. Now to check
  // for d8 using the fact that 11 | d6d7d8, with d6 = 5.
  
  NSLog(@" ");
  NSLog(@"11 | 5 d7 d8");
  NSLog(@"-----------");
  
  // For all the possible multiples of 11 less than 1000,
  for(int number = 11; number < 1000; number += 11){
    // Grab the units digit of the number.
    unitsDigit = number % 10;
    
    // Grab the tens digit of the number.
    tensDigit = ((number % 100) / 10);
    
    // Grab the hundreds digit of the number.
    hundredsDigit = number / 100;
    
    // If the hundreds digit (d6) is 5,
    if(hundredsDigit == 5){
      // If the tens digit (d7) is 0, 2 or 7,
      if((tensDigit == 0) || (tensDigit == 2) || (tensDigit == 7)){
        // If none of the digits are the same,
        if((hundredsDigit != unitsDigit) && (hundredsDigit != tensDigit) && (tensDigit != unitsDigit)){
          // Print out the number and the individual digits.
          NSLog(@"%d: d6: %d, d7: %d, d8: %d", number, hundredsDigit, tensDigit, unitsDigit);
        }
      }
    }
  }
  
  // Therefore, the only allowable digit pairs (d7,d8) are (0, 6), (2,8) and
  // (7,2). Now to check for d9 using the fact that 13 | d7d8d9.
  
  NSLog(@" ");
  NSLog(@"13 | d7 d8 d9");
  NSLog(@"-----------");
  
  // For all the possible multiples of 13 less than 1000,
  for(int number = 13; number < 1000; number += 13){
    // Grab the units digit of the number.
    unitsDigit = number % 10;
    
    // Grab the tens digit of the number.
    tensDigit = ((number % 100) / 10);
    
    // Grab the hundreds digit of the number.
    hundredsDigit = number / 100;
    
    // If the units digit (d9) is NOT 5,
    if(unitsDigit != 5){
      // If the (d7,d8) pair is valid,
      if(((hundredsDigit == 0) && (tensDigit == 6)) ||
         ((hundredsDigit == 2) && (tensDigit == 8)) ||
         ((hundredsDigit == 7) && (tensDigit == 2))){
        
        // If none of the digits are the same,
        if((hundredsDigit != unitsDigit) && (hundredsDigit != tensDigit) && (tensDigit != unitsDigit)){
          // Print out the number and the individual digits.
          NSLog(@"%d: d7: %d, d8: %d, d9: %d", number, hundredsDigit, tensDigit, unitsDigit);
        }
      }
    }
  }
  
  // Therefore, the only allowable digit triples (d7,d8,d9) are (2,8,6) and
  // (7,2,8). Now to check for d10 using the fact that 17 | d8d9d10.
  
  NSLog(@" ");
  NSLog(@"17 | d8 d9, d10");
  NSLog(@"-----------");
  
  // For all the possible multiples of 17 less than 1000,
  for(int number = 17; number < 1000; number += 17){
    // Grab the units digit of the number.
    unitsDigit = number % 10;
    
    // Grab the tens digit of the number.
    tensDigit = ((number % 100) / 10);
    
    // Grab the hundreds digit of the number.
    hundredsDigit = number / 100;
    
    // If the units digit (d10) is NOT 5,
    if(unitsDigit != 5){
      // If the (d8,d9) pair is valid,
      if(((hundredsDigit == 2) && (tensDigit == 8)) ||
         ((hundredsDigit == 8) && (tensDigit == 6))){
        
        // If none of the digits are the same,
        if((hundredsDigit != unitsDigit) && (hundredsDigit != tensDigit) && (tensDigit != unitsDigit)){
          // Print out the number and the individual digits.
          NSLog(@"%d: d8: %d, d9: %d, d10: %d", number, hundredsDigit, tensDigit, unitsDigit);
        }
      }
    }
  }
  
  // Therefore, the only allowable digit triples (d8,d9,d10) are (8,6,7) and
  // (2,8,9). Now, we use the above data to see that from d5 to d10, there are
  // only 2 possible numbers:
  //
  // (357289) and (952867), with remaining digits (0,1,4,6) and (0,1,3,4) respectively.
  //
  // Then we note the following:
  //
  // (2) d4 must be even, as 2 | d2d3d4
  //
  // (3) 3 | (d3 + d4), as 3 | d3d4d5, and d5 = 3 or 9.
  //
  //
  // Case 1 (357289): (2) => d4 = 0, 4, or 6.
  //
  // If d4 = 0, (3) => d3 = 6, so we get 2 numbers: 4160357289, and 1460357289.
  //
  // If d4 = 4, (3) => d3 = 2 mod 3, but there are no remaining digits with
  // that property.
  //
  // If d4 = 6, (3) => d3 = 0, so we get 2 numbers: 4106357289, and 1406357289.
  //
  //
  // Case 2 (357289): (2) => d4 = 0 or 4.
  //
  // If d4 = 0, (3) => d3 = 3, so we get 2 numbers: 4130952867, and 1430952867.
  //
  // If d4 = 4, (3) => d3 = 2 mod 3, but there are no remaining digits with
  // that property.
  //
  // Therefore, there are only 6 numbers that satidfy all the conditions:
  //
  // 4160357289, 4130952867, 4106357289, 1460357289, 1430952867, and 1406357289.
  
  // Sum the 6 numbers together:
  sum = 4160357289 + 4130952867 + 4106357289 + 1460357289 + 1430952867 + 1406357289;
  
  // Set the answer string to the sum of all the 9-digit pandigital numbers with
  // the substring divisibility property.
  self.answer = [NSString stringWithFormat:@"%llu", sum];
  
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
  
  // Here, we simply check all the possbile 9-digit and 10-digit pandigital
  // numbers to see if they are pandigital or not. If they are, we use a helper
  // method to check if they have the substring divisiblity property we are
  // looking for, and if it does, we add it to the sum.
  //
  // We make 1 small observation here, in order to speed up the computation to
  // a tolerable level. 9-digit pandigital numbers must be divisible by 9
  // (easily verified by summing the digits), and therefore, if we start at the
  // maximum pandigital number, we can subtract by 9 instead of by 1.
  
  // Variable to hold the sum of all the 9-digit pandigital numbers with the
  // substring divisibility property.
  long long int sum = 0;
  
  // For all the possible 10-digit pandigital numbers,
  for(long long int number = 9876543210; number >= 1023456789; number -= 9){
    // If the number is pandigital/lexographic,
    if([self isNumberLexographic:number countZero:YES]){
      // If the number has the substring divisibility property,
      if([self hasSubStringDivisibilityProperty:number]){
        // Add it to the sum.
        sum += number;
      }
    }
    // If we are no longer computing,
    if(!_isComputing){
      // Break out of the loop.
      break;
    }
  }
  // For all the possible 9-digit pandigital numbers,
  for(long long int number = 987654321; number >= 123456789; number -= 9){
    // If the number is pandigital/lexographic,
    if([self isNumberLexographic:number countZero:NO]){
      // If the number has the substring divisibility property,
      if([self hasSubStringDivisibilityProperty:number]){
        // Add it to the sum.
        sum += number;
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
    // Set the answer string to the sum of all the 9-digit pandigital numbers with
    // the substring divisibility property.
    self.answer = [NSString stringWithFormat:@"%llu", sum];
    
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

@implementation Question43 (Private)

- (BOOL)hasSubStringDivisibilityProperty:(long long int)aNumber; {
  // Variable to hold the number of digits there are for the input number.
  int numberOfDigits = (int)(log10(aNumber));
  
  // If the number of digits in the inputted number is too small,
  if(numberOfDigits < 7){
    // The number does NOT have the divisibility property, so return NO.
    return NO;
  }
  // Constant array to hold all the multiples for each substring.
  const uint multiples[7] = {17, 13, 11, 7, 5, 3, 2};
  
  // Variable to tell if the number has the substring divisibility property or NOT.
  BOOL hasProperty = YES;
  
  // Variable to hold the last three digits of the current number.
  uint lastThreeDigits = 0;
  
  // Variable to hold the left-most digits of the current number.
  long long int workableNumber = aNumber;
  
  // For all the substrings we need to check,
  for(int index = 0; index < 7; index++){
    // Grab the last three digits of the current workable number.
    lastThreeDigits = (workableNumber % 1000);
    
    // If the last three digits are NOT a multiple of the current multiples index,
    if((lastThreeDigits % multiples[index]) != 0){
      // Mark that this number does NOT have the substring divisibility property.
      hasProperty = NO;
      
      // Break out of the loop.
      break;
    }
    // Divide the current workable number by 10 to remove the right-most digit.
    workableNumber /= 10;
  }
  // Return if the number has the substring divisibility property or NOT.
  return hasProperty;
}

@end