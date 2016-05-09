//
//  RGBManager.m
//  BRANDSH
//
//  Created by Deney on 16/1/14.
//  Copyright © 2016年 brandsh. All rights reserved.
//

#import "RGBManager.h"

@implementation RGBManager

+ (UIColor *)colorFromRGBColorString:(NSString *)colorString
{
    // 转换成标准16进制数
    NSMutableString *color = [NSMutableString stringWithString:colorString];
    [color replaceCharactersInRange:[color rangeOfString:@"#" ] withString:@"0x"];
    // 十六进制字符串转成整形。
    long colorLong = strtoul([color cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);
    // 通过位与方法获取三色值
    int R = (colorLong & 0xFF0000 )>>16;
    int G = (colorLong & 0x00FF00 )>>8;
    int B =  colorLong & 0x0000FF;
    //string转color
    UIColor *newColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0];
    return newColor;
}

@end
