//  Question75.m

#import "Question75.h"

@implementation Question75

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"30 July 2004";
  self.hint = @"There's a formula to generate all the pythagorean triplets!";
  self.text = @"It turns out that 12 cm is the smallest length of wire that can be bent to form an integer sided right angle triangle in exactly one way, but there are many more examples.\n\n12 cm: (3,4,5)\n24 cm: (6,8,10)\n30 cm: (5,12,13)\n36 cm: (9,12,15)\n40 cm: (8,15,17)\n48 cm: (12,16,20)\n\nIn contrast, some lengths of wire, like 20 cm, cannot be bent to form an integer sided right angle triangle, and other lengths allow more than one solution to be found; for example, using 120 cm it is possible to form exactly three different integer sided right angle triangles.\n\n120 cm: (30,40,50), (20,48,52), (24,45,51)\n\nGiven that L is the length of the wire, for how many values of L <= 1,500,000 can exactly one integer sided right angle triangle be formed?";
  self.title = @"Singular integer right trangles";
  self.answer = @"161667";
  self.number = @"75";
  self.keywords = @"singular,integer,right,triangles,generation,primitives,pythagorean,triples,cm,smallest,length,sided,angle";
  self.estimatedComputationTime = @"6.5";
  self.estimatedBruteForceComputationTime = @"6.5";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply use the formulas to generate all the pythagorean triplets
  // under a maximum size. Once we find the primitive forms, we also check all
  // of the multiples and compute their side lengths. We then store the number
  // of triangles with that side length in a Hash Table. Once we are done, we
  // loop through all the triangle side lengths, and see which ones have only
  // one triangle associated with that side length. We then add one to the total
  // number of side lengths with exactly one integer sided right angle triangle,
  // and print that count.
  //
  // To generate all the primitives, we use the formula:
  //
  // a = m² - n², b = 2mn, c = m² + n²
  //
  // with n < m, (m - n) odd, and gcd(m,n) = 1.
  //
  // For more information about the Pythagorean Triples, visit:
  //
  // http://en.wikipedia.org/wiki/Pythagorean_triple#Generating_a_triple
  
  // Variable to hold the smallest side of the current right angled triangle.
  uint a = 0;
  
  // Variable to hold the middle side of the current right angled triangle.
  uint b = 0;
  
  // Variable to hold the hypotenuse of the current right angled triangle.
  uint c = 0;
  
  // Variable to hold the maximum side length any right angled triangle can have.
  uint maxSize = 1500000;
  
  // Variable to hold m² to make our computations easier.
  uint mSquared = 0;
  
  // Variable to hold n² to make our computations easier.
  uint nSquared = 0;
  
  // Variable to hold the side length of the primitive right angled triangle.
  uint sideLength = 0;
  
  // Variable to hold the maximum side length of any side of all the right
  // angled triangle.
  uint maxSideLength = ((uint)sqrt((double)maxSize));
  
  // Variable to hold the current side length of all the multiples of the current
  // right angled triangle.
  uint currentSideLength = 0;
  
  // Variable to hold the maximum multiple a triangle can have. Since the (3,4,5)
  // triangle is the smallest right angled triangle with integer side lengths,
  // we use it to compute the maximum number of mul
  uint maximumSideLengthMultiple = ((uint)(maxSize / (3 + 4 + 5)));
  
  // Variable to hold the number of side lengths with exactly one integer sided
  // right angle triangle.
  uint sideLengthWithOneTriangle = 0;
  
  // Variable to hold the number of right angled triangles with the current side
  // length.
  NSNumber * sideLengthCount = nil;
  
  // Variable to hold the current side length of the right angled triangle as a
  // string to store in our Hash Table.
  NSString * sideLengthString = nil;
  
  // Array to hold all the prime numbers less than the maximum side length.
  NSMutableArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:maxSideLength];
  
  // Variable dictionary to hold the number of the triangles with various side lengths.
  NSMutableDictionary * triangleSideLengthCounts = [[NSMutableDictionary alloc] init];
  
  // For all the n from 1 to the maximum side length,
  for(int n = 1; n < maxSideLength; n++){
    // Compute n².
    nSquared = n * n;
    
    // For all the m from (n + 1) up to the max side length, adding 2 for the
    // interval, as (m - n) must be odd,
    for(int m = (n + 1); m < maxSideLength; m += 2){
      // If m and n are coprime,
      if([self gcdOfA:m b:n primeNumbersArray:primeNumbersArray] == 1){
        // Compute m².
        mSquared = m * m;
        
        // Compute the side length a of the right angled triangle.
        a = (mSquared - nSquared);
        
        // Compute the side length b of the right angled triangle.
        b = (2 * m * n);
        
        // Compute the side length c of the right angled triangle.
        c = (mSquared + nSquared);
        
        // Compute the total side length L of the right angled triangle.
        sideLength = a + b + c;
        
        // Reset the current side length to 0.
        currentSideLength = 0;
        
        // For all the potential multiples of the current right triangle,
        for(int k = 1; k < maximumSideLengthMultiple; k++){
          // Increment the current side length by the primitive triangles side
          // length.
          currentSideLength += sideLength;
          
          // If the current side length is greater than the maximum side length
          // a triangle can have,
          if(currentSideLength > maxSize){
            // Break out of the loop.
            break;
          }
          // If the current side length is less than the maximum side length a
          // triangle can have,
          else{
            // Grab the side length as a string.
            sideLengthString = [NSString stringWithFormat:@"%d", currentSideLength];
            
            // Grab the current number of triangles with this side length.
            sideLengthCount = [triangleSideLengthCounts objectForKey:sideLengthString];
            
            // Increment the number of triangles with this side length by 1.
            sideLengthCount = [NSNumber numberWithInt:([sideLengthCount intValue] + 1)];
            
            // Store the number of triangles with this side length in the Hash
            // Table.
            [triangleSideLengthCounts setObject:sideLengthCount forKey:sideLengthString];
          }
          // If we are no longer computing,
          if(!_isComputing){
            // Break out of the loop.
            break;
          }
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
    // For all the trangle side lengths found,
    for(NSNumber * number in [triangleSideLengthCounts allValues]){
      // If the number of triangles with the current side length is 1,
      if([number intValue] == 1){
        // Increment the number of triangles with unique side length by 1.
        sideLengthWithOneTriangle++;
      }
    }
    // Set the answer string to the number of side lengths with exactly one
    // integer sided right angle triangle.
    self.answer = [NSString stringWithFormat:@"%d", sideLengthWithOneTriangle];
    
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
  
  // Here, we simply use the formulas to generate all the pythagorean triplets
  // under a maximum size. Once we find the primitive forms, we also check all
  // of the multiples and compute their side lengths. We then store the number
  // of triangles with that side length in a Hash Table. Once we are done, we
  // loop through all the triangle side lengths, and see which ones have only
  // one triangle associated with that side length. We then add one to the total
  // number of side lengths with exactly one integer sided right angle triangle,
  // and print that count.
  //
  // To generate all the primitives, we use the formula:
  //
  // a = m² - n², b = 2mn, c = m² + n²
  //
  // with n < m, (m - n) odd, and gcd(m,n) = 1.
  //
  // For more information about the Pythagorean Triples, visit:
  //
  // http://en.wikipedia.org/wiki/Pythagorean_triple#Generating_a_triple
  
  // Variable to hold the smallest side of the current right angled triangle.
  uint a = 0;
  
  // Variable to hold the middle side of the current right angled triangle.
  uint b = 0;
  
  // Variable to hold the hypotenuse of the current right angled triangle.
  uint c = 0;
  
  // Variable to hold the maximum side length any right angled triangle can have.
  uint maxSize = 1500000;
  
  // Variable to hold m² to make our computations easier.
  uint mSquared = 0;
  
  // Variable to hold n² to make our computations easier.
  uint nSquared = 0;
  
  // Variable to hold the side length of the primitive right angled triangle.
  uint sideLength = 0;
  
  // Variable to hold the maximum side length of any side of all the right
  // angled triangle.
  uint maxSideLength = ((uint)sqrt((double)maxSize));
  
  // Variable to hold the current side length of all the multiples of the current
  // right angled triangle.
  uint currentSideLength = 0;
  
  // Variable to hold the maximum multiple a triangle can have. Since the (3,4,5)
  // triangle is the smallest right angled triangle with integer side lengths,
  // we use it to compute the maximum number of mul
  uint maximumSideLengthMultiple = ((uint)(maxSize / (3 + 4 + 5)));
  
  // Variable to hold the number of side lengths with exactly one integer sided
  // right angle triangle.
  uint sideLengthWithOneTriangle = 0;
  
  // Variable to hold the number of right angled triangles with the current side
  // length.
  NSNumber * sideLengthCount = nil;
  
  // Variable to hold the current side length of the right angled triangle as a
  // string to store in our Hash Table.
  NSString * sideLengthString = nil;
  
  // Array to hold all the prime numbers less than the maximum side length.
  NSMutableArray * primeNumbersArray = [self arrayOfPrimeNumbersLessThan:maxSideLength];
  
  // Variable dictionary to hold the number of the triangles with various side lengths.
  NSMutableDictionary * triangleSideLengthCounts = [[NSMutableDictionary alloc] init];
  
  // For all the n from 1 to the maximum side length,
  for(int n = 1; n < maxSideLength; n++){
    // Compute n².
    nSquared = n * n;
    
    // For all the m from (n + 1) up to the max side length, adding 2 for the
    // interval, as (m - n) must be odd,
    for(int m = (n + 1); m < maxSideLength; m += 2){
      // If m and n are coprime,
      if([self gcdOfA:m b:n primeNumbersArray:primeNumbersArray] == 1){
        // Compute m².
        mSquared = m * m;
        
        // Compute the side length a of the right angled triangle.
        a = (mSquared - nSquared);
        
        // Compute the side length b of the right angled triangle.
        b = (2 * m * n);
        
        // Compute the side length c of the right angled triangle.
        c = (mSquared + nSquared);
        
        // Compute the total side length L of the right angled triangle.
        sideLength = a + b + c;
        
        // Reset the current side length to 0.
        currentSideLength = 0;
        
        // For all the potential multiples of the current right triangle,
        for(int k = 1; k < maximumSideLengthMultiple; k++){
          // Increment the current side length by the primitive triangles side
          // length.
          currentSideLength += sideLength;
          
          // If the current side length is greater than the maximum side length
          // a triangle can have,
          if(currentSideLength > maxSize){
            // Break out of the loop.
            break;
          }
          // If the current side length is less than the maximum side length a
          // triangle can have,
          else{
            // Grab the side length as a string.
            sideLengthString = [NSString stringWithFormat:@"%d", currentSideLength];
            
            // Grab the current number of triangles with this side length.
            sideLengthCount = [triangleSideLengthCounts objectForKey:sideLengthString];
            
            // Increment the number of triangles with this side length by 1.
            sideLengthCount = [NSNumber numberWithInt:([sideLengthCount intValue] + 1)];
            
            // Store the number of triangles with this side length in the Hash
            // Table.
            [triangleSideLengthCounts setObject:sideLengthCount forKey:sideLengthString];
          }
          // If we are no longer computing,
          if(!_isComputing){
            // Break out of the loop.
            break;
          }
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
    // For all the trangle side lengths found,
    for(NSNumber * number in [triangleSideLengthCounts allValues]){
      // If the number of triangles with the current side length is 1,
      if([number intValue] == 1){
        // Increment the number of triangles with unique side length by 1.
        sideLengthWithOneTriangle++;
      }
    }
    // Set the answer string to the number of side lengths with exactly one
    // integer sided right angle triangle.
    self.answer = [NSString stringWithFormat:@"%d", sideLengthWithOneTriangle];
    
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