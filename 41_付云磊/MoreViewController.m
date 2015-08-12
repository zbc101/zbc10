//
//  MoreViewController.m
//  41_付云磊
//
//  Created by qianfeng on 15/8/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MoreViewController.h"
#import "MyUtil.h"

@interface MoreViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIScrollView *_myScrollView;
    UITableView *_moreTableView;
    UITableView *_setTableView;
    NSArray *_moreTitleArray;
    NSArray *_moreImageNameArray;
    NSArray *_setTitleArray;
}
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor grayColor];
    // Do any additional setup after loading the view.
    _moreTitleArray = @[@"排行榜单",@"应用专题",@"精品导购",@"苹果学院"];
    _moreImageNameArray = @[@"c-top",@"c-zt",@"c-guide",@"c-jc"];
    _setTitleArray = @[@"我收藏的Apps",@"清空本地缓存",@"开启或关闭推送"];
    [self createUI];
}

- (void)createUI
{

    self.navigationItem.title = @"关于i派党";
    _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 375, 667-64)];
    _myScrollView.userInteractionEnabled = YES;
    [self.view addSubview:_myScrollView];
    _myScrollView.contentSize = CGSizeMake(375, 750);

     UIImageView *imageView = [MyUtil createImageViewFrame:CGRectMake(10, 20, 355, 100) imageName:@"logo_empty"];
    [_myScrollView addSubview:imageView];
    
    //表格视图
    _moreTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 150, 355, 300) style:UITableViewStylePlain];
    _moreTableView.dataSource = self;
    _moreTableView.delegate = self;
    _moreTableView.backgroundView.backgroundColor = [UIColor whiteColor];
    [_myScrollView addSubview:_moreTableView];
    
    //表格视图
    _setTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 490, 355, 225) style:UITableViewStylePlain];
    _setTableView.dataSource = self;
    _setTableView.delegate = self;
    _setTableView.backgroundView.backgroundColor = [UIColor whiteColor];
    [_myScrollView addSubview:_setTableView];
    
    for (NSInteger i = 0; i<2; i++) {
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(20, 110+i*350, 100, 30) title:i?@"更多栏目":@"客户端设置" font:[UIFont systemFontOfSize:16]];
        [_myScrollView addSubview:label];
    }
}
#pragma mark  ---UITableViewDataSource---

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_moreTableView) {
        return _moreTitleArray.count;
    }
    return _setTitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_moreTableView) {
        static NSString *appCellId = @"moreCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:appCellId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:appCellId];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = _moreTitleArray[indexPath.row];
//        cell.detailTextLabel.text = @"hello world";
        cell.imageView.image = [UIImage imageNamed:_moreImageNameArray[indexPath.row]];
        return cell;
    }
    else if(tableView==_setTableView)
    {
         static NSString *appCellId = @"setCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:appCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:appCellId];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _setTitleArray[indexPath.row];
    return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

////设置分区头标题
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (tableView == _moreTableView) {
//        return @"更多栏目";
//    }
//    return @"客户端设置";
//}

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
