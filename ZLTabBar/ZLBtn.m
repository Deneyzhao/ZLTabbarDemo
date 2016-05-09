//
//  ZLBtn.m
//  BRANDSH
//
//  Created by Deney on 16/1/19.
//  Copyright © 2016年 brandsh. All rights reserved.
//

#import "ZLBtn.h"

@implementation ZLBtn

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return self;
}


- (void)setColorViewWithColor:(UIColor *)color show:(BOOL)show
{
    self.colorView = [[UIImageView alloc]init];
    self.colorView.backgroundColor = color;
    self.colorView.alpha = 0.0f;
    self.colorView.clipsToBounds = YES;
    if (show) {
        self.colorView.alpha = 1.0f;
        self.colorView.frame = self.bounds;
    }
    [self addSubview:self.colorView];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
