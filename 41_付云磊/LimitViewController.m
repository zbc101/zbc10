//
//  LimitViewController.m
//  41_付云磊
//
//  Created by qianfeng on 15/8/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LimitViewController.h"
#import "urlString.h"
#import "HttpManager.h"
#import "MJRefresh.h"
#import "MainCell.h"
#import "MyUtil.h"

@interface LimitViewController ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>
{
    //表视图
    UITableView *_tableView;
    //app数据源
    NSMutableArray *_appArray1;
    NSMutableArray *_appArray2;
    NSMutableArray *_appArray3;
    //刷新状态
    BOOL _isRefresh;
    
    //刷新
    MJRefreshFooterView *_footerView;
    MJRefreshHeaderView *_headerView;
}
@end

@implementation LimitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    _appArray1 = [NSMutableArray array];
    _appArray2 = [NSMutableArray array];
    _appArray3 = [NSMutableArray array];
    _page.page1 = 1;
    _page.page2 = 1;
    _page.page3 = 1;
    self.type = limitToday;
    [self createUI];
}

- (void)createUI
{
    NSMutableArray *items = [NSMutableArray array];
    NSArray *titleArray = @[@"今日限免",@"本周热门限免",@"热门限免总榜"];
    for (NSInteger i = 0; i<3; i++) {
        UIButton *button = [MyUtil createBtnFrame:CGRectMake(20+100*i, 4, 100, 36) title:titleArray[i] bgImageName:@"navButton" target:self action:@selector(clickBtn:)];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.tag = 300+i;
        UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        [items addObject:btnItem];
    }
    self.navigationItem.leftBarButtonItems = items;
    
    self.navigationController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%i",arc4random()%200+1];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375, 667-64-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _footerView = [[MJRefreshFooterView alloc] initWithScrollView:_tableView];
    _footerView.delegate = self;
    _headerView = [[MJRefreshHeaderView alloc] initWithScrollView:_tableView];
    _headerView.delegate = self;
    [self createAppData];
}

- (void)clickBtn:(UIButton *)button
{
    if (button.tag==300)
    {
        _type = limitToday;
        if (!_appArray1.count) {
            [self createAppData];
        }
    }
    else if (button.tag==301)
    {
        _type = limitWeak;
        if (!_appArray2.count) {
            [self createAppData];
        }
    }
    else if(button.tag==302)
    {
        _type = limitAll;
        if (!_appArray3.count) {
            [self createAppData];
        }
    }
    [_tableView reloadData];
    
}
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (_isRefresh)
    {
        return;
    }
    
    if (_type == limitToday)
    {
        if (refreshView == _headerView)
        {
            _page.page1 = 1;
            
        }else if (refreshView == _footerView)
        {
            _page.page1++;
        }
    }
    else if(_type == limitWeak)
    {
        if (refreshView == _headerView)
        {
            _page.page2 = 1;
            
        }else if (refreshView == _footerView)
        {
            _page.page2++;
        }
    }
    else if(_type == limitAll)
    {
        if (refreshView == _headerView)
        {
            _page.page3 = 1;
            
        }else if (refreshView == _footerView)
        {
            _page.page3++;
        }
        
    }
    [self createAppData];
}

- (void)createAppData
{
    _isRefresh = YES;
    
    NSString *urlStr = [NSString string];
    if (_type == limitToday)
    {
        if (_page.page1 == 1)
        {
            [_appArray1 removeAllObjects];
        }
        urlStr = [NSString stringWithFormat:MYLIMITURL1,(NSInteger)10,_page.page1];
    }
    else if(_type == limitWeak)
    {
        if (_page.page2 == 1)
        {
            [_appArray2 removeAllObjects];
        }
        urlStr = [NSString stringWithFormat:MYLIMITURL2,(NSInteger)10,_page.page2];
    }
    else if(_type == limitAll)
    {
        if (_page.page3 == 1)
        {
            [_appArray3 removeAllObjects];
        }
        urlStr = [NSString stringWithFormat:MYLIMITURL3,(NSInteger)10,_page.page3];
    }
    
    [[HttpManager shareManager] requestWithUrl:urlStr WithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([result isKindOfClass:[NSArray class]]) {
            
            for (NSDictionary *dict in result) {
                MainModel *model = [[MainModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                if (_type==limitToday) {
                    [_appArray1 addObject:model];
                }
                else if (_type==limitWeak) {
                    [_appArray2 addObject:model];
                }
                else if (_type==limitAll) {
                    [_appArray3 addObject:model];
                }
            }
            [_tableView reloadData];
            _isRefresh = NO;
            [_headerView endRefreshing];
            [_footerView endRefreshing];
            
        }
        
    } WithfFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
    } isAuto:NO];
}

#pragma mark  ---UITableViewDataSource---

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_type==limitToday) {
        return _appArray1.count;
    }
    else if (_type==limitWeak) {
        return _appArray2.count;
    }
    else {
        return _appArray3.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *appCellId = @"limitCell";
    MainCell *cell = [tableView dequeueReusableCellWithIdentifier:appCellId];
    if (!cell) {
        cell = [[MainCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:appCellId];
    }
    if (_type==limitToday) {
        cell.model2 = [_appArray1 objectAtIndex:indexPath.row];
    }
    else if (_type==limitWeak) {
        cell.model2 = [_appArray2 objectAtIndex:indexPath.row];
    }
    else {
        cell.model2 = [_appArray3 objectAtIndex:indexPath.row];
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100;
    
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
