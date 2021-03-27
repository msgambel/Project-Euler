//  UIImage+Colour.m

#import "UIImage+Colour.h"

@implementation UIImage (Colour)

#pragma mark - Class Methods

// Return a Resizeable Image of a given colour.
+ (UIImage *)imageWithColour:(UIColor *)aColour; {
  // Create a small rect as the size of the original coloured image.
  CGRect rect = CGRectMake(0.0f, 0.0f, 3.0f, 3.0f);
  
  // Begin a Graphics Image Context with the size of the original coloured image.
  UIGraphicsBeginImageContext(rect.size);
  
  // Get a reference to the current Graphics Context.
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  // Set the Fill Colour of the Context to the provided colour.
  CGContextSetFillColorWithColor(context, [aColour CGColor]);
  
  // Fill the Context with the provided colour.
  CGContextFillRect(context, rect);
  
  // Create an Image in the Context, and grab a reference to it.
  UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
  
  // End the Graphics Image Context.
  UIGraphicsEndImageContext();
  
  // Return a Resizeable Image of the one just created, allowing it to stretch.
  return [image resizableImageWithCapInsets:UIEdgeInsetsMake(1.0f, 1.0f, 1.0f, 1.0f)];
}

@end
