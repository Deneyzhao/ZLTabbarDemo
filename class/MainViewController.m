//
//  MainViewController.m
//  ZLTabbarDemo
//
//  Created by Deney on 9/5/16.
//  Copyright © 2016年 Brandsh. All rights reserved.
//

#import "MainViewController.h"

#import "Home.h"
#import "Games.h"
#import "Pictures.h"
#import "AddressBook.h"

#import "ZLTabBar.h"

@interface MainViewController () <UIPageViewControllerDataSource,UIPageViewControllerDelegate>
{
    NSInteger _currentPage;
    ZLTabBar *_zlTab;
}
@property(nonatomic,strong)NSArray *myViewControllers;
@property(nonatomic,strong)UIPageViewController *pageViewController;


@end



@implementation MainViewController
@synthesize pageViewController = myPageViewController;

- (NSArray *)myViewControllers
{
    if (!_myViewControllers) {
        Home *home = [[Home alloc]init];
        home.title = @"首页";
        UINavigationController *navi1 = [[UINavigationController alloc]initWithRootViewController:home];
        
        Games *game = [[Games alloc]init];
        game.title = @"游戏";
        UINavigationController *navi2 = [[UINavigationController alloc]initWithRootViewController:game];
        
        Pictures *pictures = [[Pictures alloc]init];
        pictures.title = @"图库";
        UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:pictures];
        
        AddressBook *book = [[AddressBook alloc]init];
        book.title = @"通讯录";
        UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:book];
        _myViewControllers = @[navi1,navi2,nav3,nav4];
        
    }
    return _myViewControllers;
}

#pragma mark - 按钮切换
-(void)setViewController:(NSInteger)index animation:(BOOL)animation
{
    if (index==0) {
        [myPageViewController setViewControllers:@[self.myViewControllers[0]] direction:index<_currentPage animated:animation completion:nil];
    }
    else
    {
        [myPageViewController setViewControllers:@[self.myViewControllers[index<_currentPage?index+1:index-1]] direction:index<_currentPage animated:animation completion:^(BOOL finished) {
        }];
        [myPageViewController setViewControllers:@[self.myViewControllers[index]] direction:index<_currentPage animated:animation completion:^(BOOL finished) {
        }];
    }
    _currentPage = index;
}

#pragma mark - UIPageViewControllerDataSource

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    return nil;
}


- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    return nil;
}


#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    ViewController *vc =(ViewController *)pageViewController.viewControllers[0];
    _currentPage = vc.pageIndex;
}


#pragma mark - 自定义的标签栏
- (void)initMyCustomTabBar
{
    _zlTab = [[ZLTabBar alloc]init];
    [_zlTab setTabBarWithItemsCount:4];
    [self.view addSubview:_zlTab];
    __weak id weakSelf = self;
    //按钮 点击 回调
    [_zlTab setBtnSelectBlock:^(NSInteger index) {
        [weakSelf setViewController:index animation:YES];
    }];
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    Home *home = [[Home alloc]init];
    home.title = @"首页";
    UINavigationController *nav=  [[UINavigationController alloc]initWithRootViewController:home];
    myPageViewController = [[UIPageViewController alloc]initWithTransitionStyle:1 navigationOrientation:0 options:nil];
    [myPageViewController setViewControllers:@[nav] direction:0 animated:NO completion:nil];
    [self.view addSubview:myPageViewController.view];
    myPageViewController.delegate = self;
    
    [self initMyCustomTabBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
