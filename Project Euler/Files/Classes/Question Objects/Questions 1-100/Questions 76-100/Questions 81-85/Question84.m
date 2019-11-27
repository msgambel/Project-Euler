//  Question84.m

#import "Question84.h"
#import "MonopolyProperty.h"

@implementation Question84

#pragma mark - Setup

- (void)initialize; {
  // Setup all the information needed for the Question and Answer. The Answer is
  // precomputed, however, the methods to compute the Answer are available and
  // described below. There is even the estimated computation time for both
  // the brute force method and the optimized way to solve the problem.
  
  self.date = @"03 December 2004";
  self.hint = @"Make Monopoly Board and Propery objects, and move around it lots of times!";
  self.link = @"http://en.wikipedia.org/wiki/Stochastic_matrix";
  self.text = @"In the game, Monopoly, the standard board is set up in the following way\n\nGO A1 CC1 A2 T1 R1 B1 CH1 B2 B3 J\nH2                                                      C1\nT2                                                      U1\nH1                                                      C2\nCH3                                                    C3\nR4                                                      R2\nG3                                                      D1\nCC3                                                  CC2\nG2                                                      D2\nG1                                                      D3\nG2J F3 U2 F2 F1 R3 E3 E2 CH2 E1 FP\n\nA player starts on the GO square and adds the scores on two 6-sided dice to determine the number of squares they advance in a clockwise direction. Without any further rules we would expect to visit each square with equal probability: 2.5%. However, landing on G2J (Go To Jail), CC (community chest), and CH (chance) changes this distribution.\n\nIn addition to G2J, and one card from each of CC and CH, that orders the player to go directly to jail, if a player rolls three consecutive doubles, they do not advance the result of their 3rd roll. Instead they proceed directly to jail.\n\nAt the beginning of the game, the CC and CH cards are shuffled. When a player lands on CC or CH they take a card from the top of the respective pile and, after following the instructions, it is returned to the bottom of the pile. There are sixteen cards in each pile, but for the purpose of this problem we are only concerned with cards that order a movement; any instruction not concerned with movement will be ignored and the player will remain on the CC/CH square.\n\nCommunity Chest (2/16 cards):\nAdvance to GO\nGo to JAIL\nChance (10/16 cards):\nAdvance to GO\nGo to JAIL\nGo to C1\nGo to E3\nGo to H2\nGo to R1\nGo to next R (railway company)\nGo to next R\nGo to next U (utility company)\nGo back 3 squares.\n\nThe heart of this problem concerns the likelihood of visiting a particular square. That is, the probability of finishing at that square after a roll. For this reason it should be clear that, with the exception of G2J for which the probability of finishing on it is zero, the CH squares will have the lowest probabilities, as 5/8 request a movement to another square, and it is the final square that the player finishes at on each roll that we are interested in. We shall make no distinction between \"Just Visiting\" and being sent to JAIL, and we shall also ignore the rule about requiring a double to \"get out of jail\", assuming that they pay to get out on their next turn.\n\nBy starting at GO and numbering the squares sequentially from 00 to 39 we can concatenate these two-digit numbers to produce strings that correspond with sets of squares.\n\nStatistically it can be shown that the three most popular squares, in order, are JAIL (6.24%) = Square 10, E3 (3.18%) = Square 24, and GO (3.09%) = Square 00. So these three most popular squares can be listed with the six-digit modal string: 102400.\n\nIf, instead of using two 6-sided dice, two 4-sided dice are used, find the six-digit modal string.";
  self.isFun = YES;
  self.title = @"Monopoly odds";
  self.answer = @"101524";
  self.number = @"84";
  self.rating = @"5";
  self.category = @"Probability";
  self.keywords = @"monopoly,4,four,dice,roll,ev,2,two,6,six,most,popular,squares,modal,string,standard,board,sided,listed";
  self.solveTime = @"300";
  self.technique = @"OOP";
  self.difficulty = @"Easy";
  self.commentCount = @"60";
  self.attemptsCount = @"1";
  self.isChallenging = YES;
  self.startedOnDate = @"25/03/13";
  self.completedOnDate = @"25/03/13";
  self.solutionLineCount = @"55";
  self.usesHelperMethods = YES;
  self.requiresMathematics = NO;
  self.hasMultipleSolutions = NO;
  self.estimatedComputationTime = @"0.397";
  self.usesFunctionalProgramming = NO;
  self.estimatedBruteForceComputationTime = @"0.397";
}

#pragma mark - Methods

- (void)computeAnswer; {
  // Set that we have started the computation.
  _isComputing = YES;
  
  // Grab the time before the computation starts.
  NSDate * startTime = [NSDate date];
  
  // Here, we simply build a Monopoly board, and use a Monopoly Property object
  // to handle if we have to move or not, as well as record the number of times
  // it has been landed on. Then, we simulate rolling two four sided die, and
  // move throughout the board 1,000,000 times. Finally, we order the properties
  // based on the number of times it has been landed on, and concatenate the top
  // three properties.
  //
  // While we could use a Stochastic Matrix to get exact answers, it is simpler
  // to just brute force it. If you'd like to learn more about Stochastic
  // Matrices, visit:
  //
  // http://en.wikipedia.org/wiki/Stochastic_matrix
  
  // Variable to hold the roll of the first die.
  uint diceRoll1 = 0;
  
  // Variable to hold the roll of the second die.
  uint diceRoll2 = 0;
  
  // Variable to hold the number of rolls to be completed. We chose 1,000,000,
  // but we could probably get away with a lower number.
  uint maximumRolls = 1000000;
  
  // Variable to hold the current position of the piece on the board.
  uint currentPosition = 0;
  
  // Variable to hold the number of faces the dice have.
  uint numberOfDieFaces = 4;
  
  // Variable to hold the number of times consecutive doubles are rolled.
  uint consecutiveDoubleRolled = 0;
  
  // Variable to hold the number of times consecutive doubles required to be
  // rolled to go to JAIL.
  uint consecutiveDoubleRolledUntilJail = 3;
  
  // Variable to hold the name of the property that was landed on.
  NSString * propertyLandedOn = nil;
  
  // Variable to hold the three most popular properties concatenated together.
  NSString * threeMostPopularProperties = @"";
  
  // Variable to hold the current property the piece has landed on.
  MonopolyProperty * currentProperty = nil;
  
  // Array to hold the names of all the properties in order on the board.
  NSArray * propertyNames = [NSArray arrayWithObjects:@"GO", @"A1", @"CC1", @"A2", @"T1", @"R1", @"B1", @"CH1", @"B2", @"B3", @"JAIL", @"C1", @"U1", @"C2", @"C3", @"R2", @"D1", @"CC2", @"D2", @"D3", @"FP", @"E1", @"CH2", @"E2", @"E3", @"R3", @"F1", @"F2", @"U2", @"F3", @"G2J", @"G1", @"G2", @"CC3", @"G3", @"R4", @"CH3", @"H1", @"T2", @"H2", nil];
  
  // Variable array to hold all the Monopoly properties in order on the board.
  NSMutableArray * properties = [[NSMutableArray alloc] initWithCapacity:[propertyNames count]];
  
  // For all the property names on the board,
  for(NSString * name in propertyNames){
    // Create a Monopoly property with that name and add it to the properties
    // array.
    [properties addObject:[[MonopolyProperty alloc] initWithName:name]];
  }
  // Repeat the rolls until we reach the maximum number of rolls,
  for(int rollNumber = 0; rollNumber < maximumRolls; rollNumber++){
    // Roll the first die.
    diceRoll1 = ((arc4random() % numberOfDieFaces) + 1);
    
    // Roll the second die.
    diceRoll2 = ((arc4random() % numberOfDieFaces) + 1);
    
    // If we rolled doubles,
    if(diceRoll1 == diceRoll2){
      // Increment the number of consecutive doubles rolled by 1.
      consecutiveDoubleRolled++;
      
      // If we have rolled doubles too many times,
      if(consecutiveDoubleRolled == consecutiveDoubleRolledUntilJail){
        // Reset the number of consecutive doubles rolled to 0.
        consecutiveDoubleRolled = 0;
        
        // Move to JAIL.
        currentPosition = (uint)[propertyNames indexOfObject:@"JAIL"];
      }
      // If we have NOT rolled doubles too many times,
      else{
        // Increment the position by the roll.
        currentPosition += (diceRoll1 + diceRoll2);
        
        // If the current position has moved off the board,
        if(currentPosition >= [propertyNames count]){
          // Move the current position back on to the board!
          currentPosition -= [propertyNames count];
        }
      }
    }
    else{
      // Reset the number of consecutive doubles rolled to 0.
      consecutiveDoubleRolled = 0;
      
      // Increment the position by the roll.
      currentPosition += (diceRoll1 + diceRoll2);
      
      // If the current position has moved off the board,
      if(currentPosition >= [propertyNames count]){
        // Move the current position back on to the board!
        currentPosition -= [propertyNames count];
      }
    }
    // Grab the current Monopoly property from the board.
    currentProperty = [properties objectAtIndex:currentPosition];
    
    // Check if we remain on this property.
    propertyLandedOn = [currentProperty landedOnProperty];
    
    // If we have to move to another property,
    if(propertyLandedOn != nil){
      // If we have to move back 3 spaces,
      if([propertyLandedOn isEqualToString:@"BACK3"]){
        // Move back 3 spaces.
        currentPosition -= 3;
        
        // Grab the current Monopoly property from the board.
        currentProperty = [properties objectAtIndex:currentPosition];
        
        // Check if we remain on this property.
        propertyLandedOn = [currentProperty landedOnProperty];
        
        // If we have to move to another property,
        if(propertyLandedOn != nil){
          // Move to the property we have to.
          currentPosition = (uint)[propertyNames indexOfObject:propertyLandedOn];
          
          // Grab the current Monopoly property from the board.
          currentProperty = [properties objectAtIndex:currentPosition];
          
          // Tell the current property it was landed on. There is no chance that
          // we have to move at this point.
          propertyLandedOn = [currentProperty landedOnProperty];
        }
      }
      // If we do NOT have to move back 3 spaces,
      else{
        // Move to the property we have to.
        currentPosition = (uint)[propertyNames indexOfObject:propertyLandedOn];
        
        // Grab the current Monopoly property from the board.
        currentProperty = [properties objectAtIndex:currentPosition];
        
        // Tell the current property it was landed on. There is no chance that
        // we have to move at this point.
        propertyLandedOn = [currentProperty landedOnProperty];
      }
    }
  }
  // Order the Monopoly properties by number of time they have been landed on.
  properties = [NSMutableArray arrayWithArray:[properties sortedArrayUsingSelector:@selector(compareProperties:)]];
  
  // For the top 3 properties,
  for(int topPropertyIndex = 0; topPropertyIndex < 3; topPropertyIndex++){
    // Grab the current Monopoly property from the board.
    currentProperty = [properties objectAtIndex:topPropertyIndex];
    
    // Grab the position of the property on the board based on the name of the
    // Monopoly property.
    currentPosition = (uint)[propertyNames indexOfObject:currentProperty.name];
    
    // If the position of the Monopoly property is less than ten,
    if(currentPosition < 10){
      // Add the postion of the property to the concatenated string with a 0 in
      // front of it.
      threeMostPopularProperties = [NSString stringWithFormat:@"%@0%d", threeMostPopularProperties, currentPosition];
    }
    else{
      // Add the postion of the property to the concatenated string.
      threeMostPopularProperties = [NSString stringWithFormat:@"%@%d", threeMostPopularProperties, currentPosition];
    }
  }
  // Set the answer string to the three most popular properties concatenated
  // together.
  self.answer = threeMostPopularProperties;
  
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
  
  // Here, we simply build a Monopoly board, and use a Monopoly Property object
  // to handle if we have to move or not, as well as record the number of times
  // it has been landed on. Then, we simulate rolling two four sided die, and
  // move throughout the board 1,000,000 times. Finally, we order the properties
  // based on the number of times it has been landed on, and concatenate the top
  // three properties.
  //
  // While we could use a Stochastic Matrix to get exact answers, it is simpler
  // to just brute force it. If you'd like to learn more about Stochastic
  // Matrices, visit:
  //
  // http://en.wikipedia.org/wiki/Stochastic_matrix
  
  // Variable to hold the roll of the first die.
  uint diceRoll1 = 0;
  
  // Variable to hold the roll of the second die.
  uint diceRoll2 = 0;
  
  // Variable to hold the number of rolls to be completed. We chose 1,000,000,
  // but we could probably get away with a lower number.
  uint maximumRolls = 1000000;
  
  // Variable to hold the current position of the piece on the board.
  uint currentPosition = 0;
  
  // Variable to hold the number of faces the dice have.
  uint numberOfDieFaces = 4;
  
  // Variable to hold the number of times consecutive doubles are rolled.
  uint consecutiveDoubleRolled = 0;
  
  // Variable to hold the number of times consecutive doubles required to be
  // rolled to go to JAIL.
  uint consecutiveDoubleRolledUntilJail = 3;
  
  // Variable to hold the name of the property that was landed on.
  NSString * propertyLandedOn = nil;
  
  // Variable to hold the three most popular properties concatenated together.
  NSString * threeMostPopularProperties = @"";
  
  // Variable to hold the current property the piece has landed on.
  MonopolyProperty * currentProperty = nil;
  
  // Array to hold the names of all the properties in order on the board.
  NSArray * propertyNames = [NSArray arrayWithObjects:@"GO", @"A1", @"CC1", @"A2", @"T1", @"R1", @"B1", @"CH1", @"B2", @"B3", @"JAIL", @"C1", @"U1", @"C2", @"C3", @"R2", @"D1", @"CC2", @"D2", @"D3", @"FP", @"E1", @"CH2", @"E2", @"E3", @"R3", @"F1", @"F2", @"U2", @"F3", @"G2J", @"G1", @"G2", @"CC3", @"G3", @"R4", @"CH3", @"H1", @"T2", @"H2", nil];
  
  // Variable array to hold all the Monopoly properties in order on the board.
  NSMutableArray * properties = [[NSMutableArray alloc] initWithCapacity:[propertyNames count]];
  
  // For all the property names on the board,
  for(NSString * name in propertyNames){
    // Create a Monopoly property with that name and add it to the properties
    // array.
    [properties addObject:[[MonopolyProperty alloc] initWithName:name]];
  }
  // Repeat the rolls until we reach the maximum number of rolls,
  for(int rollNumber = 0; rollNumber < maximumRolls; rollNumber++){
    // Roll the first die.
    diceRoll1 = ((arc4random() % numberOfDieFaces) + 1);
    
    // Roll the second die.
    diceRoll2 = ((arc4random() % numberOfDieFaces) + 1);
    
    // If we rolled doubles,
    if(diceRoll1 == diceRoll2){
      // Increment the number of consecutive doubles rolled by 1.
      consecutiveDoubleRolled++;
      
      // If we have rolled doubles too many times,
      if(consecutiveDoubleRolled == consecutiveDoubleRolledUntilJail){
        // Reset the number of consecutive doubles rolled to 0.
        consecutiveDoubleRolled = 0;
        
        // Move to JAIL.
        currentPosition = (uint)[propertyNames indexOfObject:@"JAIL"];
      }
      // If we have NOT rolled doubles too many times,
      else{
        // Increment the position by the roll.
        currentPosition += (diceRoll1 + diceRoll2);
        
        // If the current position has moved off the board,
        if(currentPosition >= [propertyNames count]){
          // Move the current position back on to the board!
          currentPosition -= [propertyNames count];
        }
      }
    }
    else{
      // Reset the number of consecutive doubles rolled to 0.
      consecutiveDoubleRolled = 0;
      
      // Increment the position by the roll.
      currentPosition += (diceRoll1 + diceRoll2);
      
      // If the current position has moved off the board,
      if(currentPosition >= [propertyNames count]){
        // Move the current position back on to the board!
        currentPosition -= [propertyNames count];
      }
    }
    // Grab the current Monopoly property from the board.
    currentProperty = [properties objectAtIndex:currentPosition];
    
    // Check if we remain on this property.
    propertyLandedOn = [currentProperty landedOnProperty];
    
    // If we have to move to another property,
    if(propertyLandedOn != nil){
      // If we have to move back 3 spaces,
      if([propertyLandedOn isEqualToString:@"BACK3"]){
        // Move back 3 spaces.
        currentPosition -= 3;
        
        // Grab the current Monopoly property from the board.
        currentProperty = [properties objectAtIndex:currentPosition];
        
        // Check if we remain on this property.
        propertyLandedOn = [currentProperty landedOnProperty];
        
        // If we have to move to another property,
        if(propertyLandedOn != nil){
          // Move to the property we have to.
          currentPosition = (uint)[propertyNames indexOfObject:propertyLandedOn];
          
          // Grab the current Monopoly property from the board.
          currentProperty = [properties objectAtIndex:currentPosition];
          
          // Tell the current property it was landed on. There is no chance that
          // we have to move at this point.
          propertyLandedOn = [currentProperty landedOnProperty];
        }
      }
      // If we do NOT have to move back 3 spaces,
      else{
        // Move to the property we have to.
        currentPosition = (uint)[propertyNames indexOfObject:propertyLandedOn];
        
        // Grab the current Monopoly property from the board.
        currentProperty = [properties objectAtIndex:currentPosition];
        
        // Tell the current property it was landed on. There is no chance that
        // we have to move at this point.
        propertyLandedOn = [currentProperty landedOnProperty];
      }
    }
  }
  // Order the Monopoly properties by number of time they have been landed on.
  properties = [NSMutableArray arrayWithArray:[properties sortedArrayUsingSelector:@selector(compareProperties:)]];
  
  // For the top 3 properties,
  for(int topPropertyIndex = 0; topPropertyIndex < 3; topPropertyIndex++){
    // Grab the current Monopoly property from the board.
    currentProperty = [properties objectAtIndex:topPropertyIndex];
    
    // Grab the position of the property on the board based on the name of the
    // Monopoly property.
    currentPosition = (uint)[propertyNames indexOfObject:currentProperty.name];
    
    // If the position of the Monopoly property is less than ten,
    if(currentPosition < 10){
      // Add the postion of the property to the concatenated string with a 0 in
      // front of it.
      threeMostPopularProperties = [NSString stringWithFormat:@"%@0%d", threeMostPopularProperties, currentPosition];
    }
    else{
      // Add the postion of the property to the concatenated string.
      threeMostPopularProperties = [NSString stringWithFormat:@"%@%d", threeMostPopularProperties, currentPosition];
    }
  }
  // Set the answer string to the three most popular properties concatenated
  // together.
  self.answer = threeMostPopularProperties;
  
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