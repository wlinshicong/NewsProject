//
//  KWNetworkManager.h
//  weather
//
//  Created by tarena006 on 16/3/24.
//  Copyright © 2016年 Kerwin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KWNetworkManager : NSObject

+(void)sendRequestWithUrl:(NSString*)httpUrl
              withHttpArg:(NSString*)HttpArg
                  success:(void(^)(NSData *data,id response))success
                  failure:(void(^)(NSError *error))failure;
@end
