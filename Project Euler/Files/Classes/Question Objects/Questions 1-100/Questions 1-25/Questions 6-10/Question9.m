//  Question9.m

#import "Question9.h"

@implementation Question9

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"25 January 2002";
  self.text = @"A Pythagorean triplet is a set of three natural numbers, a  b  c, for which,\n\n                         a² + b² = c²\n\nFor example, 3² + 4² = 9 + 16 = 25 = 5².\n\nThere exists exactly one Pythagorean triplet for which a + b + c = 1000.\n\nFind the product abc.";
  self.title = @"Special Pythagorean triplet";
  self.answer = @"31875000";
  self.number = @"Problem 9";
  self.estimatedComputationTime = @"";
  self.estimatedBruteForceComputationTime = @"1.29e-04";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // We have the following system of equations for integers a, b, and c:
  //
  // (1) a² + b² = c²
  // (2) a + b + c = 1000 = 2³ * 5³
  //
  // Doing a bit of math, we arrive at the following identity:
  //
  // (2) => a + b = 1000 - c
  //     => (a + b)² = (1000 - c)²
  //     => a² + 2ab + b² = 1000² - 2000c + c²
  // (1) => 2ab + c² = 1000² - 2000c + c²
  // (3) => ab = 1000(500 - c) = (2³ * 5³) * (2² * 5³ - c)
  //
  // We should also note a couple of properties of pythagorean triples:
  //
  // - Either one of a, b, or c even or they all are.
  // - Exactly one of a or b is divisible by 3.
  // - Exactly one of a or b is divisible by 4.
  // - Exactly one of a, b or c is divisible by 5.
  //
  // Using these facts, and combining them with (3), we can eliminate some options.
  //
  // One can note that if 2 | b, , then 2 | c. Factoring out the extra factor of
  // 2 from equations (1) and (2), we arrive at:
  //
  // (3 *) a'b' = 500(250 - c') = (2² * 5³) * (2 * 5³ - c')
  //
  // Repeating the process of removing the common factors of 2, we arrive at:
  //
  // (3 **) a''b'' = (2 * 5³) * (5³ - c'')
  //
  // If 5 | c, then 5 | a and b. Factoring out a common factor of 5, we get:
  //
  // (3 ***) a'''b''' = (2 * 5²) * (5² - c''')
  //
  // Therefore, c''' < 5² = 25, but (2 * 5²) | a'''b'''. 5 divides only a or b,
  // as otherwise, 5 | c. Therefore, c''' < 5² = 25 = b'''. Contradiction.
  //
  // Therefore, the common factor is NOT even.
  //
  // By (3) and the above, 2³ | a, W.L.O.G., 2³ | a (we can do this, because we
  // can just swap a with b at the end so that a < b < c). Let a' = a / 8. Then
  // we have:
  //
  // (3') => a'b = 5³ * (2² * 5³ - c)
  //
  // Suppose 5 | c. Therefore, 5 | a and b. Then we have:
  //
  // (3'*) => a''b' = 25(100 - c') = 5² * (2² * 5² - c')
  //
  // with a'' = a / (2³ * 5), b' = b / 5, c' = c / 5.
  //
  // Suppose 5 | c'. Therefore, 5 | a'' and b'. Then we have:
  //
  // (3'**) => a'''b'' = 5(20 - c'') = 5 * (2² * 5 - c'')
  //
  // with a''' = a / (2³ * 5²), b'' = b / 5², c'' = c / 5².
  //
  // If 5 | b, we have:
  //
  // (3'***) => a'''b''' = (2² * 5 - c'')
  //
  // with b''' = b / 125.
  //
  // Therefore, c'' < 20. Since 3 | a or b, 3 | a'''b''' = 20 - c''.
  //
  // c'' is NOT divisible by 2 or 3 or 5, so c'' could be 11 or 17. 11 would
  // mean that 9 | a'''b''', and since 3 only divide one of the number a, b, or c,
  // a'' = 8, b'' = 45, and c'' = 11. But a < b < c. Contradiction. So therefore,
  // c'' = 17 => a'' = 8, b'' = 15. This is a pythagorean triple.
  //
  // We then arrive at the pythagorean triple (200, 375, 425), which has a base
  // pythagorean triple of (8, 15, 17), with a common factor of 25.
  
  // Variable to hold the product of abc that solves the 2 equations.
  uint productABC = 0;
  
  // Variable to hold the first number in the pythagorean triple.
  uint a = 8;
  
  // Variable to hold the first number in the pythagorean triple.
  uint b = 15;
  
  // Variable to hold the first number in the pythagorean triple.
  uint c = 17;
  
  // Variable to hold the common factor of a, b, and c.
  uint commonFactor = 25;
  
  // Compute the product. Since there are 3 numbers (a, b, and c), the
  // common factor shows up 3 times in the prodcut of the 3 numbers.
  productABC = (a * commonFactor) * (b * commonFactor) * (c * commonFactor);
  
  // Set the answer string to the product of a, b, and c.
  self.answer = [NSString stringWithFormat:@"%d", productABC];
  
  // Get the amount of time that has passed while the computation was happening.
  NSTimeInterval computationTile = [[NSDate date] timeIntervalSinceDate:startTime];
  
  // Set the estimated computation time to the calculated value. We use scientific
  // notation here, as the run time should be very short.
  self.estimatedComputationTime = [NSString stringWithFormat:@"%.03g", computationTile];
  
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
  
  // We have the following system of equations for integers a, b, and c:
  //
  // (1) a² + b² = c²
  // (2) a + b + c = 1000
  //
  // Since a + b + c = 1000, c < 500, as a, b, and c are integers. So, we simply
  // Need to search all the pairs of numbers (a,b) to find the pythagorean triplit.
  //
  // Also, a, b, and c may not be relatively prime, so it we find a pythagorean
  // triple, we only need to check if the resulting sum (a + b + c) | 1000, as
  // if it does, we have found the final values. As an example:
  //
  // 3² + 4² = 5², with 3, 4, and 5 relatively prime, (3 + 4 + 5) = 12.
  //
  // 6² + 8² = 10², but 2 | 6, 8, and 10, (6 + 8 + 10) = 24.
  
  // Variable to hold the sum of the three numbers in the pythagorean triple.
  uint sum = 1000;
  
  // Variable to hold the product of abc that solves the 2 equations.
  uint productABC = 0;
  
  // Variable to hold the max size of any number in the pythagorean triple.
  uint maxSizeOfTripleNumber = (uint)(sum / 2);
  
  // Variable to hold the largest number in the pythagorean triple.
  uint c = 0;
  
  // Variable to hold the common factor of a, b, and c.
  uint commonFactor = 0;
  
  // For all values 1 to the max size a the first triple number a,
  for(uint a = 1; a < maxSizeOfTripleNumber; a++){
    
    // If the product of a, b, and c has NOT been found,
    if(productABC == 0){
      
      // For all values 1 to the max size a the second triple number b,
      for(uint b = 1; b < maxSizeOfTripleNumber; b++){
        // Compute c² and store it in c.
        c = ((a * a) + (b * b));
        
        // If the c is a perfect square,
        if([self isNumberAPerfectSquare:c]){
          c = (uint)(sqrt((double)c));
          
          if((sum % (a + b + c)) == 0){
            // Compute the common factor.
            commonFactor = sum / (a + b + c);
            
            // Compute the product. Since there are 3 numbers (a, b, and c), the
            // common factor shows up 3 times in the prodcut of the 3 numbers.
            productABC = (a * commonFactor) * (b * commonFactor) * (c * commonFactor);
            
            // Exit the loop.
            break;
          }
        }
      }
    }
    else{
      // We have found the product, so exit the loop.
      break;
    }
  }
  // Set the answer string to the product of a, b, and c.
  self.answer = [NSString stringWithFormat:@"%d", productABC];
  
  // Get the amount of time that has passed while the computation was happening.
  NSTimeInterval computationTile = [[NSDate date] timeIntervalSinceDate:startTime];
  
  // Set the estimated brute force computation time to the calculated value. We
  // use scientific notation here, as the run time should be very short.
  self.estimatedBruteForceComputationTime = [NSString stringWithFormat:@"%.03g", computationTile];
  
  // Tell the delegate we have finished the computation.
  [self.delegate finishedComputing];
  
  // Set that we have finished the computation.
  _isComputing = NO;
}

@end