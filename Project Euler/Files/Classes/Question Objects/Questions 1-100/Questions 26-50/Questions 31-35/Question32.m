//  Question32.m

#import "Question32.h"

@implementation Question32

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"06 December 2002";
  self.hint = @"Only check all the 2 digit numbers multiplied by a 3 digit number that returns a 4 digit number.";
  self.text = @"We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once; for example, the 5-digit number, 15234, is 1 through 5 pandigital.\n\nThe product 7254 is unusual, as the identity, 39 x 186 = 7254, containing multiplicand, multiplier, and product is 1 through 9 pandigital.\n\nFind the sum of all products whose multiplicand/multiplier/product identity can be written as a 1 through 9 pandigital.\n\nHINT: Some products can be obtained in more than one way so be sure to only include it once in your sum.";
  self.isFun = YES;
  self.title = @"Pandigital products";
  self.answer = @"45228";
  self.number = @"32";
  self.rating = @"4";
  self.keywords = @"pandigital,sum,all,digit,multiplicand,multiplier,products,identity,written,containing,obtained";
  self.difficulty = @"Easy";
  self.solutionLineCount = @"37";
  self.estimatedComputationTime = @"7.15e-03";
  self.estimatedBruteForceComputationTime = @"7.55e-02";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we loop through all the potential multipliers and multiplicands to see
  // if the resulting number is a pandigital number or not. Luckily, in Question
  // 24, we already made a method to check this, so our work is much easier (The
  // helper method is in the super class, and is explained there).
  //
  // We simply compute the product, and to get the resulting pandigital number,
  // we use the equation:
  //
  // potentialPandigitalNumber = product * 100000 + multiplicand * 100 + multiplier;
  //
  // As the multiplicand must be a triple digit number, and the multiplier must
  // be a double digit number.
  //
  // We could make this a bit fast by checking each of the multiplier, multiplicand,
  // and product for duplicates BEFORE checking the whole number, but this runs
  // very fast already!
  
  // Variable to hold the total of all the products who has the desired property.
  uint total = 0;
  
  // Variable to hold the product of the multiplicand and multiplier.
  uint product = 0;
  
  // Variable to hold the maximum number of pandigital products. It's set at 10
  // only after the answer is known. It was 100 on the first run.
  uint maxNumberOfPandigitalProducts = 10;
  
  // Variable to hold the number of the found pandigital products.
  uint numberOfFoundPandigitalProducts = 0;
  
  // Variable to hold the potential pandigital number.
  long long int potentialPandigitalNumber = 0;
  
  // Variable array to hold all the unique pandigital numbers found.
  uint foundPandigitalProducts[maxNumberOfPandigitalProducts];
  
  // For all the unique pandigital numbers found,
  for(int i = 0; i < maxNumberOfPandigitalProducts; i++){
    // Default the entry in the array to 0.
    foundPandigitalProducts[i] = 0;
  }
  
  // Note: We only need to check all the double digit multipliers and triple digit
  //       multiplicands, AND the single and 4-digit number, as the resulting
  //       product of any other numbers would not yield a pandigital number.
  
  // First, check the double and triple digit numbers.
  
  // The numbers 12 to 50 and 123 to 500 are refined after the first run.
  
  // For all the double digit multipliers,
  for(int i = 12; i < 50; i++){
    // For all the triple digit multiplicands,
    for(int j = 123; j < 500; j++){
      // Compute the product.
      product = i * j;
      
      // Compute the potential pandigital number.
      potentialPandigitalNumber = product * 100000 + j * 100 + i;
      
      // If the number is pandigital/lexographic,
      if([self isNumberLexographic:potentialPandigitalNumber countZero:NO]){
        // For all the previously found pandigital products,
        for(int index = 0; index < numberOfFoundPandigitalProducts; index++){
          // If the current product is equal to a found pandigital product,
          if(product == foundPandigitalProducts[index]){
            // It is not unique, so set it to 0.
            product = 0;
            
            // Break our of the loop.
            break;
          }
        }
        // If the product is non-zero,
        if(product > 0){
          // Add the product to the unique pandigital products already found.
          foundPandigitalProducts[numberOfFoundPandigitalProducts] = product;
          
          // Increment the number of unique pandigital products by 1.
          numberOfFoundPandigitalProducts++;
          
          // Increment the total of all the products who has the desired property,
          // by the product.
          total += product;
        }
      }
    }
  }
  
  // Now, check the single and 4-digit numbers.
  
  // The numbers 2 to 5 and 1234 to 2000 are refined after the first run.
  
  // For all the single digit multipliers,
  for(int i = 2; i < 5; i++){
    // For all the 4-digit multiplicands,
    for(int j = 1234; j < 2000; j++){
      // Compute the product.
      product = i * j;
      
      if(product > 10000){
        // Break out of the loop.
        break;
      }
      else{
        // Compute the potential pandigital number.
        potentialPandigitalNumber = product * 100000 + j * 10 + i;
        
        // If the number is pandigital/lexographic,
        if([self isNumberLexographic:potentialPandigitalNumber countZero:NO]){
          // For all the previously found pandigital products,
          for(int index = 0; index < numberOfFoundPandigitalProducts; index++){
            // If the current product is equal to a found pandigital product,
            if(product == foundPandigitalProducts[index]){
              // It is not unique, so set it to 0.
              product = 0;
              
              // Break our of the loop.
              break;
            }
          }
          // If the product is non-zero,
          if(product > 0){
            // Add the product to the unique pandigital products already found.
            foundPandigitalProducts[numberOfFoundPandigitalProducts] = product;
            
            // Increment the number of unique pandigital products by 1.
            numberOfFoundPandigitalProducts++;
            
            // Increment the total of all the products who has the desired property,
            // by the product.
            total += product;
          }
        }
      }
    }
  }
  // Set the answer string to the total of all the products who has the desired property.
  self.answer = [NSString stringWithFormat:@"%d", total];
  
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
  
  // Note: This is basically the same algorithm as the optimal one. The only
  //       difference is computing the pandigital number with string composition.
  
  // Here, we loop through all the potential multipliers and multiplicands to see
  // if the resulting number is a pandigital number or not. Luckily, in Question
  // 24, we already made a method to check this, so our work is much easier (The
  // helper method is in the super class, and is explained there).
  //
  // We simply compute the product, and to get the resulting pandigital number,
  // we use string composition.
  //
  // We could make this a bit fast by checking each of the multiplier, multiplicand,
  // and product for duplicates BEFORE checking the whole number, but this runs
  // very fast already!
  
  // Variable to hold the total of all the products who has the desired property.
  uint total = 0;
  
  // Variable to hold the product of the multiplicand and multiplier.
  uint product = 0;
  
  // Variable to hold the maximum number of pandigital products. It's set at 10
  // only after the answer is known. It was 100 on the first run.
  uint maxNumberOfPandigitalProducts = 10;
  
  // Variable to hold the number of the found pandigital products.
  uint numberOfFoundPandigitalProducts = 0;
  
  // Variable array to hold all the unique pandigital numbers found.
  uint foundPandigitalProducts[maxNumberOfPandigitalProducts];
  
  // Variable to hold the potential pandigital number as a string.
  NSString * potentialPandigitalNumber = nil;
  
  // For all the unique pandigital numbers found,
  for(int i = 0; i < maxNumberOfPandigitalProducts; i++){
    // Default the entry in the array to 0.
    foundPandigitalProducts[i] = 0;
  }
  
  // Note: We only need to check all the double digit multipliers and triple digit
  //       multiplicands, AND the single and 4-digit number, as the resulting
  //       product of any other numbers would not yield a pandigital number.
  
  // First, check the double and triple digit numbers.
  
  // The numbers 12 to 50 and 123 to 500 are refined after the first run.
  
  // For all the double digit multipliers,
  for(int i = 12; i < 50; i++){
    // For all the triple digit multiplicands,
    for(int j = 123; j < 500; j++){
      // Compute the product.
      product = i * j;
      
      // Compute the potential pandigital number as a string.
      potentialPandigitalNumber = [NSString stringWithFormat:@"%d%d%d", i, j, product];
      
      // If the number is pandigital/lexographic,
      if([self isNumberLexographic:[potentialPandigitalNumber longLongValue] countZero:NO]){
        for(int index = 0; index < numberOfFoundPandigitalProducts; index++){
          // If the current product is equal to a found pandigital product,
          if(product == foundPandigitalProducts[index]){
            // It is not unique, so set it to 0.
            product = 0;
            
            // Break our of the loop.
            break;
          }
        }
        // If the product is non-zero,
        if(product > 0){
          // Add the product to the unique pandigital products already found.
          foundPandigitalProducts[numberOfFoundPandigitalProducts] = product;
          
          // Increment the number of unique pandigital products by 1.
          numberOfFoundPandigitalProducts++;
          
          // Increment the total of all the products who has the desired property,
          // by the product.
          total += product;
        }
      }
    }
  }
  
  // Now, check the single and 4-digit numbers.
  
  // The numbers 12 to 50 and 123 to 500 are refined after the first run.
  
  // For all the single digit multipliers,
  for(int i = 2; i < 10; i++){
    // For all the 4-digit multiplicands,
    for(int j = 1234; j < 2000; j++){
      // Compute the product.
      product = i * j;
      
      // Compute the potential pandigital number as a string.
      potentialPandigitalNumber = [NSString stringWithFormat:@"%d%d%d", i, j, product];
      
      // If the number is pandigital/lexographic,
      if([self isNumberLexographic:[potentialPandigitalNumber longLongValue] countZero:NO]){
        for(int index = 0; index < numberOfFoundPandigitalProducts; index++){
          // If the current product is equal to a found pandigital product,
          if(product == foundPandigitalProducts[index]){
            // It is not unique, so set it to 0.
            product = 0;
            
            // Break our of the loop.
            break;
          }
        }
        // If the product is non-zero,
        if(product > 0){
          // Add the product to the unique pandigital products already found.
          foundPandigitalProducts[numberOfFoundPandigitalProducts] = product;
          
          // Increment the number of unique pandigital products by 1.
          numberOfFoundPandigitalProducts++;
          
          // Increment the total of all the products who has the desired property,
          // by the product.
          total += product;
        }
      }
    }
  }
  // Set the answer string to the total of all the products who has the desired property.
  self.answer = [NSString stringWithFormat:@"%d", total];
  
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