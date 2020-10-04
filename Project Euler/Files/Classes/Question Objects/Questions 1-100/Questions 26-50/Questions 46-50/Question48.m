//  Question48.m

#import "Question48.h"
#import "BigInt.h"

@implementation Question48

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"18 July 2003";
  self.hint = @"Use Modular Exponentiation.";
  self.link = @"http://en.wikipedia.org/wiki/Modular_exponentiation";
  self.text = @"The series, 1^1 + 2^2 + 3^3 + ... + 10^10 = 10405071317.\n\nFind the last ten digits of the series, 1^1 + 2^2 + 3^3 + ... + 1000^1000.";
  self.isFun = NO;
  self.title = @"Self powers";
  self.answer = @"9110846700";
  self.number = @"48";
  self.rating = @"4";
  self.category = @"Patterns";
  self.keywords = @"sum,powers,series,ten,10,last,digits,self,modular,exponentiation,bigint,radix,find,modulo,1000";
  self.solveTime = @"30";
  self.technique = @"Math";
  self.difficulty = @"Easy";
  self.commentCount = @"22";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.startedOnDate = @"17/02/13";
  self.solvableByHand = NO;
  self.completedOnDate = @"17/02/13";
  self.solutionLineCount = @"15";
  self.usesCustomObjects = YES;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = YES;
  self.requiresMathematics = YES;
  self.hasMultipleSolutions = NO;
  self.estimatedComputationTime = @"0.191";
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"0.191";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply use the modular exponentiation method described here:
  //
  // http://en.wikipedia.org/wiki/Modular_exponentiation
  //
  // It turns out that our BigInt class already implements this feature, so we
  // simply use it to compute our answer.
  
  // Variable to hold the sum of the modular exponentiated powers.
  BigInt * sum = [BigInt createFromInt:0];
  
  // Variable to hold the modulo we are interested in.
  BigInt * mod = [BigInt createFromString:@"10000000000" andRadix:10];
  
  // Variable to hold the temporary sum of the current sum and the next modular
  // exponentiated power.
  BigInt * temporarySum = nil;
  
  // Variable to hold the current base in out sequence.
  BigInt * currentBase = nil;
  
  // Variable to hold the current power in our sequence.
  BigInt * currentPower = nil;
  
  // Variable to hold the current modular expontentiated number in our sequence.
  BigInt * currentModPower = nil;
  
  // For all the numbers from 1 to 1000,
  for(int number = 1; number <= 1000; number++){
    // Set the current base.
    currentBase = [BigInt createFromInt:number];
    
    // Set the current power.
    currentPower = [BigInt createFromInt:number];
    
    // Compute the exponentiated power based on the modulo.
    currentModPower = [currentBase modPow:currentPower withMod:mod];
    
    // Add the previous sum and the current modular exponentiated number together.
    temporarySum = [sum add:currentModPower];
    
    // Set the sum to the above addition.
    sum = temporarySum;
  }
  // Mod the sum by the modulo to get the last 10 digits.
  temporarySum = [sum mod:mod];
  
  // Set the sum to the above modulo.
  sum = temporarySum;
  
  // Set the answer string to the sum's last 10 digits.
  self.answer = [NSString stringWithFormat:@"%@", [sum toStringWithRadix:10]];
  
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
  
  // Here, we simply use the modular exponentiation method described here:
  //
  // http://en.wikipedia.org/wiki/Modular_exponentiation
  //
  // It turns out that our BigInt class already implements this feature, so we
  // simply use it to compute our answer.
  
  // Variable to hold the sum of the modular exponentiated powers.
  BigInt * sum = [BigInt createFromInt:0];
  
  // Variable to hold the modulo we are interested in.
  BigInt * mod = [BigInt createFromString:@"10000000000" andRadix:10];
  
  // Variable to hold the temporary sum of the current sum and the next modular
  // exponentiated power.
  BigInt * temporarySum = nil;
  
  // Variable to hold the current base in out sequence.
  BigInt * currentBase = nil;
  
  // Variable to hold the current power in our sequence.
  BigInt * currentPower = nil;
  
  // Variable to hold the current modular expontentiated number in our sequence.
  BigInt * currentModPower = nil;
  
  // For all the numbers from 1 to 1000,
  for(int number = 1; number <= 1000; number++){
    // Set the current base.
    currentBase = [BigInt createFromInt:number];
    
    // Set the current power.
    currentPower = [BigInt createFromInt:number];
    
    // Compute the exponentiated power based on the modulo.
    currentModPower = [currentBase modPow:currentPower withMod:mod];
    
    // Add the previous sum and the current modular exponentiated number together.
    temporarySum = [sum add:currentModPower];
    
    // Set the sum to the above addition.
    sum = temporarySum;
  }
  // Mod the sum by the modulo to get the last 10 digits.
  temporarySum = [sum mod:mod];
  
  // Set the sum to the above modulo.
  sum = temporarySum;
  
  // Set the answer string to the sum's last 10 digits.
  self.answer = [NSString stringWithFormat:@"%@", [sum toStringWithRadix:10]];
  
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