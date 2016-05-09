//
//  ZLTabBar.h
//  BRANDSH
//
//  Created by Deney on 16/1/19.
//  Copyright © 2016年 brandsh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RGBManager.h"

//四个按钮的主题颜色
#define HomeColor  [UIColor colorWithRed:0.99f green:0.34f blue:0.34f alpha:1.00f]
#define GameColor  [UIColor colorWithRed:1.00f green:0.74f blue:0.45f alpha:1.00f]
#define PhotoColor  [UIColor colorWithRed:0.45f green:0.84f blue:0.71f alpha:1.00f]
#define BookColor    [UIColor colorWithRed:0.45f green:0.68f blue:0.81f alpha:1.00f]

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define TabBarH  52



@interface ZLTabBar : UIView

@property(nonatomic,copy)NSArray *colors;
@property(nonatomic,copy)NSArray *itemTitles;
@property(nonatomic,copy)NSArray *norImages;

@property(nonatomic,strong)void (^btnSelectBlock)(NSInteger index);

/**
 *  设置tabbaritem 的数量
 *
 *  @param itemsCount 按钮数量
 */
- (void)setTabBarWithItemsCount:(NSInteger)itemsCount;




@end
