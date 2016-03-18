//
//  TableViewCell.m
//  API调用
//
//  Created by tarena05 on 16/3/17.
//  Copyright © 2016年 tarena05. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

-(instancetype)initWithDict:(NSDictionary *)dict{
    TableViewCell *cell=[[TableViewCell alloc]init];
    cell.channelId=dict[@"channelId"];
    cell.channelName=dict[@"channelName"];
    cell.desc=dict[@"desc"];

    cell.imageurls=dict[@"imageurls"];
    cell.link=dict[@"link"];
    cell.nid=dict[@"nid"];
    cell.pubDate=dict[@"pubDate"];
    cell.source=dict[@"source"];
    cell.title=dict[@"title"];

    return cell;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
