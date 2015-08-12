//
//  HttpManager.h
//  41_付云磊
//
//  Created by qianfeng on 15/8/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^sucessBlock)(AFHTTPRequestOperation *operation, id responseObject);

typedef void (^faileBloce)(AFHTTPRequestOperation *operation, NSError *error);

@interface HttpManager : NSObject

+(HttpManager *)shareManager;

-(void)requestWithUrl:(NSString *)url WithSuccess:(sucessBlock)sucBlock WithfFailure:(faileBloce)failBlock isAuto:(BOOL)isAuto;
@end
