//
//  HttpManager.m
//  41_付云磊
//
//  Created by qianfeng on 15/8/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HttpManager.h"

@implementation HttpManager

//设置单例管理对象
+(HttpManager *)shareManager
{
    static HttpManager *manager = nil;
    
    static dispatch_once_t once;
    
    dispatch_once(&once,^
                  {
                      
                      manager=[[HttpManager alloc]init];
                      
                  });
    
    return manager;
}

-(void)requestWithUrl:(NSString *)url WithSuccess:(sucessBlock)sucBlock WithfFailure:(faileBloce)failBlock isAuto:(BOOL)isAuto
{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    if (!isAuto) {
        manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    }else
    {
        manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/text",nil];
    }
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         sucBlock(operation,responseObject);
         
     }
     
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"error=%@",error);
         failBlock(operation,error);
         
     }];
}

@end
