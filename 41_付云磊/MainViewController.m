//
//  MainViewController.m
//  41_付云磊
//
//  Created by qianfeng on 15/8/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MainViewController.h"
#import "AdCell.h"
#import "urlString.h"
#import "HttpManager.h"
#import "MJRefresh.h"
#import "MainCell.h"

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>
{
    //表视图
    UITableView *_tableView;
    //广告数据源
    NSMutableArray *_adArray;
    //app数据源
    NSMutableArray *_appArray;
    //刷新状态
    BOOL _isRefresh;
    //页数
    NSInteger _page;
    //刷新
    MJRefreshFooterView *_footerView;
    MJRefreshHeaderView *_headerView;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    _adArray = [NSMutableArray array];
    _appArray = [NSMutableArray array];
    _page = 1;
    [self createAdArray];
}

- (void)createUI
{
    self.navigationItem.title = @"精品限时免费";
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375, 667-64-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _footerView = [[MJRefreshFooterView alloc] initWithScrollView:_tableView];
    _footerView.delegate = self;
    _headerView = [[MJRefreshHeaderView alloc] initWithScrollView:_tableView];
    _headerView.delegate = self;
}

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (_isRefresh) {
        return;
    }
    if (refreshView == _headerView)
    {
        _page = 1;
        [self createAppData];
        
    }else if (refreshView == _footerView)
    {
        _page++;
        [self createAppData];
    }
}
//创建广告数据源
- (void)createAdArray
{
    _isRefresh = YES;
    
    NSString *urlStr = [NSString stringWithFormat:MYADURL];
    
    [[HttpManager shareManager] requestWithUrl:urlStr WithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([result isKindOfClass:[NSArray class]]) {
            
            for (NSDictionary *dict in result) {
                AdModel *model = [[AdModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [_adArray addObject:model];
            }
            [self createUI];
            [self createAppData];
            
            _isRefresh = NO;
        }
        
    } WithfFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
    } isAuto:NO];
}
- (void)createAppData
{
    _isRefresh = YES;
    if (_page == 1) {
        [_appArray removeAllObjects];
    }
    
    NSString *urlStr = [NSString stringWithFormat:MYMAINAPPURL,(NSInteger)10,_page];
    
    [[HttpManager shareManager] requestWithUrl:urlStr WithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([result isKindOfClass:[NSArray class]]) {
            
            for (NSDictionary *dict in result) {
                MainModel *model = [[MainModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [_appArray addObject:model];
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
    return _appArray.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        static NSString *adCellId = @"adCell";
        AdCell *cell =[tableView dequeueReusableCellWithIdentifier:adCellId];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"AdCell" owner:nil options:nil] lastObject];
        }
        cell.array = _adArray;
        return cell;
    }
    else
    {
        static NSString *appCellId = @"mainCell";
        MainCell *cell = [tableView dequeueReusableCellWithIdentifier:appCellId];
        if (!cell) {
            cell = [[MainCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:appCellId];
        }
        if (_appArray.count) {
            cell.model = [_appArray objectAtIndex:indexPath.row-1];
        }
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 140;
    }
    else
    {
        return 100;
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
