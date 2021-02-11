//  Question65.m

#import "Question65.h"
#import "BigInt.h"

@implementation Question65

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"12 March 2004";
  self.hint = @"Find the sequence of numerators and denominators by induction.";
  self.link = @"http://mathworld.wolfram.com/RecursiveSequence.html";
  self.text = @"The square root of 2 can be written as an infinite continued fraction.\n\n(Please visit the website, as UITextView's cannot render any of the required font!)\n\nThe infinite continued fraction can be written, 2 = [1;(2)], (2) indicates that 2 repeats ad infinitum. In a similar way, 23 = [4;(1,3,1,8)].\n\nIt turns out that the sequence of partial values of continued fractions for square roots provide the best rational approximations. Let us consider the convergents for 2.\n\n(Please visit site, as UITextView's cannot render any of the required font!)\n\nHence the sequence of the first ten convergents for 2 are:\n\n1, 3/2, 7/5, 17/12, 41/29, 99/70, 239/169, 577/408, 1393/985, 3363/2378, ...\n\nWhat is most surprising is that the important mathematical constant,\n\ne = [2; 1,2,1, 1,4,1, 1,6,1 , ... , 1,2k,1, ...].\n\nThe first ten terms in the sequence of convergents for e are:\n\n2, 3, 8/3, 11/4, 19/7, 87/32, 106/39, 193/71, 1264/465, 1457/536, ...\n\nThe sum of digits in the numerator of the 10th convergent is 1+4+5+7=17.\n\nFind the sum of digits in the numerator of the 100th convergent of the continued fraction for e.";
  self.isFun = NO;
  self.title = @"Convergents of e";
  self.answer = @"272";
  self.number = @"65";
  self.rating = @"3";
  self.category = @"Patterns";
  self.keywords = @"convergents,e,infinite,continued,fractions,digits,sum,numerator,100,one,hundred,rational,approximations,sequence,partial";
  self.solveTime = @"30";
  self.technique = @"Recursion";
  self.difficulty = @"Medium";
  self.commentCount = @"23";
  self.attemptsCount = @"1";
  self.isChallenging = YES;
  self.startedOnDate = @"06/03/13";
  self.solvableByHand = YES;
  self.completedOnDate = @"06/03/13";
  self.solutionLineCount = @"15";
  self.usesCustomObjects = YES;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = YES;
  self.learnedSomethingNew = YES;
  self.requiresMathematics = YES;
  self.hasMultipleSolutions = NO;
  self.estimatedComputationTime = @"1.27e-03";
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"1.27e-03";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we note that the relationship is even easier than the one in Question
  // 57. Since the representation is of the form [...,1,2k,1,...], we have:
  //
  // If i = 0 mod 3,
  //
  // n_{i+2} = 2k * n_{i+1} + n_{i}
  // d_{i+2} = 2k * d_{i+1} + d_{i}
  //
  // If i = 1 mod 3,
  //
  // n_{i+2} = n_{i+1} + 2k * n_{i}
  // d_{i+2} = d_{i+1} + 2k * d_{i}
  //
  // If i = 2 mod 3,
  //
  // n_{i+2} = n_{i+1} + n_{i}
  // d_{i+2} = d_{i+1} + d_{i}
  //
  // Therefore, we just need to follow the above equations in order to figure
  // out the numerator on the given iteration. We don't even have to compute the
  // denominator, as it is not needed!
  
  // Variable to hold how many iterations we need.
  uint numberOfIterations = 100;
  
  // Variable to hold the current index value in the representation.
  BigInt * k = [BigInt createFromInt:2];
  
  // Temporary variable to hold the result of a multiplication.
  BigInt * temporaryBigInt = nil;
  
  // Variable to hold the current n_{i} while iterating.
  BigInt * numerator_i = [BigInt createFromInt:2];
  
  // Variable to hold the current n_{i+1} while iterating.
  BigInt * numerator_i_Plus_1 = [BigInt createFromInt:3];
  
  // Variable to hold the current n_{i+2} while iterating.
  BigInt * numerator_i_Plus_2 = nil;
  
  // For all the iterations required (start at 2, as we already did the first
  // two by default),
  for(int index = 3; index <= numberOfIterations; index++){
    // If the index is divisible by 3,
    if((index % 3) == 0){
      // Compute 2k * n_{i+1}.
      temporaryBigInt = [numerator_i_Plus_1 multiply:k];
      
      // Compute the current n_{i+2}.
      numerator_i_Plus_2 = [temporaryBigInt add:numerator_i];
      
      // Compute k += 2.
      temporaryBigInt = [k add:[BigInt createFromInt:2]];
      
      // Store the value of the above computation in k.
      k = temporaryBigInt;
    }
    else{
      // Compute the current n_{i+2}.
      numerator_i_Plus_2 = [numerator_i_Plus_1 add:numerator_i];
    }
    // Set n_{i} = n_{i+1}.
    numerator_i = numerator_i_Plus_1;
    
    // Set n_{i+1} = n_{i+2}.
    numerator_i_Plus_1 = numerator_i_Plus_2;
  }
  // Set the answer string to the sum of the digits of the final numerator.
  self.answer = [NSString stringWithFormat:@"%d", [self digitSumOfNumber:[numerator_i_Plus_2 toStringWithRadix:10]]];
  
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
  
  // Note: This is the same algorithm as the optimal one. I can't think of a more
  //       brute force way to do this!
  
  // Here, we note that the relationship is even easier than the one in Question
  // 57. Since the representation is of the form [...,1,2k,1,...], we have:
  //
  // If i = 0 mod 3,
  //
  // n_{i+2} = 2k * n_{i+1} + n_{i}
  // d_{i+2} = 2k * d_{i+1} + d_{i}
  //
  // If i = 1 mod 3,
  //
  // n_{i+2} = n_{i+1} + 2k * n_{i}
  // d_{i+2} = d_{i+1} + 2k * d_{i}
  //
  // If i = 2 mod 3,
  //
  // n_{i+2} = n_{i+1} + n_{i}
  // d_{i+2} = d_{i+1} + d_{i}
  //
  // Therefore, we just need to follow the above equations in order to figure
  // out the numerator on the given iteration. We don't even have to compute the
  // denominator, as it is not needed!
  
  // Variable to hold how many iterations we need.
  uint numberOfIterations = 100;
  
  // Variable to hold the current index value in the representation.
  BigInt * k = [BigInt createFromInt:2];
  
  // Temporary variable to hold the result of a multiplication.
  BigInt * temporaryBigInt = nil;
  
  // Variable to hold the current n_{i} while iterating.
  BigInt * numerator_i = [BigInt createFromInt:2];
  
  // Variable to hold the current n_{i+1} while iterating.
  BigInt * numerator_i_Plus_1 = [BigInt createFromInt:3];
  
  // Variable to hold the current n_{i+2} while iterating.
  BigInt * numerator_i_Plus_2 = nil;
  
  // For all the iterations required (start at 2, as we already did the first
  // two by default),
  for(int index = 3; index <= numberOfIterations; index++){
    // If the index is divisible by 3,
    if((index % 3) == 0){
      // Compute 2k * n_{i+1}.
      temporaryBigInt = [numerator_i_Plus_1 multiply:k];
      
      // Compute the current n_{i+2}.
      numerator_i_Plus_2 = [temporaryBigInt add:numerator_i];
      
      // Compute k += 2.
      temporaryBigInt = [k add:[BigInt createFromInt:2]];
      
      // Store the value of the above computation in k.
      k = temporaryBigInt;
    }
    else{
      // Compute the current n_{i+2}.
      numerator_i_Plus_2 = [numerator_i_Plus_1 add:numerator_i];
    }
    // Set n_{i} = n_{i+1}.
    numerator_i = numerator_i_Plus_1;
    
    // Set n_{i+1} = n_{i+2}.
    numerator_i_Plus_1 = numerator_i_Plus_2;
  }
  // Set the answer string to the sum of the digits of the final numerator.
  self.answer = [NSString stringWithFormat:@"%d", [self digitSumOfNumber:[numerator_i_Plus_2 toStringWithRadix:10]]];
  
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