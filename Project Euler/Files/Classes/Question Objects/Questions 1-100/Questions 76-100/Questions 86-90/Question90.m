//  Question90.m

#import "Question90.h"

@interface Question90 (Private)

- (BOOL)allSquareNumbersFromDie1:(NSMutableArray *)aDie1 andDie2:(NSMutableArray *)aDie2;

@end

@implementation Question90

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"04 March 2005";
  self.hint = @"Check all the sets of dies and check which pairs can produce all the 2 digit square numbers.";
  self.link = @"https://en.wikipedia.org/wiki/Dice";
  self.text = @"Each of the six faces on a cube has a different digit (0 to 9) written on it; the same is done to a second cube. By placing the two cubes side-by-side in different positions we can form a variety of 2-digit numbers.\n\nFor example, the square number 64 could be formed:\n\nMissing Image!!!\n\nIn fact, by carefully choosing the digits on both cubes it is possible to display all of the square numbers below one-hundred: 01, 04, 09, 16, 25, 36, 49, 64, and 81.\n\nFor example, one way this can be achieved is by placing {0, 5, 6, 7, 8, 9} on one cube and {1, 2, 3, 4, 8, 9} on the other cube.\n\nHowever, for this problem we shall allow the 6 or 9 to be turned upside-down so that an arrangement like {0, 5, 6, 7, 8, 9} and {1, 2, 3, 4, 6, 7} allows for all nine square numbers to be displayed; otherwise it would be impossible to obtain 09.\n\nIn determining a distinct arrangement we are interested in the digits on each cube, not the order.\n\n{1, 2, 3, 4, 5, 6} is equivalent to {3, 6, 4, 1, 2, 5}\n{1, 2, 3, 4, 5, 6} is distinct from {1, 2, 3, 4, 5, 9}\n\nBut because we are allowing 6 and 9 to be reversed, the two distinct sets in the last example both represent the extended set {1, 2, 3, 4, 5, 6, 9} for the purpose of forming 2-digit numbers.\n\nHow many distinct arrangements of the two cubes allow for all of the square numbers to be displayed?";
  self.isFun = YES;
  self.title = @"Cube digit pairs";
  self.answer = @"1217";
  self.number = @"90";
  self.rating = @"4";
  self.summary = @"How many distinct pairs of cubes can display n^2 < 100?";
  self.category = @"Combinations";
  self.isUseful = NO;
  self.keywords = @"cube,digit,pairs,distinct,formations,arrangements,square,numbers,different,positions,side,6,six,2,two,displayed,forming";
  self.loadsFile = NO;
  self.memorable = YES;
  self.solveTime = @"300";
  self.technique = @"Recursion";
  self.difficulty = @"Easy";
  self.usesBigInt = NO;
  self.recommended = YES;
  self.commentCount = @"31";
  self.attemptsCount = @"1";
  self.isChallenging = NO;
  self.isContestMath = NO;
  self.startedOnDate = @"31/03/13";
  self.trickRequired = NO;
  self.usesRecursion = YES;
  self.educationLevel = @"Elementary";
  self.solvableByHand = YES;
  self.canBeSimplified = NO;
  self.completedOnDate = @"31/03/13";
  self.worthRevisiting = NO;
  self.solutionLineCount = @"31";
  self.usesCustomObjects = NO;
  self.usesCustomStructs = NO;
  self.usesHelperMethods = YES;
  self.learnedSomethingNew = NO;
  self.requiresMathematics = NO;
  self.hasMultipleSolutions = NO;
  self.estimatedComputationTime = @"0.173";
  self.relatedToAnotherQuestion = NO;
  self.shouldInvestigateFurther = NO;
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"0.173";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply compute the set of all possible die's, and use a helper
  // method to check which pairs of die's can produce all the two digit square
  // numbers. The first straight-forward question in awhile!
  
  // Variable to hold the total number of dice formations that produce all the
  // two digit squares.
  uint totalNumberOfDiceFormations = 0;
  
  // Variable to hold the first die.
  NSMutableArray * die1 = nil;
  
  // Variable to hold the second die.
  NSMutableArray * die2 = nil;
  
  // Variable to hold all the unique die's.
  NSMutableArray * allPossibleDice = [[NSMutableArray alloc] init];
  
  // We need to compute all the different potentail die's. Since there are 6
  // sides to a die, and the sides are in increasing order, the simplest thing
  // to do is make 6 nested for loops.
  
  // For all the lowest sides of the die, up to 4 (as there are 5 other sides),
  for(int side1 = 0; side1 < 5; side1++){
    // For all the second lowest sides of the die, up to 5 (as there are 4 other
    // sides),
    for(int side2 = (side1 + 1); side2 < 6; side2++){
      // For all the third lowest sides of the die, up to 6 (as there are 3
      // other sides),
      for(int side3 = (side2 + 1); side3 < 7; side3++){
        // For all the third highest sides of the die, up to 7 (as there are 2
        // other sides),
        for(int side4 = (side3 + 1); side4 < 9; side4++){
          // For all the second highest sides of the die, up to 8 (as there is 1
          // other side),
          for(int side5 = (side4 + 1); side5 < 9; side5++){
            // For all the highest sides, up to 9,
            for(int side6 = (side5 + 1); side6 < 10; side6++){
              // If the highest side is equal to 9,
              if(side6 == 9){
                // Replace the highest side by 6 and create the current die.
                die1 = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:side1], [NSNumber numberWithInt:side2], [NSNumber numberWithInt:side3], [NSNumber numberWithInt:side4], [NSNumber numberWithInt:side5], [NSNumber numberWithInt:6], nil];
              }
              // If the highest side is less than 9,
              else{
                // Create the current die.
                die1 = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:side1], [NSNumber numberWithInt:side2], [NSNumber numberWithInt:side3], [NSNumber numberWithInt:side4], [NSNumber numberWithInt:side5], [NSNumber numberWithInt:side6], nil];
              }
              // Add the current die to the set of all possible die's.
              [allPossibleDice addObject:die1];
            }
          }
        }
      }
    }
  }
  
  // Now, we look at all the pairs of dies that are different, and use a helper
  // method to see if the combination yields all the two digit squares.
  //
  // Note: There is no die that can produce all of the squares with itself, as
  //       in order to produce the squares, we need 0, 1, 2, 3, 4, 5, 6, and 8,
  //       which is more than the six sides of the die can give us.
  
  // For all the die's in the set of all possible dies,
  for(int die1Index = 0; die1Index < [allPossibleDice count]; die1Index++){
    // Grab the current die.
    die1 = [allPossibleDice objectAtIndex:die1Index];
    
    // For all the die's in the set of all possible dies after the first die,
    for(int die2Index = (die1Index + 1); die2Index < [allPossibleDice count]; die2Index++){
      // Grab the current next die.
      die2 = [allPossibleDice objectAtIndex:die2Index];
      
      // If the two die's can produce all the two digit square numbers,
      if([self allSquareNumbersFromDie1:die1 andDie2:die2]){
        // Increment the number of die's that can produce all the square numbers
        // by 1.
        totalNumberOfDiceFormations++;
      }
    }
  }
  // Set the answer string to the total number of dice formations that produce
  // all the two digit squares.
  self.answer = [NSString stringWithFormat:@"%d", totalNumberOfDiceFormations];
  
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
  
  // Here, we simply compute the set of all possible die's, and use a helper
  // method to check which pairs of die's can produce all the two digit square
  // numbers. The first straight-forward question in awhile!
  
  // Variable to hold the total number of dice formations that produce all the
  // two digit squares.
  uint totalNumberOfDiceFormations = 0;
  
  // Variable to hold the first die.
  NSMutableArray * die1 = nil;
  
  // Variable to hold the second die.
  NSMutableArray * die2 = nil;
  
  // Variable to hold all the unique die's.
  NSMutableArray * allPossibleDice = [[NSMutableArray alloc] init];
  
  // We need to compute all the different potentail die's. Since there are 6
  // sides to a die, and the sides are in increasing order, the simplest thing
  // to do is make 6 nested for loops.
  
  // For all the lowest sides of the die, up to 4 (as there are 5 other sides),
  for(int side1 = 0; side1 < 5; side1++){
    // For all the second lowest sides of the die, up to 5 (as there are 4 other
    // sides),
    for(int side2 = (side1 + 1); side2 < 6; side2++){
      // For all the third lowest sides of the die, up to 6 (as there are 3
      // other sides),
      for(int side3 = (side2 + 1); side3 < 7; side3++){
        // For all the third highest sides of the die, up to 7 (as there are 2
        // other sides),
        for(int side4 = (side3 + 1); side4 < 9; side4++){
          // For all the second highest sides of the die, up to 8 (as there is 1
          // other side),
          for(int side5 = (side4 + 1); side5 < 9; side5++){
            // For all the highest sides, up to 9,
            for(int side6 = (side5 + 1); side6 < 10; side6++){
              // If the highest side is equal to 9,
              if(side6 == 9){
                // Replace the highest side by 6 and create the current die.
                die1 = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:side1], [NSNumber numberWithInt:side2], [NSNumber numberWithInt:side3], [NSNumber numberWithInt:side4], [NSNumber numberWithInt:side5], [NSNumber numberWithInt:6], nil];
              }
              // If the highest side is less than 9,
              else{
                // Create the current die.
                die1 = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:side1], [NSNumber numberWithInt:side2], [NSNumber numberWithInt:side3], [NSNumber numberWithInt:side4], [NSNumber numberWithInt:side5], [NSNumber numberWithInt:side6], nil];
              }
              // Add the current die to the set of all possible die's.
              [allPossibleDice addObject:die1];
            }
          }
        }
      }
    }
  }
  
  // Now, we look at all the pairs of dies that are different, and use a helper
  // method to see if the combination yields all the two digit squares.
  //
  // Note: There is no die that can produce all of the squares with itself, as
  //       in order to produce the squares, we need 0, 1, 2, 3, 4, 5, 6, and 8,
  //       which is more than the six sides of the die can give us.
  
  // For all the die's in the set of all possible dies,
  for(int die1Index = 0; die1Index < [allPossibleDice count]; die1Index++){
    // Grab the current die.
    die1 = [allPossibleDice objectAtIndex:die1Index];
    
    // For all the die's in the set of all possible dies after the first die,
    for(int die2Index = (die1Index + 1); die2Index < [allPossibleDice count]; die2Index++){
      // Grab the current next die.
      die2 = [allPossibleDice objectAtIndex:die2Index];
      
      // If the two die's can produce all the two digit square numbers,
      if([self allSquareNumbersFromDie1:die1 andDie2:die2]){
        // Increment the number of die's that can produce all the square numbers
        // by 1.
        totalNumberOfDiceFormations++;
      }
    }
  }
  // Set the answer string to the total number of dice formations that produce
  // all the two digit squares.
  self.answer = [NSString stringWithFormat:@"%d", totalNumberOfDiceFormations];
  
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

#pragma mark - Private Methods

@implementation Question90 (Private)

- (BOOL)allSquareNumbersFromDie1:(NSMutableArray *)aDie1 andDie2:(NSMutableArray *)aDie2; {
  // Here, we simply loop through all the potential combinations that the dice
  // can have in order to produce all the two digit square numbers. We replace
  // the 9's with 6's as stated in the question text.
  //
  // Note: We do NOT need to check 64, as if the pair can create 49, they must
  //       also be able to create 64.
  
  // Variable to store if the two die can produce all the two digit square
  // numbers.
  BOOL allSquareNumbersAreFormed = YES;
  
  // Constant array to hold all the tens digits of the two digit square numbers.
  const uint tensDigits[8] = {0, 0, 0, 1, 2, 3, 4, 8};
  
  // Constant array to hold all the units digits of the two digit square numbers.
  const uint unitsDigits[8] = {1, 4, 6, 6, 5, 6, 6, 1};
  
  // For all the two digit square numbers,
  for(int index = 0; index < 8; index++){
    // If the first die and the second die can create the current two digit
    // sqaure number in any order,
    if(([aDie1 containsObject:[NSNumber numberWithInt:tensDigits[index]]] && [aDie2 containsObject:[NSNumber numberWithInt:unitsDigits[index]]]) ||
       ([aDie2 containsObject:[NSNumber numberWithInt:tensDigits[index]]] && [aDie1 containsObject:[NSNumber numberWithInt:unitsDigits[index]]])){
      // Continue checking the rest of the two digit sqaure numbers.
      continue;
    }
    // If the first die and the second die CANNOT create the current two digit
    // sqaure number in any order,
    else{
      // Mark that the inputted dice CANNOT create all the two digit square
      // numbers.
      allSquareNumbersAreFormed = NO;
      
      // Break out of the loop.
      break;
    }
  }
  // Return if the inputted dice can create all the two digit square numbers.
  return allSquareNumbersAreFormed;
}

@end