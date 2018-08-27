//
//  UIColor+Hex.m
//  ChatClient
//

#import "UIColor+Hex.h"
#import <stdlib.h>

@implementation UIColor (Hex)

+ (UIColor *)colorForHex:(NSString *)hexColor
{
#if 1
    UIColor *ret = [UIColor redColor];
    int off = 0;
    NSInteger len = [hexColor length];
    if (len < 6)
        return (ret);
    if ([hexColor hasPrefix:@"#"])
    {
        off = 1;
        --len;
    }
    if ((len != 6) && (len != 8))   // 6 characters or 8 characters if include alpha
        return (ret);

    unsigned r, g, b, a = 0xff;
    [[NSScanner scannerWithString:[hexColor substringWithRange:NSMakeRange(off + 0, 2)]] scanHexInt:&r];
    [[NSScanner scannerWithString:[hexColor substringWithRange:NSMakeRange(off + 2, 2)]] scanHexInt:&g];
    [[NSScanner scannerWithString:[hexColor substringWithRange:NSMakeRange(off + 4, 2)]] scanHexInt:&b];
    if (len == 8)
    {
        [[NSScanner scannerWithString:[hexColor substringWithRange:NSMakeRange(off + 6, 2)]] scanHexInt:&a];
    }
    ret = [UIColor colorWithRed:((float)r/255.0) green:((float)g/255.0) blue:((float)b/255.0) alpha:((float)a/255.0)];
    return (ret);
#else
    // String should be 6 or 7 characters if it includes '#'
    if ([hexColor length]  < 6) 
		return nil;  
    
    // strip # if it appears  
    if ([hexColor hasPrefix:@"#"]) 
		hexColor = [hexColor substringFromIndex:1];  
    
    // if the value isn't 6 characters at this point return 
    // the color black	
    if ([hexColor length] != 6) 
		return nil;  
    
    // Separate into r, g, b substrings  
    NSRange range;  
    range.location = 0;  
    range.length = 2; 
    
    NSString *rString = [hexColor substringWithRange:range];  
    
    range.location = 2;  
    NSString *gString = [hexColor substringWithRange:range];  
    
    range.location = 4;  
    NSString *bString = [hexColor substringWithRange:range];  
    
    // Scan values  
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];  
    [[NSScanner scannerWithString:gString] scanHexInt:&g];  
    [[NSScanner scannerWithString:bString] scanHexInt:&b];  
    
    return [UIColor colorWithRed:((float) r / 255.0f)  
                           green:((float) g / 255.0f)  
                            blue:((float) b / 255.0f)  
                           alpha:1.0f];
#endif
}

+ (UIColor *)colorForRandom
{
    UIColor *color = nil;
    
    switch(arc4random() % 6)
    {
        case 0: color = [UIColor colorForHex:@"F8661F"];break;
        case 1: color = [UIColor colorForHex:@"E9C21F"];break;
        case 2: color = [UIColor colorForHex:@"4CBA6A"];break;
        case 3: color = [UIColor colorForHex:@"2181CB"];break;
        case 4: color = [UIColor colorForHex:@"2CA7EA"];break;
        case 5: color = [UIColor colorForHex:@"87B52E"];break;
        
        default: break;
    }
    
    return color;
}

@end
