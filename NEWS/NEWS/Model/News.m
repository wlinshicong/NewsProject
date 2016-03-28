//
//  News.m
//  demo2_自定义单元格
//
//  Created by tarena006 on 16/2/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "News.h"
@implementation News
+(instancetype)parseNewsJSON:(NSDictionary *)dict{
    News *news=[[self alloc]init];
    news.ctime=dict[@"ctime"];
    news.title=dict[@"title"];
    news.newsDescription=dict[@"description"];
    news.picUrl=dict[@"picUrl"];
    news.url=dict[@"url"];
    return news;
}
@end
