//
//  TableViewCell.h
//  API调用
//
//  Created by tarena05 on 16/3/17.
//  Copyright © 2016年 tarena05. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property(nonatomic,copy)NSString *channelId;
@property(nonatomic,copy)NSString *channelName;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,copy)NSString *imageurls;
@property(nonatomic,copy)NSString *link;
@property(nonatomic,copy)NSString *nid;
@property(nonatomic,copy)NSString *pubDate;
@property(nonatomic,copy)NSString *source;
@property(nonatomic,copy)NSString *title;

-(instancetype)initWithDict:(NSDictionary*)dict;
//
//"channelId": "5572a109b3cdc86cf39001db",
//"channelName": "国内最新",
//"desc": "引起社会的广泛关注和热烈讨论。",
//"imageurls": [],
//"link": "http://news.xinhuanet.com/politics/2015-07/05/c_1115820327.htm",
//"nid": "2678177830618688823",
//"pubDate": "2015-07-06 16:30:00",
//"source": "新华网",
//"title": "新华视点:深改小组四份文件聚焦生态建设透露哪些新信号? "
@end
