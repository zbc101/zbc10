//
//  CategoryCell.m
//  41_付云磊
//
//  Created by qianfeng on 15/8/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CategoryCell.h"
#import "UIImageView+WebCache.h"


@implementation CategoryCell

- (void)configModelWithModel:(categoryModel *)model andRow:(NSInteger)row
{
    listModel *lModel = [model.list objectAtIndex:row];
//
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:lModel.icon]];
//
    _titleLabel.text = lModel.title;
    _descLabel.text = lModel.desc;

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
