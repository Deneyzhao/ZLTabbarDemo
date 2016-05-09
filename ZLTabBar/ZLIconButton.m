//
//  ZLIconButton.m
//  BRANDSH
//
//  Created by Deney on 16/1/21.
//  Copyright © 2016年 brandsh. All rights reserved.
//

#import "ZLIconButton.h"

@implementation ZLIconButton
{
    //地图
    UIImageView *_mapLine1;
    UIImageView *_mapLine2;
    
    //游戏
    UIImageView *_gamePoint1;
    UIImageView *_gamePoint2;
    UIImageView *_gamePoint3;
    
    //图库
    UIImageView *_photoAnima1;
    UIImageView *_photoAnima2;
    
    //通讯录
    UIImageView *_bookAnima1;
    UIImageView *_bookAnima2;
    
    
}

- (NSArray *)selImages
{
    if (!_selImages) {
        _selImages = @[@"custommap_sel",@"customgame_sel",@"customphoto_sel",@"custombook_sel"];
    }
    return _selImages;
}

- (NSArray *)customNorImages
{
    if (!_customNorImages) {
        _customNorImages = @[@"custommap_nor",@"customgame_nor",@"customphoto_nor",@"custombook_nor"];
    }
    return _customNorImages;
}


#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


- (void)setBtnTitle:(NSString *)title Image:(UIImage *)image selecte:(BOOL)selecte
{
    if (!image) {
        image = [UIImage imageNamed:self.selImages[0]];
    }
    self.customImgv = [[Imgv_ZLButton alloc]initWithFrame:CGRectMake((self.frame.size.width - image.size.width)/2, 7, image.size.width, image.size.height)];
    self.customImgv.image = image;
    [self addSubview:self.customImgv];
    
    CGSize size = [Tools sizeOfStr:title withFont:[UIFont systemFontOfSize:14] withMaxWidth:self.frame.size.width withLineBreakMode:0];
    self.customTitle = [[Title_ZLButton alloc]initWithFrame:CGRectMake((self.frame.size.width - size.width)/2, 33, size.width, size.height)];
    self.customTitle.text = title;
    self.customTitle.font = [UIFont systemFontOfSize:14];
    if (selecte) {
        self.customTitle.textColor = [UIColor whiteColor];
    }
    else{
        self.customTitle.textColor = [UIColor lightGrayColor];
    }
    self.customTitle.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.customTitle];
}


/**
 *  改变按钮标题动画
 *
 *  @param selecte
 */
- (void)setCustomTitleColorWithSelecte:(BOOL)selecte
{
    if (selecte) {
        self.customTitle.textColor = [UIColor whiteColor];
    }
    else{
        self.customTitle.textColor = [UIColor lightGrayColor];
    }
}


/**
 *  改变图片，并启动图片的动画
 *
 *  @param selecte bool
 */
- (void)setCustomImgvWithSelecte:(BOOL)selecte atIndex:(NSInteger)index
{
    if (selecte) {
        self.customImgv.image = [UIImage imageNamed:self.selImages[index]];
    }
    else{
        self.customImgv.image = [UIImage imageNamed:self.customNorImages[index]];
    }
}

#pragma mark - 开始动画
/**
 *  开始动画
 */
- (void)startMyAnimationAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            [self firstItemAnimation];
            break;
        case 1:
            [self secondItemAnimation];
            break;
        case 2:
            [self thirdItemAnimation];
            break;
        case 3:
            [self fourthItemAnimation];
            break;
            
        default:
            break;
    }
}

#pragma mark - 地图 按钮的开始动画
- (void)firstItemAnimation
{
    UIImage *image1 = [UIImage imageNamed:@"mapAnimation1"];
    UIImage *image2 = [UIImage imageNamed:@"mapAnimation2"];
    if (!_mapLine1) {
        
        _mapLine1 = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width - image1.size.width)/2, self.customImgv.frame.size.height+self.customImgv.frame.origin.y-5, 0, image1.size.height)];
        _mapLine1.image = image1;
        [self addSubview:_mapLine1];
        
        
        _mapLine2 = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width - image2.size.width)/2 , _mapLine1.frame.origin.y, 0, image2.size.height)];
        _mapLine2.image = image2;
        [self addSubview:_mapLine2];
        _mapLine2.transform = CGAffineTransformMakeRotation(M_PI);
    }

    if (!_mapLine1.image) {
        _mapLine1.image = image1;
        _mapLine2.image = image2;
    }
    
    
    [UIView animateWithDuration:0.3 delay:0.3 options:0 animations:^{
        CGRect rect = self.customImgv.frame;
        rect.origin.y = 3;
        self.customImgv.frame = rect;
    } completion:^(BOOL finished) {
        [self item1startAnimation];
    }];
}


- (void)item1startAnimation
{
    UIImage *image1 = [UIImage imageNamed:@"mapAnimation1"];
    UIImage *image2 = [UIImage imageNamed:@"mapAnimation2"];
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = _mapLine1.frame;
        rect.size.width = image1.size.width;
        _mapLine1.frame = rect;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            CGRect rect = _mapLine2.frame;
            rect.size.width = image2.size.width;
            _mapLine2.frame = rect;
        }completion:^(BOOL finished) {
            
        }];
    }];
}

#pragma mark - 游戏按钮的开始动画

- (void)secondItemAnimation
{
    UIImage *image1 = [UIImage imageNamed:@"gameAnimation1"];
    UIImage *image2 = [UIImage imageNamed:@"gameAnimation2"];
    UIImage *image3 = [UIImage imageNamed:@"gameAnimation3"];
    if (!_gamePoint1) {
        _gamePoint1 = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width - image1.size.width)/2, (self.frame.size.height - image1.size.height)/2, image1.size.width, image1.size.height)];
        _gamePoint1.alpha = 0.0f;
        _gamePoint1.image = image1;
        [self addSubview:_gamePoint1];
        
        _gamePoint2 = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width - image2.size.width)/2, (self.frame.size.height - image2.size.height)/2, image2.size.width, image2.size.height)];
        _gamePoint2.image = image2;
        _gamePoint2.alpha = 0.0f;
        [self addSubview:_gamePoint2];
        
        _gamePoint3 = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width - image3.size.width)/2, (self.frame.size.height - image3.size.height)/2, image3.size.width, image3.size.height)];
        _gamePoint3.image = image3;
        _gamePoint3.alpha = 0.0f;
        [self addSubview:_gamePoint3];
    }

    if (!_gamePoint1.image) {
        _gamePoint1.image = image1;
        _gamePoint2.image = image2;
        _gamePoint3.image = image3;
    }
    
    [UIView animateWithDuration:0.3 delay:0.3 options:0 animations:^{
        CGRect rect1 = _gamePoint1.frame;
        rect1.origin.x = _gamePoint1.frame.origin.x-7;
        rect1.origin.y = 8;
        _gamePoint1.frame = rect1;
        
        CGRect rect2 = _gamePoint2.frame;
        rect2.origin.x = _gamePoint2.frame.origin.x-12;
        rect2.origin.y = 9+image1.size.height;
        _gamePoint2.frame = rect2;
        
        CGRect rect3 = _gamePoint3.frame;
        rect3.origin.x = _gamePoint3.frame.origin.x+8;
        rect3.origin.y =  _gamePoint3.frame.origin.y+2;
        _gamePoint3.frame = rect3;
        
        _gamePoint1.alpha = 1.0f;
        _gamePoint2.alpha = 1.0f;
        _gamePoint3.alpha = 1.0f;
        
    } completion:^(BOOL finished) {
    }];
}


#pragma mark - 图库按钮的开始 动画

- (void)thirdItemAnimation
{
    UIImage *image1 = [UIImage imageNamed:@"photoAnimation1"];
    UIImage *image2 = [UIImage imageNamed:@"photoAnimation2"];
    if (!_photoAnima1) {
        _photoAnima1 = [[UIImageView alloc]initWithFrame:CGRectMake(self.customImgv.frame.origin.x-5, 2, image1.size.width, image1.size.height)];
        _photoAnima1.alpha = 0.0f;
        _photoAnima1.image = image1;
        [self addSubview:_photoAnima1];
        _photoAnima1.transform = CGAffineTransformMakeRotation(30 *M_PI/180);
        
        _photoAnima2 = [[UIImageView alloc]initWithFrame:CGRectMake(self.customImgv.frame.origin.x-3.5,3.5, image2.size.width, image2.size.height)];
        _photoAnima2.alpha = 0.0f;
        _photoAnima2.image = image2;
        [self addSubview:_photoAnima2];
        _photoAnima1.transform = CGAffineTransformMakeRotation(45 *M_PI/180);
    }
    
    if (!_photoAnima1.image) {
        _photoAnima1.image = image1;
        _photoAnima2.image = image2;
    }
    
    [UIView animateWithDuration:0.07 delay:0.25 options:0 animations:^{
        _photoAnima2.transform = CGAffineTransformMakeRotation(0);
        _photoAnima2.alpha = 1.0f;
//        _photoAnima1.transform = CGAffineTransformMakeRotation(0);
//        _photoAnima1.alpha = 1.0f;
//        _photoAnima1.transform = _photoAnima2.transform ;
    } completion:^(BOOL finished) {
          [UIView animateWithDuration:0.03 animations:^{
              _photoAnima1.transform = CGAffineTransformMakeRotation(0);
              _photoAnima1.alpha = 1.0f;
          }];
    }];
}

#pragma mark - 通讯录按钮的开始动画

- (void)fourthItemAnimation
{
    CGFloat W;
    CGFloat H;
    UIImage *image1 = [UIImage imageNamed:@"bookAnimation1"];
    UIImage *image2 = [UIImage imageNamed:@"bookAnimation2"];
    W = image2.size.width;
    H = image2.size.height;
    if (!_bookAnima1) {
        _bookAnima1 = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width - image1.size.width)/2, (self.frame.size.height - image1.size.height)/2, image1.size.width, image1.size.height)];
        _bookAnima1.alpha = 0.0f;
        _bookAnima1.image = image1;
        [self addSubview:_bookAnima1];
        
        _bookAnima2 = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width - image2.size.width)/2, (self.frame.size.height - image2.size.height)/2, 0, 0)];
        _bookAnima2.image = image2;
        _bookAnima2.alpha = 0.0f;
        [self addSubview:_bookAnima2];
    }
    
    if (!_bookAnima1.image) {
        _bookAnima1.image = image1;
        _bookAnima2.image = image2;
    }
    
    [UIView animateWithDuration:0.2 delay:0.2 options:0 animations:^{
       self.customImgv.transform = CGAffineTransformMakeRotation(M_PI/2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = _bookAnima1.frame;
            rect.origin.x = (self.frame.size.width - self.customImgv.frame.size.height)/2 -_bookAnima1.frame.size.width+1;
            rect.origin.y = 7;
            _bookAnima1.frame = rect;
            _bookAnima1.alpha = 1.0f;
            
            CGRect rect1 = _bookAnima2.frame;
            rect1.origin.x = (self.frame.size.width - self.customImgv.frame.size.height)/2 + self.customImgv.frame.size.height/2 +13;
            rect1.origin.y = 7;
            rect1.size = CGSizeMake(W, H);
            _bookAnima2.frame = rect1;
            _bookAnima2.alpha = 1.0f;
            
        } completion:nil];
    }];
    
}


#pragma mark - 结束动画
/**
 *  结束动画
 */
- (void)stopMyAnimationAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            [self item1StopAnimation];
            break;
        case 1:
            [self secontStopAnimation];
            break;
        case 2:
            [self thirdItemStopAnimation];
            break;
        case 3:
            [self fourthItemStopAnimation];
            break;
            
        default:
            break;
    }
    
}

#pragma mark - 地图按钮的 结束动画
- (void)item1StopAnimation
{
    UIImage *image1 = [UIImage imageNamed:@"mapAnimation1_nor"];
    UIImage *image2 = [UIImage imageNamed:@"mapAnimation2_nor"];
    _mapLine2.image = image2;
    _mapLine1.image = image1;
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = _mapLine2.frame;
        rect.size.width = 0;
        _mapLine2.frame = rect;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            CGRect rect = _mapLine1.frame;
            rect.size.width = 0;
            _mapLine1.frame = rect;
        }completion:^(BOOL finished) {
            _mapLine1.image = nil;
            _mapLine2.image = nil;
            [UIView animateWithDuration:0.3 delay:0.1 options:0 animations:^{
                CGRect rect = self.customImgv.frame;
                rect.origin.y = 7;
                self.customImgv.frame = rect;
            } completion:^(BOOL finished) {
            }];
        }];
    }];
}


#pragma mark - 游戏按钮的 结束动画

- (void)secontStopAnimation
{
    UIImage *image1 = [UIImage imageNamed:@"gameAnimation1_nor"];
    UIImage *image2 = [UIImage imageNamed:@"gameAnimation2_nor"];
    UIImage *image3 = [UIImage imageNamed:@"gameAnimation3_nor"];
    _gamePoint1.image = image1;
    _gamePoint2.image = image2;
    _gamePoint3.image = image3;
    
    [UIView animateWithDuration:0.3 delay:0.2 options:0 animations:^{
        CGRect rect1 = _gamePoint1.frame;
        rect1.origin.x = (self.frame.size.width - image1.size.width)/2;
        rect1.origin.y = (self.frame.size.height - image1.size.height)/2;
        _gamePoint1.frame = rect1;
        
        CGRect rect2 = _gamePoint2.frame;
        rect2.origin.x = (self.frame.size.width - image2.size.width)/2;
        rect2.origin.y =  (self.frame.size.height - image2.size.height)/2;
        _gamePoint2.frame = rect2;
        
        CGRect rect3 = _gamePoint3.frame;
        rect3.origin.x = (self.frame.size.width - image3.size.width)/2;
        rect3.origin.y = (self.frame.size.height - image3.size.height)/2;
        _gamePoint3.frame = rect3;
        
        _gamePoint1.alpha = 0.0f;
        _gamePoint2.alpha = 0.0f;
        _gamePoint3.alpha =0.0f;
        
    } completion:^(BOOL finished) {
        _gamePoint1.image = nil;
        _gamePoint2.image = nil;
        _gamePoint3.image = nil;
    }];
}

#pragma mark - 图库按钮的结束 动画

- (void)thirdItemStopAnimation
{
    UIImage *image1 = [UIImage imageNamed:@"photoAnimation1_nor"];
    UIImage *image2 = [UIImage imageNamed:@"photoAnimation2_nor"];
    _photoAnima1.image = image1;
    _photoAnima2.image = image2;
    
    [UIView animateWithDuration:0.03 delay:0.25 options:0 animations:^{
        _photoAnima1.alpha = 0.0f;
        _photoAnima1.transform = CGAffineTransformMakeRotation(30 *M_PI/180);
    } completion:^(BOOL finished) {//
        _photoAnima1.image = nil;
        [UIView animateWithDuration:0.07 animations:^{
            _photoAnima2.alpha = 0.0f;
            _photoAnima2.transform = CGAffineTransformMakeRotation(45 *M_PI/180);
        }completion:^(BOOL finished) {
            _photoAnima2.image = nil;
        }];
    }];
}


#pragma mark - 通讯录按钮的 结束动画

- (void)fourthItemStopAnimation
{
    UIImage *image1 = [UIImage imageNamed:@"bookAnimation1_nor"];
    UIImage *image2 = [UIImage imageNamed:@"bookAnimation2_nor"];
    _bookAnima1.image = image1;
    _bookAnima2.image = image2;
    [UIView animateWithDuration:0.3 delay:0.15 options:0 animations:^{
        CGRect rect = _bookAnima1.frame;
        rect.origin.x = (self.frame.size.width - image1.size.width)/2;
        rect.origin.y = (self.frame.size.height - image1.size.height)/2;
        _bookAnima1.frame = rect;
        _bookAnima1.alpha = 0.0f;
        
        CGRect rect1 = _bookAnima2.frame;
        rect1.origin.x = (self.frame.size.width - image2.size.width)/2;
        rect1.origin.y = (self.frame.size.height - image2.size.height)/2;
        rect1.size = CGSizeMake(0, 0);
        _bookAnima2.frame = rect1;
        _bookAnima2.alpha = 0.0f;
        
        self.customImgv.transform = CGAffineTransformMakeRotation(0);
    } completion:^(BOOL finished) {
        _bookAnima1.image = nil;
        _bookAnima2.image = nil;
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
