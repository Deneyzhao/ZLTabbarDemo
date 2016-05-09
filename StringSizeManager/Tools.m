//
//  Tools.m
//  
//
//  Created by Deney on 14-12-31.
//  Copyright (c) 2014年 Deney. All rights reserved.
//

#import "Tools.h"

@implementation Tools

/*
 适配:屏幕大小,系统版本(UI,方法)
 */
+(CGSize)sizeOfStr:(NSString *)str withFont:(UIFont *)font withMaxWidth:(CGFloat)width withLineBreakMode:(NSLineBreakMode)mode
{
    if (IOS7) {
        CGSize size = [str boundingRectWithSize:CGSizeMake(width, 0) options:3 attributes:@{NSFontAttributeName: font} context:nil].size;
        return size;
    }
    else
    {
        CGSize size = [str sizeWithFont:font constrainedToSize:CGSizeMake(width, 999999) lineBreakMode:NSLineBreakByWordWrapping];
        return size;
    }
}


@end
