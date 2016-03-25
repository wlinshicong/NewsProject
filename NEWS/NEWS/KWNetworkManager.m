//
//  KWNetworkManager.m
//  weather
//
//  Created by tarena006 on 16/3/24.
//  Copyright © 2016年 Kerwin. All rights reserved.
//

#import "KWNetworkManager.h"

@implementation KWNetworkManager

+(void)sendRequestWithUrl:(NSString *)httpUrl withHttpArg:(NSString *)HttpArg success:(void (^)(NSData *, id))success failure:(void (^)(NSError *))failure{
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue:APIKEY forHTTPHeaderField: @"apikey"];
    
    NSURLSession *session=[NSURLSession sharedSession];
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            failure(error);
        } else {
            success(data,response);
        }
    }];
    [task resume];
}

@end
