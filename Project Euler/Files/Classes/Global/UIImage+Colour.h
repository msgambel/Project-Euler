//  UIImage+Colour.h

#import <Foundation/Foundation.h>

@interface UIImage (Colour)

// Return a Resizeable Image of a given colour.
+ (UIImage *)imageWithColour:(UIColor *)aColour;

@end
