//  MonopolyProperty.m

#import "MonopolyProperty.h"

@implementation MonopolyProperty

@synthesize name = _name;
@synthesize numberOfTimesLandedOn = _numberOfTimesLandedOn;

// Define to hold the number of cards in the Chance and Community Chest piles.
#define NumberOfChanceOrCommunityChestCardsToChooseFrom 16

#pragma mark - Init

- (id)initWithName:(NSString *)aName; {
  if((self = [super init])){
    // Store the name of the property.
    _name = aName;
    
    // Set the default number of times the property has been landed on to 0.
    _numberOfTimesLandedOn = 0;
    
    // Set if this property is the "Go To JAIL" property.
    _isGoToJail = [_name isEqualToString:@"G2J"];
    
    // If the property is a Community Chest property,
    if([_name isEqualToString:@"CC1"] || [_name isEqualToString:@"CC2"] || [_name isEqualToString:@"CC3"]){
      // Set that this property can choose a card.
      _canChooseCard = YES;
      
      // Set the locations of the cards that cause movement.
      _alternateLocations = [NSArray arrayWithObjects:@"GO", @"JAIL", nil];
    }
    // If the property is the first Chance property,
    else if([_name isEqualToString:@"CH1"]){
      // Set that this property can choose a card.
      _canChooseCard = YES;
      
      // Set the locations of the cards that cause movement.
      _alternateLocations = [NSArray arrayWithObjects:@"GO", @"JAIL", @"C1", @"E3", @"H2", @"R1", @"R2", @"R2", @"U1", @"BACK3", nil];
    }
    // If the property is the second Chance property,
    else if([_name isEqualToString:@"CH2"]){
      // Set that this property can choose a card.
      _canChooseCard = YES;
      
      // Set the locations of the cards that cause movement.
      _alternateLocations = [NSArray arrayWithObjects:@"GO", @"JAIL", @"C1", @"E3", @"H2", @"R1", @"R3", @"R3", @"U2", @"BACK3", nil];
    }
    // If the property is the third Chance property,
    else if([_name isEqualToString:@"CH3"]){
      // Set that this property can choose a card.
      _canChooseCard = YES;
      
      // Set the locations of the cards that cause movement.
      _alternateLocations = [NSArray arrayWithObjects:@"GO", @"JAIL", @"C1", @"E3", @"H2", @"R1", @"R1", @"R1", @"U1", @"BACK3", nil];
    }
    // If this property is NOT a property with any cards,
    else{
      // Set the alternate locations this property can lead to to nil.
      _alternateLocations = nil;
    }
  }
  return self;
}

#pragma mark - Methods

- (void)printStats; {
  // Print the name of the property and how many times it was landed on to the
  // console.
  NSLog(@"%@ was landed on %d times.", _name, _numberOfTimesLandedOn);
}

- (NSString *)landedOnProperty; {
  // If this property can choose a card,
  if(_canChooseCard){
    // Choose a random card from the card pile.
    uint choosenCard = arc4random() % NumberOfChanceOrCommunityChestCardsToChooseFrom;
    
    // If the chosen card is a card that causes movement,
    if(choosenCard < [_alternateLocations count]){
      // Return the location that should be moved to.
      return[_alternateLocations objectAtIndex:choosenCard];
    }
  }
  // If this property is the "Go To JAIL" property,
  else if(_isGoToJail){
    // Return that the piece should move to the "JAIL" property.
    return @"JAIL";
  }
  // If no movement has occured, increment the number of times this property has
  // been landed on by 1.
  _numberOfTimesLandedOn++;
  
  // Return that the peieve should stay on this property.
  return nil;
}

- (NSComparisonResult)compareProperties:(MonopolyProperty *)aMonopolyProperty; {
  // If this property has been landed on more times thea the inputted property,
  if(self.numberOfTimesLandedOn > aMonopolyProperty.numberOfTimesLandedOn){
    // Return that this property has a higher value than the inputted property.
    return NSOrderedAscending;
  }
  // If this property has been landed on less times than the inputted property,
  else if(self.numberOfTimesLandedOn < aMonopolyProperty.numberOfTimesLandedOn){
    // Return that this property has a lower value than the inputted property.
    return NSOrderedDescending;
  }
  // If this property has been landed on the same number of times as the
  // inputted property,
  else{
    // Return that this property has the same value than the inputted property.
    return NSOrderedSame;
  }
}

@end