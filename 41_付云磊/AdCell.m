//
//  AdCell.m
//  41_付云磊
//
//  Created by qianfeng on 15/8/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AdCell.h"
#import "UIImageView+WebCache.h"
#import "MyUtil.h"

@implementation AdCell

- (void)setArray:(NSArray *)array
{
    _array = array;
    for (NSInteger i = 0; i<array.count; i++) {
        //获取模型
        AdModel *model = (AdModel *)array[i];
        //图片
        UIImageView *adImageView = [MyUtil createImageViewFrame:CGRectMake(375*i, 0, 375, 140) imageName:nil];
        [adImageView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
        [_myScrollView addSubview:adImageView];
    }
    _myScrollView.contentSize = CGSizeMake(375*array.count, 140);
    _myScrollView.pagingEnabled = YES;
    _myScrollView.delegate = self;
    
    _myPageControl.currentPage = 0;
    _myPageControl.numberOfPages = array.count;
    
    _titleLabel.text = [[array objectAtIndex:0] title];
}

//分页使能, 该方法一定被执行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index =  _myScrollView.contentOffset.x/375;
    _myPageControl.currentPage = index;
    _titleLabel.text = [[_array objectAtIndex:index] title];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
