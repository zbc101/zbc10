//
//  MainModel.m
//  41_付云磊
//
//  Created by qianfeng on 15/8/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MainModel.h"

@implementation MainModel


+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"ID":@"myID"}];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
