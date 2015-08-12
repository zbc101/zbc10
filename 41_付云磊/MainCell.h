//
//  MainCell.h
//  41_付云磊
//
//  Created by qianfeng on 15/8/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainModel.h"

@interface MainCell : UITableViewCell
{
    UILabel *_appNameLabel;     //显示app名字
    UILabel *_appRateLabel;     //评级
    UILabel *_appTypeLabel;     //类型
    UILabel *_appSizeLabel;     //大小
    UILabel *_appDescLabel;     //描述
    UIImageView *_appIcon;      //app图标
    UIImageView *_appSaleType;  //在售状态
    UILabel *_appPriceLabel;    //价格
}
//显示数据
@property (nonatomic,strong)MainModel *model;
//
//显示数据
@property (nonatomic,strong)MainModel *model2;

@end
