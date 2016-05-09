//
//  ZLIconButton.h
//  BRANDSH
//
//  Created by Deney on 16/1/21.
//  Copyright © 2016年 brandsh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Title+ZLButton.h"
#import "Imgv+ZLButton.h"
#import "Tools.h"

@interface ZLIconButton : UIButton


@property(nonatomic,strong)Title_ZLButton *customTitle;
@property(nonatomic,strong)Imgv_ZLButton *customImgv;

@property(nonatomic,copy)NSArray *selImages;
@property(nonatomic,copy)NSArray *customNorImages;

- (void)setBtnTitle:(NSString *)title Image:(UIImage *)image selecte:(BOOL)selecte;

/**
 *  改变按钮标题动画
 *
 *  @param selecte bool
 */
- (void)setCustomTitleColorWithSelecte:(BOOL)selecte;

/**
 *  改变图片，并启动图片的动画
 *
 *  @param selecte bool
 */
- (void)setCustomImgvWithSelecte:(BOOL)selecte atIndex:(NSInteger)index;

/**
 *  开始动画
 */
- (void)startMyAnimationAtIndex:(NSInteger)index;

/**
 *  结束动画
 */
- (void)stopMyAnimationAtIndex:(NSInteger)index;


@end
