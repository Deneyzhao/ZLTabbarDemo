//
//  RGBManager.h
//  BRANDSH
//
//  Created by Deney on 16/1/14.
//  Copyright © 2016年 brandsh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface RGBManager : NSObject

/**
 *  将#FF0000转换成 RGB颜色的方法
 *
 *  @param colorString 类似#FF0000
 *
 *  @return color
 */
+ (UIColor *)colorFromRGBColorString:(NSString *)colorString;

@end
