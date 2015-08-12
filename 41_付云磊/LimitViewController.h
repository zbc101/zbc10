//
//  LimitViewController.h
//  41_付云磊
//
//  Created by qianfeng on 15/8/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    limitToday,
    limitWeak,
    limitAll,
}type;

typedef struct
{
    NSInteger page1;
    NSInteger page2;
    NSInteger page3;
}page;
@interface LimitViewController : UIViewController

@property (nonatomic,assign)type type;
@property (nonatomic,assign)page page;

@end
