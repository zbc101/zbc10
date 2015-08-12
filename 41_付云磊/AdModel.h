//
//  AdModel.h
//  41_付云磊
//
//  Created by qianfeng on 15/8/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "JSONModel.h"

@interface AdModel : JSONModel

@property (nonatomic,strong)NSString<Optional> *type;
@property (nonatomic,strong)NSString<Optional> *pic;
@property (nonatomic,strong)NSString<Optional> *myGoto;
@property (nonatomic,strong)NSString<Optional> *title;

@end
