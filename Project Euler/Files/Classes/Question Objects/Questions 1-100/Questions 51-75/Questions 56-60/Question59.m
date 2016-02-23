//  Question59.m

#import "Question59.h"

@implementation Question59

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"19 December 2003";
  self.hint = @"The XOR Cipher says: \"In God We Trust\".";
  self.text = @"Each character on a computer is assigned a unique code and the preferred standard is ASCII (American Standard Code for Information Interchange). For example, uppercase A = 65, asterisk (*) = 42, and lowercase k = 107.\n\nA modern encryption method is to take a text file, convert the bytes to ASCII, then XOR each byte with a given value, taken from a secret key. The advantage with the XOR function is that using the same encryption key on the cipher text, restores the plain text; for example, 65 XOR 42 = 107, then 107 XOR 42 = 65.\n\nFor unbreakable encryption, the key is the same length as the plain text message, and the key is made up of random bytes. The user would keep the encrypted message and the encryption key in different locations, and without both \"halves\", it is impossible to decrypt the message.\n\nUnfortunately, this method is impractical for most users, so the modified method is to use a password as a key. If the password is shorter than the message, which is likely, the key is repeated cyclically throughout the message. The balance for this method is using a sufficiently long password key for security, but short enough to be memorable.\n\nYour task has been made easy, as the encryption key consists of three lower case characters. Using cipher1.txt (right click and 'Save Link/Target As...'), a file containing the encrypted ASCII codes, and the knowledge that the plain text must contain common English words, decrypt the message and find the sum of the ASCII values in the original text.";
  self.isFun = YES;
  self.title = @"XOR decryption";
  self.answer = @"107359";
  self.number = @"59";
  self.rating = @"5";
  self.keywords = @"xor,decryption,god,key,ascii,values,encryption,password,import,unique,code,character,bytes,preferred,message,common,english,words,text,containing,cyclically";
  self.solveTime = @"90";
  self.difficulty = @"Easy";
  self.solutionLineCount = @"43";
  self.estimatedComputationTime = @"0.139e-02";
  self.estimatedBruteForceComputationTime = @"0.127";
  
  // The hidden message you get from the key "god" is:
  //
  // (The Gospel of John, chapter 1) 1 In the beginning the Word already existed. He was with God, and he was God. 2 He was in the beginning with God. 3 He created everything there is. Nothing exists that he didn't make. 4 Life itself was in him, and this life gives light to everyone. 5 The light shines through the darkness, and the darkness can never extinguish it. 6 God sent John the Baptist 7 to tell everyone about the light so that everyone might believe because of his testimony. 8 John himself was not the light; he was only a witness to the light. 9 The one who is the true light, who gives light to everyone, was going to come into the world. 10 But although the world was made through him, the world didn't recognize him when he came. 11 Even in his own land and among his own people, he was not accepted. 12 But to all who believed him and accepted him, he gave the right to become children of God. 13 They are reborn! This is not a physical birth resulting from human passion or plan, this rebirth comes from God.14 So the Word became human and lived here on earth among us. He was full of unfailing love and faithfulness. And we have seen his glory, the glory of the only Son of the Father.
  //
  // Awesome!
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply use a frequency analysis to determine the key. Basically,
  // we know that they encrypted text can be broken up into 3 parts (as there
  // are 3 characters in the key). Let n be the index of the character. Then the
  // 3 groups are the numbers with indices that are congruent to 0, 1, and 2
  // mod 3.
  //
  // If we store the distributions in an array for each group, we can examine
  // which characters appear more frequently. The most common english characters
  // are:
  //
  // " ", "e", "t", and "a".
  //
  // We get lucky here, and note that the space character is enough to decrypt
  // the message.
  //
  // You can learn more about the XOR Cipher here:
  //
  // http://en.wikipedia.org/wiki/XOR_cipher
  //
  // You can learn more about frequency analysis here:
  //
  // http://en.wikipedia.org/wiki/Frequency_analysis
  
  // Variable to hold the path to the file that holds the encrypted data.
  NSString * path = [[NSBundle mainBundle] pathForResource:@"cipher1Question59" ofType:@"txt"];
  
  // Variable to hold the data from the above file as a string.
  NSString * listOfEncryptedCharacters = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
  
  // Variable array to the hold the list of characters contained in the above
  // string.
  NSArray * charactersArray = [listOfEncryptedCharacters componentsSeparatedByString:@","];
  
  // Variable to hold the current character index for the key.
  uint keyIndex = 0;
  
  // Variable to hold the maximum value in the encrypted ascii keys.
  uint maxValue = 0;
  
  // Variable to hold the current ascii value of the XOR'd character and the
  // current key.
  uint asciiValue = 0;
  
  // Variable to hold the sum of the original ascii characters.
  uint sumOfOriginalAsciiCharacters = 0;
  
  // Variable to hold the current key we are testing out.
  uint keys[3] = {0};
  
  // Variable array to hold the characters (for each character of the key) with
  // the maximum occurances.
  uint maxOccurance[3] = {0};
  
  // Variable array to hold the indexes of the characters (for each character of
  // the key) with the maximum occurances.
  uint maxOccuranceIndex[3] = {0};
  
  // Variable array to hold the distributions of each character in the encrypted
  // text for each individual character of the key.
  uint distribution[3][(maxValue + 1)];
  
  // Variable to hold the decoded message.
  NSString * message = @"";
  
  // For all the characters in the ecrypted text,
  for(NSString * character in charactersArray){
    // If the ascii value is greater than the maximum value found thus far,
    if([character intValue] > maxValue){
      // Set the maximum value to be the current characters ascii value.
      maxValue = [character intValue];
    }
  }
  // For all the characters in the key,
  for(int characterIndex = 0; characterIndex < 3; characterIndex++){
    // For every ascii value up to the maximum ascii value found,
    for(int asciiValue = 0; asciiValue <= maxValue; asciiValue++){
      // Reset the distribution to 0.
      distribution[characterIndex][asciiValue] = 0;
    }
  }
  // For all the characters in the ecrypted text,
  for(NSString * character in charactersArray){
    // Increment the distribution of the encrypted texts character for the
    // current character of the key.
    distribution[keyIndex][[character intValue]]++;
    
    // Increment the key index by 1.
    keyIndex++;
    
    // If we are now looking at the fourth character of the key,
    if(keyIndex > 2){
      // Reset the key index to 0 to look at the first character of the
      // key, as the cipher is cyclic!
      keyIndex = 0;
    }
  }
  // For all the characters in the key,
  for(int characterIndex = 0; characterIndex < 3; characterIndex++){
    // For every ascii value up to the maximum ascii value found,
    for(int asciiValue = 0; asciiValue <= maxValue; asciiValue++){
      // If the distribution for this ascii value is greater than the maximum
      // value found thus far (for the current character in the key),
      if(distribution[characterIndex][asciiValue] > maxOccurance[characterIndex]){
        // Set the maximum ascii value to be the current characters distribution
        // (for the current character in the key).
        maxOccurance[characterIndex] = distribution[characterIndex][asciiValue];
        
        // Set the ascii values index to be the current characters ascii value
        // (for the current character in the key).
        maxOccuranceIndex[characterIndex] = asciiValue;
      }
    }
  }
  // Grab the ascii value of the most common english character, space!
  asciiValue = [@" " characterAtIndex:0];
  
  // For all the characters in the key,
  for(int characterIndex = 0; characterIndex < 3; characterIndex++){
    // Compute the key by XOR'ing the ascii value of the space key, and the
    // character which has the maximum occurance for each character.
    keys[characterIndex] = (asciiValue ^ maxOccuranceIndex[characterIndex]);
  }
  // Reset the key index to start with the first character.
  keyIndex = 0;
  
  // For all the characters in the ecrypted text,
  for(NSString * character in charactersArray){
    // Compute the XOR of the character and the current key.
    asciiValue = ([character intValue] ^ keys[keyIndex]);
    
    // Increment the key index by 1.
    keyIndex++;
    
    // If we are now looking at the fourth character of the key,
    if(keyIndex > 2){
      // Reset the key index to 0 to look at the first character of the
      // key, as the cipher is cyclic!
      keyIndex = 0;
    }
    // Append the character on the message string.
    message = [NSString stringWithFormat:@"%@%c", message, asciiValue];
    
    // Add the ascii value of the character to the sum of the original,
    // decrypted characters.
    sumOfOriginalAsciiCharacters += asciiValue;
  }
  // Though not needed, I felt it fitting to log to the console the final
  // key and message.
  NSLog(@"Message: %@", message);
  NSLog(@" ");
  NSLog(@"Key: %c%c%c", keys[0], keys[1], keys[2]);
  
  // Set the answer string to the sum of the original ascii characters.
  self.answer = [NSString stringWithFormat:@"%d", sumOfOriginalAsciiCharacters];
  
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
  
  // Here, we simply check ever key to see if the message generated has valid
  // ascii values. If it does, we count up the asciss values and break out of
  // the loop!
  
  // Variable to hold the path to the file that holds the encrypted data.
  NSString * path = [[NSBundle mainBundle] pathForResource:@"cipher1Question59" ofType:@"txt"];
  
  // Variable to hold the data from the above file as a string.
  NSString * listOfEncryptedCharacters = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
  
  // Variable array to the hold the list of characters contained in the above
  // string.
  NSArray * charactersArray = [listOfEncryptedCharacters componentsSeparatedByString:@","];
  
  // Variable to mark if the message have been found or not.
  BOOL foundMessage = NO;
  
  // Variable to hold the current character index for the key.
  uint keyIndex = 0;
  
  // Variable to hold the current ascii value of the XOR'd character and the
  // current key.
  uint asciiValue = 0;
  
  // Variable to hold the sum of the original ascii characters.
  uint sumOfOriginalAsciiCharacters = 0;
  
  // Variable to hold the current key we are testing out.
  uint keys[3] = {0};
  
  // Variable to hold the decoded message.
  NSString * message = @"";
  
  // Constant array to hold the acceptable english characters the message can
  // have.
  const NSArray * acceptableCharacters = [NSArray arrayWithObjects:@" ", @"!", @"'", @"(", @")", @",", @".", @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @":", @";", @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", @"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z", nil];
  
  // Hash table for easy look-up to see if a given ascii value is valid.
  NSMutableDictionary * isCharacterAcceptable = [[NSMutableDictionary alloc] initWithCapacity:[acceptableCharacters count]];
  
  // For all the acceptable english characters,
  for(NSString * acceptableCharacter in acceptableCharacters){
    // Add the ascii value as a key to the Hash Table to easily look if the
    // character is valid or not.
    [isCharacterAcceptable setObject:[NSNumber numberWithBool:YES] forKey:[NSString stringWithFormat:@"%d", [acceptableCharacter characterAtIndex:0]]];
  }
  // We note that the key must contain only lower-case english characters, so
  // we need only check the ranges 97 (a) to 122(z).
  
  // For all the first chracters for the key, from a to z,
  for(int firstCharacterOfTheKey = 97; firstCharacterOfTheKey <= 122; firstCharacterOfTheKey++){
    // Set the first character of the key.
    keys[0] = firstCharacterOfTheKey;
    
    // For all the second chracters for the key, from a to z,
    for(int secondCharacterOfTheKey = 97; secondCharacterOfTheKey <= 122; secondCharacterOfTheKey++){
      // Set the second character of the key.
      keys[1] = secondCharacterOfTheKey;
      
      // For all the third chracters for the key, from a to z,
      for(int thirdCharacterOfTheKey = 97; thirdCharacterOfTheKey <= 122; thirdCharacterOfTheKey++){
        // Set the third character of the key.
        keys[2] = thirdCharacterOfTheKey;
        
        // Reset the key index to start with the first character.
        keyIndex = 0;
        
        // Reset the message string to the emtpy string.
        message = @"";
        
        // Set that we MAY have found the right key, and if we fully get through
        // the next loop, we have!
        foundMessage = YES;
        
        // Reset the sum of the original ascii characters to 0.
        sumOfOriginalAsciiCharacters = 0;
        
        // For all the characters in the ecrypted text,
        for(NSString * character in charactersArray){
          // Compute the XOR of the character and the current key.
          asciiValue = ([character intValue] ^ keys[keyIndex]);
          
          // If the ascii value is an acceptable character,
          if([[isCharacterAcceptable objectForKey:[NSString stringWithFormat:@"%d", asciiValue]] boolValue]){
            // Increment the key index by 1.
            keyIndex++;
            
            // If we are now looking at the fourth character of the key,
            if(keyIndex > 2){
              // Reset the key index to 0 to look at the first character of the
              // key, as the cipher is cyclic!
              keyIndex = 0;
            }
            // Append the character on the message string.
            message = [NSString stringWithFormat:@"%@%c", message, asciiValue];
            
            // Add the ascii value of the character to the sum of the original,
            // decrypted characters.
            sumOfOriginalAsciiCharacters += asciiValue;
          }
          // If the ascii value is NOT an acceptable character,
          else{
            // Mark that we haven't found the message with this key.
            foundMessage = NO;
            
            // Break out of the loop.
            break;
          }
        }
        // If we have decrypted the message and found the key,
        if(foundMessage){
          // Break out of the loop.
          break;
        }
      }
      // If we have decrypted the message and found the key,
      if(foundMessage){
        // Break out of the loop.
        break;
      }
    }
    // If we have decrypted the message and found the key,
    if(foundMessage){
      // Break out of the loop.
      break;
    }
  }
  // Though not needed, I felt it fitting to log to the console the final
  // key and message.
  NSLog(@"Message: %@", message);
  NSLog(@" ");
  NSLog(@"Key: %c%c%c", keys[0], keys[1], keys[2]);
  
  // Set the answer string to the sum of the original ascii characters.
  self.answer = [NSString stringWithFormat:@"%d", sumOfOriginalAsciiCharacters];
  
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