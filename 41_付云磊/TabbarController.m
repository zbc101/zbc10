//
//  TabbarController.m
//  41_付云磊
//
//  Created by qianfeng on 15/8/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "TabbarController.h"

@interface TabbarController ()

@end

@implementation TabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createControllers];
}

//创建视图控制器
- (void)createControllers
{
    //视图控制器类名
    NSArray *ctrlArray = @[@"MainViewController",@"LimitViewController",@"SubjectViewController",@"RecommendViewController",@"MoreViewController"];
    //标题文字
    NSArray *nameArray = @[@"首页",@"今日限免",@"分类",@"推荐",@"更多"];
    //图片
    NSArray *imageArray = @[@"item_app_home",@"item_app_pricedrop",@"item_app_category",@"item_app_hot",@"item_app_myapps"];
    
    //循环创建视图控制器
    NSMutableArray *navArray = [NSMutableArray array];
    for (int i=0; i<ctrlArray.count; i++) {
        //类名
        NSString *className = ctrlArray[i];
        //cls包含类的名字和属性以及方法等内容
        Class cls = NSClassFromString(className);
        //创建视图控制器
        UIViewController *vc = [[cls alloc] init];
        
        //图片
        NSString *imageName = imageArray[i];
        vc.tabBarItem.image = [UIImage imageNamed:imageName];
        
        //标题文字
        NSString *title = nameArray[i];
        vc.tabBarItem.title = title;
        
        //添加导航
        UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:vc];
        [navCtrl.navigationBar setBackgroundImage:[UIImage imageNamed:@"top-bg"] forBarMetrics:UIBarMetricsDefault];
        [navArray addObject:navCtrl];
    }
    self.viewControllers = navArray;
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
