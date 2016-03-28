//
//  News.h
//  demo2_自定义单元格
//
//  Created by tarena006 on 16/2/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject
@property (nonatomic, copy) NSString *ctime;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *newsDescription;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, copy) NSString *url;

+(instancetype)parseNewsJSON:(NSDictionary*)dict;

@end
