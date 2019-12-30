//  UIImage+Colour.m

#import "UIImage+Colour.h"

@implementation UIImage (Colour)

+ (UIImage *)imageWithColour:(UIColor *)aColour; {
  CGRect rect = CGRectMake(0.0f, 0.0f, 3.0f, 3.0f);
  
  UIGraphicsBeginImageContext(rect.size);
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(context, [aColour CGColor]);
  CGContextFillRect(context, rect);
  UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
  
  UIGraphicsEndImageContext();
  
  return [image resizableImageWithCapInsets:UIEdgeInsetsMake(1.0f, 1.0f, 1.0f, 1.0f)];
}

@end
