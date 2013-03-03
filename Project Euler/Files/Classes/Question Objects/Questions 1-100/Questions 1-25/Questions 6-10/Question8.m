//  Question8.m

#import "Question8.h"
#import "Global.h"

@interface Question8 (Private)

- (MovingProduct5)string:(NSString *)aString index:(uint)aIndex;

@end

@implementation Question8

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"11 January 2002";
  self.text = @"Find the greatest product of five consecutive digits in the 1000-digit number.\n\n7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450";
  self.title = @"Largest product in a series";
  self.answer = @"40824";
  self.number = @"Problem 8";
  self.estimatedComputationTime = @"6.34e-04";
  self.estimatedBruteForceComputationTime = @"2.72e-03";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // The number to search through to find the product.
  NSString * searchNumberAsAString = @"7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450";
  
  // Variable to hold the index and length of the current "digit".
  NSRange subStringRange;
  
  // Variable to hold the integer value of the current "digit".
  uint digitValue = 0;
  
  // Variable to hold the largest product found.
  uint largestProduct = 0;
  
  // Variable to hold the moving product. Set it by default to the first valid
  // MovingProduct5 returned by the helper method.
  MovingProduct5 movingProduct = [self string:searchNumberAsAString index:0];
  
  // If the product returned by the helper method is non-zero, a valid product
  // has been found, so keep going!
  if(movingProduct.product != 0){
    // If the current product is larger than the last largest product,
    if(movingProduct.product > largestProduct){
      // Set the largest product to be the current product.
      largestProduct = movingProduct.product;
    }
    // While there are enough digits remaining to compute the MovingProduct5,
    while(movingProduct.index < [searchNumberAsAString length]){
      // Compute the new current range.
      subStringRange = NSMakeRange(movingProduct.index, 1);
      
      // Grab the value of the current "digit".
      digitValue = [[searchNumberAsAString substringWithRange:subStringRange] intValue];
      
      // If the "digit" value is 0,
      if(digitValue == 0){
        // Grab the next valid MovingProduct5.
        movingProduct = [self string:searchNumberAsAString index:movingProduct.index];
        
        // If the product returned by the helper method is zero.
        if(movingProduct.product == 0){
          // A valid product has NOT been found, so exit the loop.
          break;
        }
      }
      // If the "digit" value is NOT 0,
      else{
        // Divide the product by the left most "digit" in the product.
        movingProduct.product /= movingProduct.numbersInProduct[0];
        
        // Multiply the product by the current "digit" value.
        movingProduct.product *= digitValue;
        
        // Move the numbers in the product to the left.
        movingProduct = MovingProduct5ShiftLeft(movingProduct);
        
        // Set the new value of the right most "digit" in the product to the
        // current "digit" value.
        movingProduct.numbersInProduct[4] = digitValue;
      }
      // If the current product is larger than the last largest product,
      if(movingProduct.product > largestProduct){
        // Set the largest product to be the current product.
        largestProduct = movingProduct.product;
      }
      // Increase the currentIndex by 1, which is equivalent to looking at the
      // next digit to the right.
      movingProduct.index++;
    }
  }
  // Set the answer string to the largest product.
  self.answer = [NSString stringWithFormat:@"%d", largestProduct];
  
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
  
  // The number to search through to find the product.
  NSString * searchNumberAsAString = @"7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450";
  
  // Variable to hold the index and length of the current "digit".
  NSRange subStringRange;
  
  // Variable to hold the current "digit" index while moving through the string.
  NSInteger characterIndex = 0;
  
  // Variable to hold the current product.
  uint currentProduct = 1;
  
  // Variable to hold the largest product found.
  uint largestProduct = 1;
  
  // While there are enough digits remaining to compute the product,
  while(characterIndex < ([searchNumberAsAString length] - 5)){
    // Start the default of the product to the unit 1.
    currentProduct = 1;
    
    // For all the numbers from the starting index to the end index,
    for(int i = 0; i < 5; i++){
      // Compute the new current range.
      subStringRange = NSMakeRange(characterIndex + i, 1);
      
      // Multiply the current product by the current "digit" value.
      currentProduct *= [[searchNumberAsAString substringWithRange:subStringRange] intValue];
    }
    // If the current product is larger than the last largest product,
    if(currentProduct > largestProduct){
      // Set the largest product to be the current product.
      largestProduct = currentProduct;
    }
    // Increase the currentIndex by 1, which is equivalent to looking at the
    // next digit to the right.
    characterIndex++;
  }
  // Set the answer string to the largest product.
  self.answer = [NSString stringWithFormat:@"%d", largestProduct];
  
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

@implementation Question8 (Private)

- (MovingProduct5)string:(NSString *)aString index:(uint)aIndex; {
  // This helper method finds the next product of the numbers given the starting
  // index. If the product ever becomes 0 (i.e.: the current digit is 0), then
  // it recursively calls itself to find the next product. There is a check to
  // make sure that the there is enough digits remaining in the string to actually
  // compute the product. If there isn't, this method returns a MovingProduct5 that
  // is filled with 0's.
  
  // Variable to hold the newly computed MovingProduct5 based on the index. It is
  // defaulted to a MovingProduct5 that is filled with 0's.
  MovingProduct5 movingProduct = MovingProduct5Zero;
  
  // If there are enough digits remaining to compute the MovingProduct5,
  if([aString length] > (aIndex + 5)){
    
    // Start the default of the product to the unit 1.
    movingProduct.product = 1;
    
    // Variable to hold the index and length of the current "digit".
    NSRange subStringRange;
    
    // Variable to hold the integer value of the current "digit".
    uint digitValue = 0;
    
    // Set the index of the MovingProduct5 to new index after the multiplication
    // is complete. We do this now as if a 0 appears in the product, we recursively
    // call this method, which will overwrite this value. If we do it after the
    // following loop, this will overwrite the value of the returned MovingProduct5,
    // which will give the wrong starting index.
    movingProduct.index = (aIndex + 5);
    
    // For all the numbers from the starting index to the end index,
    for(int i = 0; i < 5; i++){
      // Compute the new current range.
      subStringRange = NSMakeRange(aIndex + i, 1);
      
      // Grab the value of the current "digit".
      digitValue = [[aString substringWithRange:subStringRange] intValue];
      
      // If the "digit" value is 0,
      if(digitValue == 0){
        // Set the MovingProduct5 to the returned value of this method based on
        // the current index + 1 (i.e.: the "digit" to the right of the current
        // one).
        movingProduct = [self string:aString index:(subStringRange.location + 1)];
        
        // Exit the loop.
        break;
      }
      // If the "digit" value is NOT 0,
      else{
        // Multiply the prodcut by the current "digit" value.
        movingProduct.product *= digitValue;
        
        // Set the current "digit" value to the number in the prodcut based on
        // the index.
        movingProduct.numbersInProduct[i] = digitValue;
      }
    }
  }
  // Return the MovingProduct5.
  return movingProduct;
}

@end