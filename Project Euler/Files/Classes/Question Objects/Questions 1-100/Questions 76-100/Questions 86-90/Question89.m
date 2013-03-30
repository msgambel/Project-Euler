//  Question89.m

#import "Question89.h"

@interface Question89 (Private)

- (uint)numberFromRomanNumeralsString:(NSString *)aString;
- (uint)numberOfCharactersSavedFromString:(NSString *)aString;
- (NSString *)reducedStringOfRomanNumeralsForNumber:(uint)aNumber;
- (NSString *)reducedStringOfRomanNumeralsFromRomanNumeralsString:(NSString *)aString;

@end

@implementation Question89

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"18 February 2005";
  self.text = @"The rules for writing Roman numerals allow for many ways of writing each number (see About Roman Numerals...). However, there is always a \"best\" way of writing a particular number.\n\nFor example, the following represent all of the legitimate ways of writing the number sixteen:\n\nIIIIIIIIIIIIIIII\nVIIIIIIIIIII\nVVIIIIII\nXIIIIII\nVVVI\nXVI\n\nThe last example being considered the most efficient, as it uses the least number of numerals.\n\nThe 11K text file, roman.txt (right click and 'Save Link/Target As...'), contains one thousand numbers written in valid, but not necessarily minimal, Roman numerals; that is, they are arranged in descending units and obey the subtractive pair rule (see About Roman Numerals... for the definitive rules for this problem).\n\nFind the number of characters saved by writing each of these in their minimal form.\n\nNote: You can assume that all the Roman numerals in the file contain no more than four consecutive identical units.";
  self.title = @"Roman numerals";
  self.answer = @"743";
  self.number = @"Problem 89";
  self.estimatedComputationTime = @"1.75e-02";
  self.estimatedBruteForceComputationTime = @"2.67e-02";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // We simply use a helper method to figure out the how many characters can be
  // reduced for each string, and add it to the total.
  //
  // Note: This requires the fact that:
  //
  // "You can assume that all the Roman numerals in the file contain no more
  //  than four consecutive identical units."
  //
  // Without this, you could have situations like IIIII...III = M. The brute
  // force method does not require this fact, and is more robust, and not that
  // much slower!
  
  // Variable to hold the number of characters saved when reducing the roman
  // numerals to minimal form.
  uint numberOfCharactersSaved = 0;
  
  // Variable to hold the path to the file that holds the roman numerals data.
  NSString * path = [[NSBundle mainBundle] pathForResource:@"romanQuestion89" ofType:@"txt"];
  
  // Variable to hold the roman numerals list as a string for parsing.
  NSString * romanNumeralsList = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
  
   // Variable to hold each roman numeral as a string in an array.
  NSArray * romanNumerals = [romanNumeralsList componentsSeparatedByString:@"\n"];
  
  // For every roman numeral string in the roman numerals array,
  for(NSString * romanNumeralString in romanNumerals){
    // Add on the number of characters removed from the number.
    numberOfCharactersSaved += [self numberOfCharactersSavedFromString:romanNumeralString];
  }
  // Set the answer string to the number of characters saved.
  self.answer = [NSString stringWithFormat:@"%d", numberOfCharactersSaved];
  
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
  
  // We simply use a helper method to figure out the reduced form of the roman
  // numeral. We then add the intial length, and subtract the reduced length to
  // get the number of characters saved.
  
  // Variable to hold the number of characters saved when reducing the roman
  // numerals to minimal form.
  uint numberOfCharactersSaved = 0;
  
  // Variable to hold the path to the file that holds the roman numerals data.
  NSString * path = [[NSBundle mainBundle] pathForResource:@"romanQuestion89" ofType:@"txt"];
  
  // Variable to hold the roman numerals list as a string for parsing.
  NSString * romanNumeralsList = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
  
  // Variable to hold each roman numeral as a string in an array.
  NSArray * romanNumerals = [romanNumeralsList componentsSeparatedByString:@"\n"];
  
  // For every roman numeral string in the roman numerals array,
  for(NSString * romanNumeralString in romanNumerals){
    // Add on the number of characters of the number.
    numberOfCharactersSaved += romanNumeralString.length;
    
    // Subtract off the number of characters in the reduced form of the roman
    // numeral.
    numberOfCharactersSaved -= [self reducedStringOfRomanNumeralsFromRomanNumeralsString:romanNumeralString].length;
  }
  // Set the answer string to the number of characters saved.
  self.answer = [NSString stringWithFormat:@"%d", numberOfCharactersSaved];
  
  // Get the amount of time that has passed while the computation was happening.
  NSTimeInterval computationTime = [[NSDate date] timeIntervalSinceDate:startTime];
  
  // Set the estimated brute force computation time to the calculated value. We
  // use scientific notation here, as the run time should be very short.
  self.estimatedBruteForceComputationTime = [NSString stringWithFormat:@"%.03g", computationTime];
  
  // Tell the delegate we have finished the computation.
  [self.delegate finishedComputing];
  
  // Set that we have finished the computation.
  _isComputing = NO;
}

@end

#pragma mark - Private Methods

@implementation Question89 (Private)

- (uint)numberFromRomanNumeralsString:(NSString *)aString; {
  // This method takes in a roman numeral, converts it to its basic form (i.e.:
  // no compatifications), and computes its value. This method is robust. It even
  // removes invalid roman numeral characters in case of a mistaken input.
  
  // Constant array to hold the value of the roman numerals.
  const int romanNumeralsValues[7] = {1000, 500, 100, 50, 10, 5, 1};
  
  // Constant array to hold the roman numerals as strings.
  const NSArray * romanNumerals = [NSArray arrayWithObjects:@"M", @"D", @"C", @"L", @"X", @"V", @"I", nil];
  
  // Variable to hold the roman numerals value as a base 10 number.
  uint romanNumber = 0;
  
  // Variable to hold the inputted roman numeral which we will modify to compute
  // its base 10 value.
  NSString * simplifiedString = aString;
  
  // Variable to hold the valid roman numeral characters.
  NSCharacterSet * validRomanNumeralCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"MDCLXVI"];
  
  // Remove all the invalid roman numeral characters.
  [simplifiedString stringByTrimmingCharactersInSet:validRomanNumeralCharacterSet];
  
  // Variable to hold the current roman numeral when iterating through the above
  // constant array.
  NSString * currentRomanNumeral = nil;
  
  // Temporary variable to hold the modified string.
  NSString * temporarySimplifiedString = nil;
  
  // First, remove all the compactifications. To do this, just replace any
  // compactification with the elongated version.
  
  simplifiedString = [simplifiedString stringByReplacingOccurrencesOfString:@"CM" withString:@"DCCCC"];
  simplifiedString = [simplifiedString stringByReplacingOccurrencesOfString:@"CD" withString:@"CCCC"];
  simplifiedString = [simplifiedString stringByReplacingOccurrencesOfString:@"XC" withString:@"LXXXX"];
  simplifiedString = [simplifiedString stringByReplacingOccurrencesOfString:@"XL" withString:@"XXXX"];
  simplifiedString = [simplifiedString stringByReplacingOccurrencesOfString:@"IX" withString:@"VIIII"];
  simplifiedString = [simplifiedString stringByReplacingOccurrencesOfString:@"IV" withString:@"IIII"];
  
  // Next, we take the string and remove all the occurances of each roman numeral.
  // Then, we compare it's length (before and after removal) to see how many we
  // removed, and 
  
  // For all the roman numerals,
  for(int i = 0; i < [romanNumerals count]; i++){
    // Grab the current roman numeral.
    currentRomanNumeral = [romanNumerals objectAtIndex:i];
    
    // Remove all the current roman numerals from the string.
    temporarySimplifiedString = [simplifiedString stringByReplacingOccurrencesOfString:currentRomanNumeral withString:@""];
    
    // Compute the size difference of the string before and after the removal,
    // and multiply it by the base 10 value of the current roman numeral.
    romanNumber += ((simplifiedString.length - temporarySimplifiedString.length) * romanNumeralsValues[i]);
    
    // Set the string to be the string with the current roman numeral removed.
    simplifiedString = temporarySimplifiedString;
  }
  // Return the roman numerals value as a base 10 number.
  return romanNumber;
}

- (uint)numberOfCharactersSavedFromString:(NSString *)aString; {
  // This method finds all the occurances of all the possible roman numeral
  // occurances that can be reduced, looks at the string (before and after the
  // removal), and adds how many characters have been saved.
  
  // Note: This requires the fact that:
  //
  // "You can assume that all the Roman numerals in the file contain no more
  //  than four consecutive identical units."
  //
  // Without this, you could have situations like IIIII...III = M. The brute
  // force method does not require this fact, and is more robust, and not that
  // much slower!
  
  // Constant array to hold all the possible roman numeral occurances that can
  // be reduced. The first 3 reduce by 3 roman numerals, and the rest reduce by
  // 2 roman numerals.
  const NSArray * romanNumerals = [NSArray arrayWithObjects:@"DCCCC", @"LXXXX", @"VIIII", @"IIII", @"VVVV", @"XXXX", @"LLLL", @"CCCC", @"DDDD", nil];
  
  // Variable to hold the number of roman numerals removed.
  uint romanNumeralsRemoved = 0;
  
  // Variable to hold the inputted roman numeral which we will modify to compute
  // the number of characters that can be reduced.
  NSString * simplifiedString = aString;
  
  // Variable to hold the valid roman numeral characters.
  NSCharacterSet * validRomanNumeralCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"MDCLXVI"];
  
  // Remove all the invalid roman numeral characters.
  [simplifiedString stringByTrimmingCharactersInSet:validRomanNumeralCharacterSet];
  
  // Variable to hold the current roman numeral occurance that can be reduced
  // when iterating through the above constant array.
  NSString * currentRomanNumeral = nil;
  
  // Temporary variable to hold the modified string.
  NSString * temporarySimplifiedString = nil;
  
  // For all the roman numerals occurances that can be reduced,
  for(int i = 0; i < [romanNumerals count]; i++){
    // Grab the current roman numeral occurance that can be reduced.
    currentRomanNumeral = [romanNumerals objectAtIndex:i];
    
    // Remove all the current roman numerals occurances that can be reduced from the string.
    temporarySimplifiedString = [simplifiedString stringByReplacingOccurrencesOfString:currentRomanNumeral withString:@""];
    
    // Recall from above that the first 3 occurances saves 3 roman numerals.
    
    // If it is one of the first 3 roman numeral occurances,
    if(i < 3){
      // Compute the size difference of the string before and after the removal,
      // divide it by the length of the current roman numeral (as we removed only
      // strings of that length), and multiply it by 3. Add that value to the
      // number of roman numerals removed.
      romanNumeralsRemoved += (((simplifiedString.length - temporarySimplifiedString.length) / currentRomanNumeral.length) * 3);
    }
    // If it is one of the last 6 roman numeral occurances,
    else{
      // Compute the size difference of the string before and after the removal,
      // divide it by the length of the current roman numeral (as we removed only
      // strings of that length), and multiply it by 2. Add that value to the
      // number of roman numerals removed.
      romanNumeralsRemoved += (((simplifiedString.length - temporarySimplifiedString.length) / currentRomanNumeral.length) * 2);
    }
    // Set the string to be the string with the current roman numeral removed.
    simplifiedString = temporarySimplifiedString;
  }
  // Return the number of roman numerals removed.
  return romanNumeralsRemoved;
}

- (NSString *)reducedStringOfRomanNumeralsForNumber:(uint)aNumber; {
  // This method takes in a number, computes the reduced roman numeral form, and
  // returns it as a string. We note that the only ways to reduce a roman numeral
  // is on the 9, 5, and 4 "digits" of the 100's, 10's, and 1's. The rules are
  // explained better here:
  //
  // http://projecteuler.net/about=roman_numerals
  //
  // Therefore, we need only add on all the M's for the thousands digit, then
  // check the 9, 5, and 4 "digits" for the 100's, 10's, and 1's, and then add
  // on all the "units" (i.e.: C, X, and I) to complete the numeral. We loop
  // from the hundreds down to the ones to compact the code.
  
  // Variable to hold the current "digit" we are looking at, 100, 10, and 1.
  uint currentSize = 100;
  
  // Variable to hold the current number used while iterating.
  uint currentNumber = aNumber;
  
  // Variable to hold the number of "units" for each digit, 1000, 100, 10, and 1.
  // Default it to the "units" for 1000.
  uint numberOfUnits = ((uint)(currentNumber / 1000));
  
  // Variable to hold the current fives "digit" we are looking at, 500, 50, and 5.
  uint currentFivesValue = 500;
  
  // Variable to hold the current fours "digit" we are looking at, 400, 40, and 4.
  uint currentFoursValue = 400;
  
  // Variable to hold the current nines "digit" we are looking at, 900, 90, and 9.
  uint currentNinesValue = 900;
  
  // Variable to hold the tens "digit" roman numeral while iterating, M, C, and X.
  // Default it to M, as we set it at the end of the loop when iterating.
  NSString * currentTensRomanNumeral = @"M";
  
  // Variable to hold the fives "digit" roman numeral while iterating, D, L, and V.
  NSString * currentFivesRomanNumeral = nil;
  
  // Variable to hold the units "digit" roman numeral while iterating, C, X, and I.
  NSString * currentUnitsRomanNumeral = nil;
  
  // Variable to hold the roman numeral in a string.
  NSMutableString * romanNumeral = [NSMutableString string];
  
  // Constant array to hold the roman numerals for the fives "digit".
  const NSArray * fivesRomanNumeral = [NSArray arrayWithObjects:@"D", @"L", @"V", nil];
  
  // Constant array to hold the roman numerals for the units "digit".
  const NSArray * unitsRomanNumeral = [NSArray arrayWithObjects:@"C", @"X", @"I", nil];
  
  // First, we add on all the M's for the thousands "digit".
  
  // Remove the thousands "digit" from the current number.
  currentNumber -= (1000 * numberOfUnits);
  
  // While the number of units (M's) is greater than 0,
  while(numberOfUnits > 0){
    // Add on the roman numeral M to the roman numeral string.
    [romanNumeral appendString:@"M"];
    
    // Decrement the number of units (M's) by 1.
    numberOfUnits--;
  }
  
  // Now, add on the values less than 1000. We iterate over the 100's, 10's, and
  // 1's digits. They all follow the exact same rules, they just use different
  // letter, which are defined in the constant array's above.
  
  // For all the roman numerals in the constant roman numerals array,
  for(int i = 0; i < [unitsRomanNumeral count]; i++){
    // Grab the current "fives" roman numeral.
    currentFivesRomanNumeral = [fivesRomanNumeral objectAtIndex:i];
    
    // Grab the current "units" roman numeral.
    currentUnitsRomanNumeral = [unitsRomanNumeral objectAtIndex:i];
    
    // If the current number is has a nine "digit",
    if(currentNumber >= currentNinesValue){
      // Add on the current units roman numeral to the roman numeral string.
      [romanNumeral appendString:currentUnitsRomanNumeral];
      
      // Add on the current tens roman numeral to the roman numeral string.
      [romanNumeral appendString:currentTensRomanNumeral];
      
      // Subtract the current value of the nine "digit" from the current number.
      currentNumber -= currentNinesValue;
    }
    // If the current number is has a five "digit",
    else if(currentNumber >= currentFivesValue){
      // Add on the current fives roman numeral to the roman numeral string.
      [romanNumeral appendString:currentFivesRomanNumeral];
      
      // Subtract the current value of the five "digit" from the current number.
      currentNumber -= currentFivesValue;
    }
    // If the current number is has a four "digit",
    else if(currentNumber >= currentFoursValue){
      // Add on the current units roman numeral to the roman numeral string.
      [romanNumeral appendString:currentUnitsRomanNumeral];
      
      // Add on the current fives roman numeral to the roman numeral string.
      [romanNumeral appendString:currentFivesRomanNumeral];
      
      // Subtract the current value of the four "digit" from the current number.
      currentNumber -= currentFoursValue;
    }
    // Compute the remaining units "digit" from the current number.
    numberOfUnits = ((uint)(currentNumber / currentSize));
    
    // Subtract off the remaining units "digit" from the current number.
    currentNumber -= (currentSize * numberOfUnits);
    
    // While the number of current units "digit" is greater than 0,
    while(numberOfUnits > 0){
      // Add on the current units roman numeral to the roman numeral string.
      [romanNumeral appendString:currentUnitsRomanNumeral];
      
      // Decrement the number of current units "digits" by 1.
      numberOfUnits--;
    }
    // Divide the current size by 10 to move to the next "digit".
    currentSize /= 10;
    
    // Divide the current fives value by 10 to move to the next "digit".
    currentFivesValue /= 10;
    
    // Divide the current fours value by 10 to move to the next "digit".
    currentFoursValue /= 10;
    
    // Divide the current nines value by 10 to move to the next "digit".
    currentNinesValue /= 10;
    
    // Set the current tens "digit" roman numeral to the current units "digit"
    // roman numeral.
    currentTensRomanNumeral = currentUnitsRomanNumeral;
  }
  // Return the constructed reduced roman numeral as a string.
  return romanNumeral;
}

- (NSString *)reducedStringOfRomanNumeralsFromRomanNumeralsString:(NSString *)aString; {
  // This is just a helper method to take the inputted roman numeral string,
  // compute its base 10 value, and return the reduced roman numeral string.
  return [self reducedStringOfRomanNumeralsForNumber:[self numberFromRomanNumeralsString:aString]];
}

@end