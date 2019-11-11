//  Question68.m

#import "Question68.h"

@implementation Question68

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"23 April 2004";
  self.hint = @"You don't need a computer for this one!";
  self.link = @"https://en.wikipedia.org/wiki/Logic";
  self.text = @"Consider the following \"magic\" 3-gon ring, filled with the numbers 1 to 6, and each line adding to nine.\n\nWorking clockwise, and starting from the group of three with the numerically lowest external node (4,3,2 in this example), each solution can be described uniquely. For example, the above solution can be described by the set: 4,3,2; 6,2,1; 5,1,3.\n\nIt is possible to complete the ring with four different totals: 9, 10, 11, and 12. There are eight solutions in total.\n\nTotal	Solution Set\n9	4,2,3; 5,3,1; 6,1,2\n9	4,3,2; 6,2,1; 5,1,3\n10	2,3,5; 4,5,1; 6,1,3\n10	2,5,3; 6,3,1; 4,1,5\n11	1,4,6; 3,6,2; 5,2,4\n11	1,6,4; 5,4,2; 3,2,6\n12	1,5,6; 2,6,4; 3,4,5\n12	1,6,5; 3,5,4; 2,4,6\nBy concatenating each group it is possible to form 9-digit strings; the maximum string for a 3-gon ring is 432621513.\n\nUsing the numbers 1 to 10, and depending on arrangements, it is possible to form 16- and 17-digit strings. What is the maximum 16-digit string for a \"magic\" 5-gon ring?";
  self.isFun = YES;
  self.title = @"Magic 5-gon ring";
  self.answer = @"6531031914842725";
  self.number = @"68";
  self.rating = @"5";
  self.category = @"Patterns";
  self.keywords = @"n-gon,digit,maximum,magic,ring,external,node,adding,line,16,sixteen,5-gon,five-gon,arrangements,strings";
  self.solveTime = @"600";
  self.technique = @"Logic";
  self.difficulty = @"Medium";
  self.commentCount = @"8";
  self.attemptsCount = @"3";
  self.isChallenging = YES;
  self.startedOnDate = @"09/03/13";
  self.completedOnDate = @"09/03/13";
  self.solutionLineCount = @"1";
  self.usesHelperMethods = NO;
  self.requiresMathematics = NO;
  self.hasMultipleSolutions = NO;
  self.estimatedComputationTime = @"2.97e-06";
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"2.97e-06";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply use some logic. This is the first question the computer is
  // not needed!
  //
  // We note these 3 facts:
  //
  // 1) The lowest outer number is the starting digit.
  // 2) The numbers are appended in a clockwise order.
  // 3) The inner numbers are counted twice, and the outer numbers are counted
  //    once.
  //
  // Since the number we are looking for is a 16 digit number, 10 must be an
  // outer number.
  //
  // Since we want to have the maximum 16 digit number, the digits 6, 7, 8, 9
  // and 10 must be outer numbers.
  //
  // Since we want the maximum number, 5 should adjacent to the 6 in the inner
  // numbers.
  //
  // The possible values the groups can have is bounded between 9 (6, 2, 1), and
  // 19 (10, 5, 4), so the values we are looking for is most likely 14.
  //
  // To see that the value must be 14, note that the inner numbers are counted
  // twice in the total sum of all the groups, but the outer numbers are only
  // counted once. Therefore, the sum is:
  //
  // 2 * (1 + 2 + 3 + 4 + 5) + (6 + 7 + 8 + 9 + 10) = 2 * (15) + (40) = 70
  //
  // Therefore, each group must containt 70 / 5 = 14.
  //
  // If we look at the state of the diagram, we have:
  //
  //    6
  //     \
  //      5     10
  //    /   \ /
  //   *     *
  //  / \   /
  // 7   *-*  - 9
  //      \
  //       8
  //
  // The group (6,5,*) can have 4 possible values. To be the largest however,
  // we want to try the values from highest to lowest.
  //
  // 4 cannot be the value, as if it was, the values would be:
  //
  //    6
  //     \
  //      5     10
  //    /   \ /
  //   3     4
  //  / \   /
  // 7   5-1  - 9
  //      \
  //       8
  //
  // in order to keep the sum condition, but clearly 5 has been repeated. So,
  // try 3 as the next value:
  //
  //    6
  //     \
  //      5     10
  //    /   \ /
  //   2     3
  //  / \   /
  // 7   4-1  - 9
  //      \
  //       8
  //
  // This configuration keeps the sum condition, all of the values are used,
  // and it yields the maximum start group (6,5,3).
  //
  // Therefore, the string is: 6531031914842725
  
  // Set the answer string to the concatenated number.
  self.answer = @"6531031914842725";
  
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
  
  // Here, we simply use some logic. This is the first question the computer is
  // not needed!
  //
  // We note these 3 facts:
  //
  // 1) The lowest outer number is the starting digit.
  // 2) The numbers are appended in a clockwise order.
  // 3) The inner numbers are counted twice, and the outer numbers are counted
  //    once.
  //
  // Since the number we are looking for is a 16 digit number, 10 must be an
  // outer number.
  //
  // Since we want to have the maximum 16 digit number, the digits 6, 7, 8, 9
  // and 10 must be outer numbers.
  //
  // Since we want the maximum number, 5 should adjacent to the 6 in the inner
  // numbers.
  //
  // The possible values the groups can have is bounded between 9 (6, 2, 1), and
  // 19 (10, 5, 4), so the values we are looking for is most likely 14.
  //
  // To see that the value must be 14, note that the inner numbers are counted
  // twice in the total sum of all the groups, but the outer numbers are only
  // counted once. Therefore, the sum is:
  //
  // 2 * (1 + 2 + 3 + 4 + 5) + (6 + 7 + 8 + 9 + 10) = 2 * (15) + (40) = 70
  //
  // Therefore, each group must containt 70 / 5 = 14.
  //
  // If we look at the state of the diagram, we have:
  //
  //    6
  //     \
  //      5     10
  //    /   \ /
  //   *     *
  //  / \   /
  // 7   *-*  - 9
  //      \
  //       8
  //
  // The group (6,5,*) can have 4 possible values. To be the largest however,
  // we want to try the values from highest to lowest.
  //
  // 4 cannot be the value, as if it was, the values would be:
  //
  //    6
  //     \
  //      5     10
  //    /   \ /
  //   3     4
  //  / \   /
  // 7   5-1  - 9
  //      \
  //       8
  //
  // in order to keep the sum condition, but clearly 5 has been repeated. So,
  // try 3 as the next value:
  //
  //    6
  //     \
  //      5     10
  //    /   \ /
  //   2     3
  //  / \   /
  // 7   4-1  - 9
  //      \
  //       8
  //
  // This configuration keeps the sum condition, all of the values are used,
  // and it yields the maximum start group (6,5,3).
  //
  // Therefore, the string is: 6531031914842725
  
  // Set the answer string to the concatenated number.
  self.answer = @"6531031914842725";
  
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