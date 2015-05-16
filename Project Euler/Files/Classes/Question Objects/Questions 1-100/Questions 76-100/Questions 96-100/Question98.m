//  Question98.m

#import "Question98.h"

@interface Question98 (Private)

- (BOOL)isString:(NSString *)aFirstString anAnagramOfString:(NSString *)aSecondString;
- (long long int)largestSquareFromString:(NSString *)aFirstString andAnagramOfString:(NSString *)aSecondString;

@end

@implementation Question98

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"17 June 2005";
  self.hint = @"Check if a pair is an anagram, and then check if the characters can be replaced to form 2 square numbers.";
  self.text = @"By replacing each of the letters in the word CARE with 1, 2, 9, and 6 respectively, we form a square number: 1296 = 36². What is remarkable is that, by using the same digital substitutions, the anagram, RACE, also forms a square number: 9216 = 96². We shall call CARE (and RACE) a square anagram word pair and specify further that leading zeroes are not permitted, neither may a different letter have the same digital value as another letter.\n\nUsing words.txt (right click and 'Save Link/Target As...'), a 16K text file containing nearly two-thousand common English words, find all the square anagram word pairs (a palindromic word is NOT considered to be an anagram of itself).\n\nWhat is the largest square number formed by any member of such a pair?\n\nNOTE: All anagrams formed must be contained in the given text file.";
  self.title = @"Anagramic squares";
  self.answer = @"18769";
  self.number = @"98";
  self.rating = @"4";
  self.keywords = @"anagrams,squares,pairs,words,import,same,number,two,thousand,2000,member,file,anagramic";
  self.difficulty = @"Easy";
  self.estimatedComputationTime = @"4.87";
  self.estimatedBruteForceComputationTime = @"6.83";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply parse the file into an array of strings. Then, we use two
  // helper methods to first determine if a pair is an anagram, and then if the
  // characters can be replaced to form two square numbers. If they can be, we
  // compare it to the largest square found so far, and store the largest square
  // for printing later.
  
  // Variable to hold the largest square of all the anagrams found.
  uint largestSquare = 0;
  
  // Variable to hold the largest words length in the file.
  uint largestWordsLength = 0;
  
  // Variable to hold the largest square of the currently found anagrams.
  uint potentialLargestSquare = 0;
  
  // Variable to hold the path to the file that holds the words data.
  NSString * path = [[NSBundle mainBundle] pathForResource:@"wordsQuestion98" ofType:@"txt"];
  
  // Variable to hold the first word while iterating.
  NSString * firstWord = nil;
  
  // Variable to hold the second word while iterating.
  NSString * secondWord = nil;
  
  // Variable to hold the words list as a string for parsing.
  NSString * wordsList = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
  
  // Variable to hold each word as a string in an array.
  NSArray * wordsArray = [wordsList componentsSeparatedByString:@"\",\""];
  
  // For all the words in the words array,
  for(NSString * word in wordsArray){
    // If the largest words length is less than the current words length,
    if(largestWordsLength < word.length){
      // Set the largest words length to be the current words length.
      largestWordsLength = (uint)word.length;
    }
  }
  // If the largest words length is greater than 1 (as we must have at least a
  // two letter word),
  if(largestWordsLength > 1){
    // Variable array to hold the the array of all the words with the same
    // length.
    NSMutableArray * currentWordSizeArray = nil;
    
    // Variable to hold t all the arrays of words with the same lengths.
    NSMutableArray * wordsBySizesArray = [[NSMutableArray alloc] initWithCapacity:(largestWordsLength - 1)];
    
    // For all the words with length from 2 up to the largest length in the file,
    for(int i = 0; i < (largestWordsLength - 1); i++){
      // Initialize an array to hold all the words of the same size.
      currentWordSizeArray = [[NSMutableArray alloc] init];
      
      // Add the array to the array that holds all the the arrays.
      [wordsBySizesArray addObject:currentWordSizeArray];
    }
    // For all the words in the words array,
    for(NSString * word in wordsArray){
      // If the words length is greater than 1,
      if(word.length > 1){
        // Grab the array which has all the words that have the same length as
        // the current word,
        currentWordSizeArray = [wordsBySizesArray objectAtIndex:(word.length - 2)];
        
        // Add the current word to that array.
        [currentWordSizeArray addObject:word];
      }
    }
    // For all the word sizes, starting with the largest size,
    for(int currentWordSize = ((uint)[wordsBySizesArray count] - 1); currentWordSize >= 0; currentWordSize--){
      // Grab the array that holds all the words with the current length.
      currentWordSizeArray = [wordsBySizesArray objectAtIndex:currentWordSize];
      
      // For every word string in the words array,
      for(int firstWordIndex = 0; firstWordIndex < [currentWordSizeArray count]; firstWordIndex++){
        // Grab the current first word.
        firstWord = [currentWordSizeArray objectAtIndex:firstWordIndex];
        
        // For every word string in the words array AFTER the first word,
        for(int secondWordIndex = (firstWordIndex + 1); secondWordIndex < [currentWordSizeArray count]; secondWordIndex++){
          // Grab the current second word.
          secondWord = [currentWordSizeArray objectAtIndex:secondWordIndex];
          
          // Grab the potential largest square found from the two words.
          potentialLargestSquare = (uint)[self largestSquareFromString:firstWord andAnagramOfString:secondWord];
          
          // If the potential largest square is largest than the previous largest
          // square found,
          if(largestSquare < potentialLargestSquare){
            // Set the largest square found to the current largest square.
            largestSquare = potentialLargestSquare;
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
      // If we have found a largest square anagram,
      if(largestSquare > 0){
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
    // Set the answer string to the largest square of all the anagrams found.
    self.answer = [NSString stringWithFormat:@"%d", largestSquare];
    
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
  
  // Note: This is basically the same algorithm as the optimal one. The optimal
  //       algorithm just separates the strings into multiple arrays based on
  //       their sizes.
  
  // Here, we simply parse the file into an array of strings. Then, we use two
  // helper methods to first determine if a pair is an anagram, and then if the
  // characters can be replaced to form two square numbers. If they can be, we
  // compare it to the largest square found so far, and store the largest square
  // for printing later.
  
  // Variable to hold the largest square of all the anagrams found.
  uint largestSquare = 0;
  
  // Variable to hold the largest square of the currently found anagrams.
  uint potentialLargestSquare = 0;
  
  // Variable to hold the path to the file that holds the words data.
  NSString * path = [[NSBundle mainBundle] pathForResource:@"wordsQuestion98" ofType:@"txt"];
  
  // Variable to hold the words list as a string for parsing.
  NSString * wordsList = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
  
  // Variable to hold each word as a string in an array.
  NSArray * wordsArray = [wordsList componentsSeparatedByString:@"\",\""];
  
  // Variable to hold the first word while iterating.
  NSString * firstWord = nil;
  
  // Variable to hold the second word while iterating.
  NSString * secondWord = nil;
  
  // For every word string in the words array,
  for(int firstWordIndex = 0; firstWordIndex < [wordsArray count]; firstWordIndex++){
    // Grab the current first word.
    firstWord = [wordsArray objectAtIndex:firstWordIndex];
    
    // For every word string in the words array AFTER the first word,
    for(int secondWordIndex = (firstWordIndex + 1); secondWordIndex < [wordsArray count]; secondWordIndex++){
      // Grab the current second word.
      secondWord = [wordsArray objectAtIndex:secondWordIndex];
      
      // Grab the potential largest square found from the two words.
      potentialLargestSquare = (uint)[self largestSquareFromString:firstWord andAnagramOfString:secondWord];
      
      // If the potential largest square is largest than the previous largest
      // square found,
      if(largestSquare < potentialLargestSquare){
        // Set the largest square found to the current largest square.
        largestSquare = potentialLargestSquare;
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
    // Set the answer string to the largest square of all the anagrams found.
    self.answer = [NSString stringWithFormat:@"%d", largestSquare];
    
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

@implementation Question98 (Private)

- (BOOL)isString:(NSString *)aFirstString anAnagramOfString:(NSString *)aSecondString; {
  // Here, we simply extract all the characters of both strings into separate
  // arrays, order the arrays alphabetically, and check if they are equal.
  
  // If the first string does NOT have the same length as the second string,
  if(aFirstString.length != aSecondString.length){
    // The strings CANNOT be anagrams of each other, so return NO.
    return NO;
  }
  // If the two strings are the same string,
  if([aFirstString isEqualToString:aSecondString]){
    // The strings CANNOT be anagrams of each other, so return NO.
    return NO;
  }
  // Variable to hold the length of the first string, and by default, the second
  // strings length as well.
  uint stringLength = (uint)aFirstString.length;
  
  // If the string's have a length less than 1,
  if(stringLength < 1){
    // Return that the strings are NOT anagrams of each other, as by definition,
    // a palindromic word is NOT considered to be an anagram of itself.
    return NO;
  }
  // Variable array to hold the individual characters of the first string.
  NSMutableArray * firstStringsCharacters = [[NSMutableArray alloc] initWithCapacity:stringLength];
  
  // Variable array to hold the individual characters of the second string.
  NSMutableArray * secondStringsCharacters = [[NSMutableArray alloc] initWithCapacity:stringLength];
  
  // Variable to hold the index and length of the current character.
  NSRange subStringRange;
  
  // While the current index is greater than 0,
  while(stringLength > 0){
    // Decrease the currentIndex by 1, which is equivalent to looking at the
    // next character to the right.
    stringLength--;
    
    // Compute the range of the next character.
    subStringRange = NSMakeRange(stringLength, 1);
    
    // Add the current character of the first string to the first strings
    // characters array.
    [firstStringsCharacters addObject:[aFirstString substringWithRange:subStringRange]];
    
    // Add the current character of the second string to the second strings
    // characters array.
    [secondStringsCharacters addObject:[aSecondString substringWithRange:subStringRange]];
  }
  // Order the first strings characters array alphabetically.
  firstStringsCharacters = (NSMutableArray *)[firstStringsCharacters sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
  
  // Order the second strings characters array alphabetically.
  secondStringsCharacters = (NSMutableArray *)[secondStringsCharacters sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
  
  // Return if both strings have the same characters or not.
  return [firstStringsCharacters isEqualToArray:secondStringsCharacters];
}

- (long long int)largestSquareFromString:(NSString *)aFirstString andAnagramOfString:(NSString *)aSecondString; {
  // Here, we compare the strings to make sure they are anagrams of each other.
  // Next, we compute the maximum and minimum square numbers that the strings
  // can map to. We then loop through all of the squares, trying to map each
  // square to the inputted number. We do this by moving character to character,
  // and replacing each instance of the character with the appropriate digit. If
  // we find that the mapping works, we simply check the second strings mapping
  // to make sure that it is also a square number. We then simply store and
  // return the largest value.
  
  // If the first and second strings are anagrams of each other,
  if([self isString:aFirstString anAnagramOfString:aSecondString]){
    // Variable to mark if we have found a mapping from the first string to a
    // square number.
    BOOL foundFirstStringSquare = NO;
    
    // Variable to hold the current index of the string.
    int currentIndex = 0;
    
    // Variable to hold the current square number we are looking at.
    long long int square = 0;
    
    // Variable to hold the maximum square number the string can map to.
    long long int maxSquare = ((long long int)sqrt(pow(10.0, ((double)aFirstString.length))));
    
    // Variable to hold the minimum square number the string can map to.
    long long int minSquare = ((long long int)sqrt(pow(10.0, ((double)(aFirstString.length - 1)))));
    
    // Variable to hold the largest square value from the mapping.
    long long int largestFirstStringSquare = 0;
    
    // Variable to hold the index and length of the current "digit".
    NSRange subStringRange;
    
    // Variable to hold the current digit of the square number we are looking at.
    NSString * digit = nil;
    
    // Variable to hold the current character of the first inputted string.
    NSString * character = nil;
    
    // Variable to hold a copy of the first inputted string.
    NSString * firstStringCopy = nil;
    
    // Variable to hold the current square number as a string.
    NSString * squareAsAString = nil;
    
    // Variable to hold a copy of the second inputted string.
    NSString * secondStringCopy = nil;
    
    // Get a set of characters that are not decimal numbers.
    NSCharacterSet * nonNumbers = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    
    // If there are an even number of characters in the inputted strings,
    if((aFirstString.length % 2) == 0){
      // Increment the minimum square number by 1.
      minSquare++;
      
      // Decrement the maximum square number by 1.
      maxSquare--;
    }
    // For all the square root numbers from the maximum square root number to
    // the minimum square root number,
    for(long long int squareRoot = maxSquare; squareRoot >= minSquare; squareRoot--){
      // Compute the square number.
      square = squareRoot * squareRoot;
      
      // Mark that we have found a valid mapping.
      foundFirstStringSquare = YES;
      
      // Store the current square as a string.
      squareAsAString = [NSString stringWithFormat:@"%llu", square];
      
      // Copy the first inputted string.
      firstStringCopy = [NSString stringWithFormat:@"%@", aFirstString];
      
      // Copy the second inputted string.
      secondStringCopy = [NSString stringWithFormat:@"%@", aSecondString];
      
      // Reset the current index to 0, the start of the string.
      currentIndex = 0;
      
      // While the current index is less than the length of the inputted strings,
      while(currentIndex < aFirstString.length){
        // Compute the range of the next "digit".
        subStringRange = NSMakeRange(currentIndex, 1);
        
        // Compute the current digit of the square number given the by current
        // index.
        digit = [squareAsAString substringWithRange:subStringRange];
        
        // Compute the current character of the first string given by the
        // current index.
        character = [firstStringCopy substringWithRange:subStringRange];
        
        // If the digit has already been replaced,
        if([digit isEqualToString:@"a"]){
          // If the character is NOT a decimal number,
          if([character rangeOfCharacterFromSet:nonNumbers].location != NSNotFound){
            // We have not made a good mapping, so mark that we have NOT found a
            // proper mapping.
            foundFirstStringSquare = NO;
            
            // Break out of the loop.
            break;
          }
        }
        // If the character is a decimal number,
        if([character rangeOfCharacterFromSet:nonNumbers].location == NSNotFound){
          // If the already replaced decimal number is NOT the same value as the
          // current digit,
          if([character isEqualToString:digit] == NO){
            // We have not made a good mapping, so mark that we have NOT found a
            // proper mapping.
            foundFirstStringSquare = NO;
            
            // Break out of the loop.
            break;
          }
        }
        // If the character is NOT a decimal number,
        else{
          // Replace all the occurrences of the current character in the first
          // strings copy with the current digit.
          firstStringCopy = [firstStringCopy stringByReplacingOccurrencesOfString:character withString:digit];
          
          // Replace all the occurrences of the current character in the second
          // strings copy with the current digit.
          secondStringCopy = [secondStringCopy stringByReplacingOccurrencesOfString:character withString:digit];
          
          // Replace all the occurrences of the current digit in the square
          // number with the letter "a".
          squareAsAString = [squareAsAString stringByReplacingOccurrencesOfString:digit withString:@"a"];
        }
        // Increment the currentIndex by 1, which is equivalent to looking at
        // the next digit to the right.
        currentIndex++;
      }
      // If we have found a mapping from the first inputted string to a square
      // number,
      if(foundFirstStringSquare){
        // Store the current square as a string.
        squareAsAString = [NSString stringWithFormat:@"%llu", square];
        
        // If the mapping of the first string to the square number is equal to
        // the square number,
        if([firstStringCopy isEqualToString:squareAsAString]){
          // Remove the leading 0's from the second strings mapping. Also note
          // that the mapping MUST be a number, as the strings were anagrams of
          // each other.
          secondStringCopy = [NSString stringWithFormat:@"%llu", [secondStringCopy longLongValue]];
          
          // If the mapping produced numbers of the same lenght,
          if(firstStringCopy.length == secondStringCopy.length){
            // If the second number is also a perfect square,
            if([self isNumberAPerfectSquare:[secondStringCopy longLongValue]]){
              // If the current square number is greater than the previously
              // found largest square number,
              if(largestFirstStringSquare < square){
                // Set the largest square number to the current square number.
                largestFirstStringSquare = square;
              }
              // If the second inputted strings mapping square number is greater
              // than the previously found largest square number,
              if(largestFirstStringSquare < [secondStringCopy longLongValue]){
                // Set the largest square number to the square number in the
                // second inputted strings mapping.
                largestFirstStringSquare = [secondStringCopy longLongValue];
              }
            }
          }
        }
      }
    }
    // Return the largest first strings square value.
    return largestFirstStringSquare;
  }
  // If the first and second strings are NOT anagrams of each other,
  else{
    // Return the largest square that can be made, namely, 0.
    return 0;
  }
}

@end