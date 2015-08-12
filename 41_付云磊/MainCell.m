//
//  MainCell.m
//  41_付云磊
//
//  Created by qianfeng on 15/8/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MainCell.h"
#import "UIImageView+WebCache.h"
#import "MyUtil.h"

@implementation MainCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        //appName
        _appNameLabel = [MyUtil createLabelFrame:CGRectMake(80, 10, 200, 30) title:nil font:[UIFont boldSystemFontOfSize:20]];
        _appNameLabel.textAlignment = NSTextAlignmentLeft;
        
        //appRate
        _appRateLabel = [MyUtil createLabelFrame:CGRectMake(80, 44, 60, 20) title:nil font:[UIFont systemFontOfSize:12]];
        
        //appType
        _appTypeLabel = [MyUtil createLabelFrame:CGRectMake(140, 44, 60, 20) title:nil font:[UIFont systemFontOfSize:12]];
        
        //appSize
        _appSizeLabel = [MyUtil createLabelFrame:CGRectMake(200, 44, 60, 20) title:nil font:[UIFont systemFontOfSize:12]];
        
        //appDesc
        _appDescLabel = [MyUtil createLabelFrame:CGRectMake(80, 64, 200, 30) title:nil font:[UIFont systemFontOfSize:16]];
        _appDescLabel.textColor = [UIColor grayColor];
        
        //appIcon
        _appIcon = [MyUtil createImageViewFrame:CGRectMake(10, 20, 60, 60) imageName:nil];
        
        //appSaleType
        _appSaleType = [MyUtil createImageViewFrame:CGRectMake(290, 44, 80, 44) imageName:nil];
        
        //appPriceLabel
        _appPriceLabel = [MyUtil createLabelFrame:CGRectMake(0, 0, 80, 44) title:nil font:nil];
        _appPriceLabel.backgroundColor = [UIColor clearColor];
        _appPriceLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return self;
}
- (void)setModel2:(MainModel *)model2
{
    [self setModel:model2];
    //appSaleType
    _appSaleType.frame = CGRectMake(290, 24, 80, 64);
        _appSaleType.image = [UIImage imageNamed:@"pricedrop-free"];
        _appPriceLabel.text = @"";
}
- (void)setModel:(MainModel *)model
{
    
    [self.contentView addSubview:_appNameLabel];
    
    [self.contentView addSubview:_appRateLabel];
    
    [self.contentView addSubview:_appTypeLabel];
    
    [self.contentView addSubview:_appSizeLabel];
    
    [self.contentView addSubview:_appDescLabel];
    
    
    //name
    _appNameLabel.text = model.app_name;
    
    //appRate
    _appRateLabel.text = [NSString stringWithFormat:@"评级:%@星",model.app_apple_rated];
    
    //appType
    _appTypeLabel.text = model.post_stitle;
    
    //appSize
    _appSizeLabel.text = model.app_size;
    
    //appDesc
    _appDescLabel.text = model.app_desc;
    
    //icon
    _appIcon.layer.cornerRadius = 10;
    _appIcon.layer.masksToBounds = YES;
    [_appIcon sd_setImageWithURL:[NSURL URLWithString:model.app_icon] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    [self.contentView addSubview:_appIcon];
    
    //appSaleType
    if ([model.app_price isEqualToString:@"1"]) {
        _appSaleType.image = [UIImage imageNamed:@"price-bg"];
        _appPriceLabel.text = @"免费中";
    }else if ([model.app_pricedrop isEqualToString:@"1"])
    {
        _appSaleType.image = [UIImage imageNamed:@"price-bg"];
        _appPriceLabel.text = @"降价中";
    }else
    {
        _appSaleType.image = [UIImage imageNamed:@"price-bg-lan"];
        _appPriceLabel.text = [NSString stringWithFormat:@"￥:%@元",model.app_price];
    }
    [self.contentView addSubview:_appSaleType];
    [_appSaleType addSubview:_appPriceLabel];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
