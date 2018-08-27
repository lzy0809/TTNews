//
//  UIColor+Hex.h
//  ChatClient
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

/*
 * Convert a string of format #4172AC into a UIColor instance. Nil is return if the specified string
 * isn't in the correct format.
 */
+ (UIColor *)colorForHex:(NSString *)hexColor;
+ (UIColor *)colorForRandom;
@end
