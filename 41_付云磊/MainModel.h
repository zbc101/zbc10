//
//  MainModel.h
//  41_付云磊
//
//  Created by qianfeng on 15/8/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "JSONModel.h"

@interface MainModel : JSONModel

@property (nonatomic,strong)NSString<Optional> *myID;
@property (nonatomic,strong)NSString<Optional> *post_title;
@property (nonatomic,strong)NSString<Optional> *post_stitle;
@property (nonatomic,strong)NSString<Optional> *app_name;
@property (nonatomic,strong)NSString<Optional> *post_date;
@property (nonatomic,strong)NSString<Optional> *app_id;
@property (nonatomic,strong)NSString<Optional> *app_category;
@property (nonatomic,strong)NSString<Optional> *app_device;
@property (nonatomic,strong)NSString<Optional> *app_icon;
@property (nonatomic,strong)NSString<Optional> *app_size;
@property (nonatomic,strong)NSString<Optional> *app_price;
@property (nonatomic,strong)NSString<Optional> *app_pricedrop;
@property (nonatomic,strong)NSString<Optional> *app_top;
@property (nonatomic,strong)NSString<Optional> *app_apple_rated;
@property (nonatomic,strong)NSString<Optional> *app_desc;

@end
