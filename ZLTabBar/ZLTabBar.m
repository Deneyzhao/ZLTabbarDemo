//
//  ZLTabBar.m
//  BRANDSH
//
//  Created by Deney on 16/1/19.
//  Copyright © 2016年 brandsh. All rights reserved.
//

#import "ZLTabBar.h"
#import "ZLBtn.h"
#import "ZLIconButton.h"

@implementation ZLTabBar
{
    NSInteger _lastIndex;
    NSInteger _current;
    ZLBtn *_lastBtn;
    BOOL _isPicture;
}

#pragma mark - init
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, SCREEN_HEIGHT - TabBarH, SCREEN_WIDTH, TabBarH);//#f8f8f8
        self.backgroundColor = [RGBManager colorFromRGBColorString:@"#f8f8f8"]; //[UIColor
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(collectionDidSeleted) name:@"collectionDidSeleted" object:nil];
        CGFloat W = SCREEN_WIDTH/4;
        for (int i=0; i<4; i++) {
            ZLBtn *zlBtn = [[ZLBtn alloc]initWithFrame:CGRectMake(i*W, 0, W, self.frame.size.height)];
            zlBtn.userInteractionEnabled = NO;
            zlBtn.tag = 8000+i;
            if (i==0) {
                [zlBtn setColorViewWithColor:self.colors[i] show:YES];
            }
            else{
                [zlBtn setColorViewWithColor:self.colors[i] show:NO];
            }
            [self addSubview:zlBtn];
        }
        
    }
    return self;
}

#pragma mark - unity

 -(NSArray *)colors
{
    if (!_colors) {
        _colors = @[HomeColor,GameColor,PhotoColor,BookColor];
    }
    return _colors;
}

- (NSArray *)norImages
{
    if (!_norImages) {
        _norImages = @[@"custommap_nor",@"customgame_nor",@"customphoto_nor",@"custombook_nor"];
    }
    return _norImages;
}



- (NSArray *)itemTitles
{
    if (!_itemTitles) {
        _itemTitles = @[@"地图",@"游戏",@"图库",@"通讯"];
    }
    return _itemTitles;
}



/**
 *  设置tabbaritem 的数量
 *
 *  @param itemsCount 按钮数量
 */
- (void)setTabBarWithItemsCount:(NSInteger)itemsCount
{
    CGFloat W = SCREEN_WIDTH/4;
    for (int i=0; i<4; i++) {
        ZLIconButton *button = [[ZLIconButton alloc]initWithFrame:CGRectMake(i*W, 0, W, self.frame.size.height)];
        button.tag = 8100+i;
        [button addTarget:self action:@selector(zlBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            [button setBtnTitle:self.itemTitles[i] Image:nil selecte:YES];
            [button startMyAnimationAtIndex:i];
        }
        else{
            [button setBtnTitle:self.itemTitles[i] Image:[UIImage imageNamed:self.norImages[i]] selecte:NO];
        }
        [self addSubview:button];
    }
    
}

- (void)zlBtnAction:(ZLIconButton *)iconBtn
{
    ZLBtn *btn = (ZLBtn *)[self viewWithTag:iconBtn.tag - 100];
    _current = btn.tag - 8000;
    
    if (_current==_lastIndex) {
        if (_isPicture) {
            _isPicture = NO;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"backToTotlePic" object:nil];
        }
        return ;
    }
    
    for (int i=0; i<4; i++) {
        ZLIconButton *button = (ZLIconButton *)[self viewWithTag:8100+i];
        button.selected = NO;
        [button setCustomTitleColorWithSelecte:NO];
        [button setCustomImgvWithSelecte:NO atIndex:i];
        button.userInteractionEnabled = NO;
    }
    
    iconBtn.selected = !iconBtn.selected;
    [iconBtn setCustomTitleColorWithSelecte:YES];
    [iconBtn setCustomImgvWithSelecte:YES atIndex:_current];
    
    //取出之前选中的按钮
    _lastBtn = [self viewWithTag:8000+_lastIndex];
    
    ZLIconButton *lastIcon = [self viewWithTag:8100+_lastIndex];
    
    [iconBtn startMyAnimationAtIndex:_current];
    
    [lastIcon stopMyAnimationAtIndex:_lastIndex];
    
    //通过下标，来判断动画的方向 1 为向右滑动，0为向左滑动
    if ( _current>_lastIndex && _current-_lastIndex==1 ) {
        [self drawViewWithColor:self.colors[_current] withZLBtn:btn direction:1];
    }
    else if ( _current<_lastIndex && _current-_lastIndex==-1 ){
        [self drawViewWithColor:self.colors[_current] withZLBtn:btn direction:0];
    }
    else if (_current>_lastIndex && _current-_lastIndex!=1) {
        [self animationWithNextIndex:_current LastIndex:_lastIndex direction:1];

    }
    else if ( _current<_lastIndex && _current-_lastIndex!=-1 ){
        [self animationWithNextIndex:_current LastIndex:_lastIndex direction:0];
    }
    _lastIndex = _current;
    self.btnSelectBlock(_current);
}

- (void)setButtonNormal
{
    for (ZLIconButton *button in self.subviews) {
        if ([button isKindOfClass:([ZLIconButton class])]) {
            button.userInteractionEnabled = YES;
        }
    }
}

#pragma mark -  进入图库
- (void)collectionDidSeleted
{
    //取出图库按钮
    ZLIconButton *button = (ZLIconButton *)[self viewWithTag:8100+_current];
    button.userInteractionEnabled = YES;
    _isPicture = YES;
}



#pragma mark - animation

/**
 *  通过颜色 来画 视图
 *
 *  @param color color
 */
- (void)drawViewWithColor:(UIColor *)color withZLBtn:(ZLBtn *)btn direction:(NSInteger)direction
{
    //btn 为当前点击的 按钮
    if (direction==1) {
        btn.colorView.frame = CGRectMake(0, 0, 0, btn.frame.size.height);
    }
    else{
        btn.colorView.frame = CGRectMake(btn.frame.size.width, 0, 0, btn.frame.size.height);
    }
    btn.colorView.backgroundColor = color;
    btn.colorView.alpha = 1.0f;
    [UIView animateWithDuration:0.15  animations:^{
        CGRect rect = btn.colorView.frame;
        rect.size.width=20;
        if (direction==0) {
            rect.origin.x = btn.frame.size.width-20;
        }
        btn.colorView.frame = rect;
    } completion:^(BOOL finished) {
        [self hiddenLastViewWithLastBtn:_lastBtn currentBtn:btn direction:direction];
    }];
    
}



/**
 *  隐藏
 */
- (void)hiddenLastViewWithLastBtn:(ZLBtn *)zlBtn currentBtn:(ZLBtn *)btn direction:(NSInteger)direction
{
    [self animationWithNextBtn:btn LastBtn:zlBtn direction:direction];
}


- (void)animationWithNextBtn:(ZLBtn *)nextBtn LastBtn:(ZLBtn *)lastBtn direction:(NSInteger)direction
{
    //zlBtn 是当前点击的按钮
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.65 initialSpringVelocity:0.8 options:0 animations:^{
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.8 options:0 animations:^{
            CGRect rect1 = nextBtn.colorView.frame;
            if (direction==0) {
                rect1.origin.x = 0;
            }
            rect1.size.width = nextBtn.frame.size.width;
            nextBtn.colorView.frame = rect1;
        } completion:nil];
        CGRect rect = lastBtn.colorView.frame;
        rect.size.width = 0;
        if (direction==1) {
            rect.origin.x = lastBtn.frame.size.width;
        }
        lastBtn.colorView.frame = rect;
    } completion:^(BOOL finished) {
        [self setButtonNormal];
        lastBtn.colorView.alpha = 0.0f;
        [nextBtn.colorView stopAnimating];
        [lastBtn.colorView stopAnimating];
    }];
}


- (void)animationWithNextIndex:(NSInteger)nextIndex LastIndex:(NSInteger)lastIndex direction:(NSInteger)direction
{
    ZLBtn *lastBtn = (ZLBtn *) [self viewWithTag:8000+lastIndex];
    if (direction==1) {//向右滑说明 nextIndex 大于 lastIndex
        NSMutableArray *btnArr  =[NSMutableArray array];
        for (int i=0; i<4; i++) {
            if (i>lastIndex && i<nextIndex) {
                ZLBtn *middleBtn = (ZLBtn *) [self viewWithTag:8000+i];
                [btnArr addObject:middleBtn];
            }
        }
        
        [self drawViewWithBtns:btnArr lastBtn:lastBtn];
        
    }
    else{//向左滑说明 nextIndex 小于 lastIndex
        NSMutableArray *btnArr  =[NSMutableArray array];
        for (int i=3; i>=0; i--) {
            if (i<lastIndex && i>nextIndex) {
                ZLBtn *middleBtn = (ZLBtn *) [self viewWithTag:8000+i];
                [btnArr addObject:middleBtn];
            }
        }
        [self drawViewWithBtns:btnArr nextBtn:lastBtn];
    }
}

#pragma mark - 向右滑动 （跳页）

/**
 *  通过颜色 来画 视图
 *
 *  @param color color
 */
- (void)drawViewWithBtns:(NSArray *)btns  lastBtn:(ZLBtn *)lastBtn
{
    ZLBtn *btn = btns[0];
    btn.colorView.backgroundColor = self.colors[btn.tag-8000];
    btn.colorView.alpha = 1.0f;
    btn.colorView.frame = CGRectMake(0, 0, 0, btn.frame.size.height);
    [UIView animateWithDuration:0.1  animations:^{
            CGRect rect = btn.colorView.frame;
            rect.size.width=20;
            btn.colorView.frame = rect;
    } completion:^(BOOL finished) {
        [self btnAnimation:btn];
        [self lastBtnAnimation:lastBtn];
    }];
}

- (void)lastBtnAnimation:(ZLBtn *)lastBtn
{
    [UIView animateWithDuration:0.1  animations:^{
        CGRect rect = lastBtn.colorView.frame;
        rect.size.width=0;
        rect.origin.x = lastBtn.frame.size.width;
        lastBtn.colorView.frame = rect;
    } completion:^(BOOL finished) {
        lastBtn.colorView.alpha = 0.0f;
    }];
}

- (void)btnAnimation:(ZLBtn *)btn
{
    ZLBtn *nextBtn = [self viewWithTag:btn.tag+1];
    [UIView animateWithDuration:0.1  animations:^{
        CGRect rect = btn.colorView.frame;
        rect.size.width=btn.frame.size.width;
        btn.colorView.frame = rect;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1  animations:^{
            CGRect rect = btn.colorView.frame;
            rect.origin.x=btn.frame.size.width;
            btn.colorView.frame = rect;
        } completion:^(BOOL finished) {
            btn.colorView.alpha = 0.0f;
        }];
        [self nextBtnAnimation:nextBtn];
   }];
}


- (void)nextBtnAnimation:(ZLBtn *)btn
{
    ZLBtn *nextBtn = [self viewWithTag:btn.tag+1];
    if (btn==nil) {
        [btn.colorView stopAnimating];
        [nextBtn.colorView stopAnimating];
        return ;
    }
    btn.colorView.alpha = 1.0f;
    btn.colorView.backgroundColor = self.colors[btn.tag-8000];
    btn.colorView.frame = CGRectMake(0, 0, 0,btn.frame.size.height);
    
    [UIView animateWithDuration:0.07 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        CGRect rect = btn.colorView.frame;
        rect.size.width=btn.frame.size.width;
        btn.colorView.frame = rect;
    } completion:^(BOOL finished) {
        if (btn.tag-8000 >=_current) {
            [self setButtonNormal];
            [btn.colorView stopAnimating];
            return ;
        }
        else {
            [UIView animateWithDuration:0.07 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                    CGRect rect = btn.colorView.frame;
                    rect.origin.x=btn.frame.size.width;
                    btn.colorView.frame = rect;
            } completion:^(BOOL finished) {
                   btn.colorView.alpha = 0.0f;
            }];
            [self nextBtnAnimation:nextBtn];
        }
    }];
    
}


#pragma mark -  向左滑动 （跳页）

/**
 *  通过颜色 来画 视图
 *
 *  @param color color
 */
- (void)drawViewWithBtns:(NSArray *)btns  nextBtn:(ZLBtn *)nextBtn
{
    ZLBtn *btn = btns[0];
    btn.colorView.backgroundColor = self.colors[btn.tag-8000];
    btn.colorView.alpha = 1.0f;
    btn.colorView.frame = CGRectMake(btn.frame.size.width, 0, 0, btn.frame.size.height);
    [UIView animateWithDuration:0.1  animations:^{
        CGRect rect = btn.colorView.frame;
        rect.size.width=20;
        rect.origin.x = btn.frame.size.width - 20;
        btn.colorView.frame = rect;
    } completion:^(BOOL finished) {
        [self leftAnimation:btn];
        [self leftLastBtnAnimation:nextBtn];
    }];
}


- (void)leftAnimation:(ZLBtn *)btn
{
    ZLBtn *lastBtn = [self viewWithTag:btn.tag-1];
    [UIView animateWithDuration:0.1  animations:^{
        CGRect rect = btn.colorView.frame;
        rect.size.width=btn.frame.size.width;
        rect.origin.x = 0;
        btn.colorView.frame = rect;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1  animations:^{
            CGRect rect = btn.colorView.frame;
            rect.size.width=0;
            btn.colorView.frame = rect;
        } completion:^(BOOL finished) {
            btn.colorView.alpha = 0.0f;
        }];
        
        [self lastAnimation:lastBtn];
    }];
}


- (void)leftLastBtnAnimation:(ZLBtn *)nextBtn
{
    [UIView animateWithDuration:0.1  animations:^{
        CGRect rect = nextBtn.colorView.frame;
        rect.size.width=0;
        nextBtn.colorView.frame = rect;
    } completion:^(BOOL finished) {
        nextBtn.colorView.alpha = 0.0f;
    }];
}


- (void)lastAnimation:(ZLBtn *)btn
{
    ZLBtn *lastBtn = [self viewWithTag:btn.tag-1];
    if (btn==nil) {
        [btn.colorView stopAnimating];
        [lastBtn.colorView stopAnimating];
        return ;
    }
    btn.colorView.alpha = 1.0f;
    btn.colorView.backgroundColor = self.colors[btn.tag-8000];
    btn.colorView.frame = CGRectMake(btn.frame.size.width, 0, 0,btn.frame.size.height);
    
    [UIView animateWithDuration:0.07 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        CGRect rect = btn.colorView.frame;
        rect.size.width=btn.frame.size.width;
        rect.origin.x = 0;
        btn.colorView.frame = rect;
    } completion:^(BOOL finished) {
        if (btn.tag-8000 <=_current) {
            [self setButtonNormal];
            [btn.colorView stopAnimating];
            return ;
        }
        else {
            [UIView  animateWithDuration:0.07 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                CGRect rect = btn.colorView.frame;
                rect.size.width=0;
                btn.colorView.frame = rect;
            } completion:^(BOOL finished) {
                btn.colorView.alpha = 0.0f;
            }];
            [self lastAnimation:lastBtn];
        }
    }];
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
