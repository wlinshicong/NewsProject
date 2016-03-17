//
//  requestUrl.m
//  API调用
//
//  Created by tarena05 on 16/3/17.
//  Copyright © 2016年 tarena05. All rights reserved.
//

#import "requestUrl.h"


@interface requestUrl()
@property (nonatomic,strong)NSData *data;


@end


@implementation requestUrl

-(void)getNews{
    
       
    
    
}


-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"fa5044077ec1d4d9b52d272a752d0ef5" forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                              if (data) {//请求成功
                               
                                  if (error) {
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
                                                                       } else {
                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   NSLog(@"HttpResponseCode:%ld", responseCode);
                                   NSLog(@"HttpResponseBody %@",responseString);
                                      //成功返回data
                                    
                                        [[NSOperationQueue mainQueue]addOperationWithBlock:^{

                                            
                                            
                                            
                                                                           }];

                                      
                                      
                                      
                                  }
                                  
                              }else{
                                  NSLog(@"没有获取到数据");
                               
                                  }
                                  
                                  
                                  
                           }];
}






@end
