//
//  RecommendViewController.m
//  41_付云磊
//
//  Created by qianfeng on 15/8/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "RecommendViewController.h"
#import "MyUtil.h"
#import "HotViewController.h"


@interface RecommendViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_myScrollView;
    UIPageControl *_myPageControl;
}
@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self createUI];
}

- (void)createUI
{
    self.navigationItem.title = @"精品栏目推荐";
    self.automaticallyAdjustsScrollViewInsets = NO;
    _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 375, 667-64)];
    [self.view addSubview:_myScrollView];
    
    NSArray *titleArray = @[@"每日一荐",@"本周热门应用",@"本周热门游戏",@"上榜精品",@"GameCenter游戏",@"装机必备",@"知名网站客户端",@"五星好评应用",@"随便看看",@"i派党移动版",@"苹果新闻",@"iPhone4壁纸",@"用户交流QQ群",@"i派党移动微博"];
    NSArray *imageNameArray = @[@"i-commend",@"i-soft",@"i-game",@"i-top",@"i-gamecenter",@"i-musthave",@"i-famous",@"i-star",@"i-random",@"i-ipadown",@"i-news",@"i-download",@"i-qqgroup",@"i-sinaweibo"];
    //循环创建按钮
    CGFloat w = 80;
    CGFloat h = 90;
    CGFloat spaceX = 40;
    CGFloat spaceY = 40;
    for (int i = 0; i<titleArray.count; i++) {
        //第几页
        int page = i/12;
        int rowAndCol = i%12;
        //行
        int row = rowAndCol/3;
        //列
        int col = rowAndCol%3;
        //按钮
        CGRect frame1 = CGRectMake(spaceX+(spaceX+w)*col+page*375, spaceY+(spaceY+h)*row, w, h-20);
        CGRect frame2 = CGRectMake(spaceX+(spaceX+w)*col+page*375, spaceY+(spaceY+h)*row+h-20, w, 20);
        UIButton *button = [MyUtil createBtnFrame:frame1 title:nil bgImageName:imageNameArray[i] target:self action:@selector(clickBtn:)];
        UILabel *label = [MyUtil createLabelFrame:frame2 title:titleArray[i] font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentCenter numberOfLines:1 textColor:[UIColor greenColor]];
        //添加点击事件
        button.tag = 300+i;
       
        [_myScrollView addSubview:button];
        [_myScrollView addSubview:label];
    }
    //设置滚动范围
    NSInteger cnt = titleArray.count/12;
    if (titleArray.count%12>0) {
        cnt++;
    }
    _myPageControl.numberOfPages = cnt;
    [self.view addSubview:_myPageControl];
    _myScrollView.pagingEnabled = YES;
    _myScrollView.contentSize = CGSizeMake(375*cnt, _myScrollView.bounds.size.height);
    _myScrollView.delegate = self;
}

- (void)clickBtn:(UIButton *)button
{
    if (button.tag == 300) {
        HotViewController *hvc = [HotViewController new];
        [self.navigationController pushViewController:hvc animated:YES];
    }
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
