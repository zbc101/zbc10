//
//  urlString.h
//  41_付云磊
//
//  Created by qianfeng on 15/8/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#ifndef _1_____urlString_h
#define _1_____urlString_h
//一、首页(需要实现下拉刷新和上拉加载更多)
//网址:
//1、广告
//http://api.ipadown.com/iphone-client/ad.flash.php?count=5&device=iphone
//2、列表
//http://api.ipadown.com/iphone-client/apps.list.php?t=index&count=%ld&page=%ld&device=iPhone&price=all

//其中page表示当前页数，count表示每页请求几条数据

#define MYADURL @"http://api.ipadown.com/iphone-client/ad.flash.php?count=5&device=iphone"
#define MYMAINAPPURL @"http://api.ipadown.com/iphone-client/apps.list.php?t=index&count=%ld&page=%ld&device=iPhone&price=all"

//1、今日限免
//http://api.ipadown.com/iphone-client/apps.list.php?device=iPhone&price=pricedrop&count=%ld&page=%ld

//2、本周热门限免
//http://api.ipadown.com/iphone-client/apps.list.php?device=iPhone&price=pricedrop&subday=7&orderby=views&count=%ld&page=%ld
//3、热门限免总榜
//http://api.ipadown.com/iphone-client/apps.list.php?device=iPhone&price=pricedrop&orderby=views&count=%ld&page=%ld

#define MYLIMITURL1 @"http://api.ipadown.com/iphone-client/apps.list.php?device=iPhone&price=pricedrop&count=%ld&page=%ld"
#define MYLIMITURL2 @"http://api.ipadown.com/iphone-client/apps.list.php?device=iPhone&price=pricedrop&subday=7&orderby=views&count=%ld&page=%ld"
#define MYLIMITURL3 @"http://api.ipadown.com/iphone-client/apps.list.php?device=iPhone&price=pricedrop&orderby=views&count=%ld&page=%ld"

//1、分类列表
//http://api.ipadown.com/iphone-client/category.list.php
//分类进入的具体类型列表
//http://api.ipadown.com/iphone-client/apps.list.php?cateid=6002&count=10&page=1&device=iPhone&price=all
//3、具体类型界面的筛选
//http://api.ipadown.com/iphone-client/apps.list.php?cateid=6002&count=10&page=1&device=iPhone&price=%@
//
//price=all:全部
//price=free:免费
//price=pricedrop:限免
//price=paid:付费
#define MYCATEGORYURL @"http://api.ipadown.com/iphone-client/category.list.php"
#define MYCATEGORYURL2 @"http://api.ipadown.com/iphone-client/apps.list.php?%@&count=10&page=%li&device=iPhone&price=all"

//2、每日一荐(需要实现下拉刷新和上拉加载更多)
//http://api.ipadown.com/iphone-client/apps.list.php?t=commend&count=%ld&page=%ld&device=iPhone&price=all

#define MYRECOMMENDURL @"http://api.ipadown.com/iphone-client/apps.list.php?t=commend&count=%ld&page=%ld&device=iPhone&price=all"

#endif
