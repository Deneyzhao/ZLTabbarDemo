//
//  Tools.h
//  
//
//  Created by Deney on 14-12-31.
//  Copyright (c) 2014年 Deney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Tools : NSObject
#define IOS7 ([[UIDevice currentDevice].systemVersion doubleValue]>=7.0)

+(CGSize)sizeOfStr:(NSString *)str withFont:(UIFont *)font withMaxWidth:(CGFloat)width withLineBreakMode:(NSLineBreakMode)mode;

@end
