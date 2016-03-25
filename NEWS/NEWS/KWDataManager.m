//
//  KWDataManager.m
//  weather
//
//  Created by tarena006 on 16/3/23.
//  Copyright © 2016年 Kerwin. All rights reserved.
//

#import "KWDataManager.h"
#import "News.h"

@implementation KWDataManager

+(NSMutableArray *)getAllNewsData:(id)responseObject{
    NSArray *NewsArray=responseObject[@"newslist"];
    
    NSMutableArray *array=[@[]mutableCopy];
    
    for (NSDictionary *dict in NewsArray) {
        News *news=[News parseNewsJSON:dict];
        [array addObject:news];
    }
    return array;
}

@end
