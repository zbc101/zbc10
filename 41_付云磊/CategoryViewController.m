//
//  CategoryViewController.m
//  41_付云磊
//
//  Created by qianfeng on 15/8/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CategoryViewController.h"
#import "urlString.h"
#import "HttpManager.h"
#import "MJRefresh.h"
#import "MainCell.h"
#import "MyUtil.h"

@interface CategoryViewController ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>
{
    //表视图
    UITableView *_tableView;
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

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    _appArray = [NSMutableArray array];
    _page = 1;
    [self createUI];
    [self createAppData];
}

- (void)createUI
{
    //按钮
    UIButton *leftButton = [MyUtil createBtnFrame:CGRectMake(0, 0, 60, 36) title:@"返回" bgImageName:@"backButton" target:self action:@selector(buttonClicked:)];
    leftButton.tag = 200;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightButton = [MyUtil createBtnFrame:CGRectMake(0, 0, 60, 36) title:@"筛选" bgImageName:@"navButton" target:self action:@selector(buttonClicked:)];
    rightButton.tag = 201;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.navigationItem.title = _titleStr;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375, 667-64-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _footerView = [[MJRefreshFooterView alloc] initWithScrollView:_tableView];
    _footerView.delegate = self;
    _headerView = [[MJRefreshHeaderView alloc] initWithScrollView:_tableView];
    _headerView.delegate = self;
}
- (void)buttonClicked:(UIButton *)button
{
    if (button.tag == 200)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (button.tag == 201)
    {
        NSLog(@"hello");
    }
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
- (void)createAppData
{
    _isRefresh = YES;
    if (_page == 1) {
        [_appArray removeAllObjects];
    }
    
    NSString *urlStr = [NSString stringWithFormat:MYCATEGORYURL2,_cateid,_page];
    
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
    return _appArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
        static NSString *appCellId = @"cateCell";
        MainCell *cell = [tableView dequeueReusableCellWithIdentifier:appCellId];
        if (!cell) {
            cell = [[MainCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:appCellId];
        }
        if (_appArray.count) {
            cell.model = [_appArray objectAtIndex:indexPath.row];
        }
        return cell;
 
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 100;
}

- (void)dealloc
{
    _headerView.scrollView = nil;
    _footerView.scrollView = nil;
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
