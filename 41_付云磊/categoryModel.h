//
//  categoryModel.h
//  41_付云磊
//
//  Created by qianfeng on 15/8/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface listModel : NSObject

@property (nonatomic,strong)NSString *desc;
@property (nonatomic,strong)NSString *icon;
@property (nonatomic,strong)NSString *querystr;
@property (nonatomic,strong)NSString *title;

@end


@interface categoryModel : NSObject

@property (nonatomic,strong)NSString *header;
@property (nonatomic,strong)NSArray *list;

@end

