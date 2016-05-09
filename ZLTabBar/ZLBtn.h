//
//  ZLBtn.h
//  BRANDSH
//
//  Created by Deney on 16/1/19.
//  Copyright © 2016年 brandsh. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZLBtn : UIButton

@property(nonatomic,strong)UIImageView *colorView;


@property(nonatomic,strong)void (^changedBlock)(CGFloat Width);



- (void)setColorViewWithColor:(UIColor *)color show:(BOOL)show;

@end
