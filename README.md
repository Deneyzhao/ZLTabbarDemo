# ZLTabbarDemo
ZLTabBar.h

 *  设置tabbaritem 的数量

- (void)setTabBarWithItemsCount:(NSInteger)itemsCount;


 
 *  @param itemsCount 按钮数量
 

//按钮 回调
@property(nonatomic,strong)void (^btnSelectBlock)(NSInteger index);
