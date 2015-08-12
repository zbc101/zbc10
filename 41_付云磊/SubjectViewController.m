//
//  SubjectViewController.m
//  41_付云磊
//
//  Created by qianfeng on 15/8/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SubjectViewController.h"
#import "urlString.h"
#import "HttpManager.h"
#import "CategoryCell.h"
#import "CategoryViewController.h"

@interface SubjectViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    //表视图
    UITableView *_tableView;
    //app数据源
    NSMutableArray *_dataArray;
}
@end

@implementation SubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    _dataArray = [NSMutableArray array];
    [self createUI];
    [self createAppData];
}
- (void)createUI
{
    self.navigationItem.title = @"按分类筛选";
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375, 667-64-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
- (void)createAppData
{
    
    NSString *urlStr = [NSString stringWithFormat:MYCATEGORYURL];
    
    [[HttpManager shareManager] requestWithUrl:urlStr WithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([result isKindOfClass:[NSArray class]]) {
            
            for (NSDictionary *dict in result) {
                categoryModel *model = [[categoryModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                
                NSMutableArray *array = [NSMutableArray array];
                for (NSDictionary *listDict in dict[@"list"]) {
                    listModel *lModel = [[listModel alloc] init];
                    [lModel setValuesForKeysWithDictionary:listDict];
                    [array addObject:lModel];
                }
                model.list = [NSArray arrayWithArray:array];
                [_dataArray addObject:model];
            }
            [_tableView reloadData];
        }
        
    } WithfFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
    } isAuto:NO];
}

#pragma mark  ---UITableViewDataSource---

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[_dataArray objectAtIndex:section] list] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *appCellId = @"categoryCell";
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:appCellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CategoryCell" owner:nil options:nil] lastObject];
    }
    if (_dataArray.count) {
        categoryModel *model = [_dataArray objectAtIndex:indexPath.section];
        [cell configModelWithModel:model andRow:indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

//设置分区头标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    categoryModel *model = _dataArray[section];
    
    return model.header;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryViewController *cvc = [[CategoryViewController alloc] init];
    categoryModel *model = _dataArray[indexPath.section];
    NSArray *array = model.list;
    listModel *lModel = [array objectAtIndex:indexPath.row];
    cvc.cateid = lModel.querystr;
    cvc.titleStr = lModel.title;
    [self.navigationController pushViewController:cvc animated:YES];
    
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
