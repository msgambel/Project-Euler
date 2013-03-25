//  MonopolyProperty.h

#import <Foundation/Foundation.h>

@interface MonopolyProperty : NSObject {
  BOOL       _isGoToJail;
  BOOL       _canChooseCard;
  uint       _numberOfTimesLandedOn;
  NSArray  * _alternateLocations;
  NSString * _name;
}

@property (nonatomic, readonly) uint       numberOfTimesLandedOn;
@property (nonatomic, readonly) NSString * name;

- (id)initWithName:(NSString *)aName;
- (void)printStats;
- (NSString *)landedOnProperty;
- (NSComparisonResult)compareProperties:(MonopolyProperty *)aMonopolyProperty;

@end