//
//  AdModel.m
//  41_付云磊
//
//  Created by qianfeng on 15/8/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AdModel.h"

@implementation AdModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"goto":@"myGoto"}];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
