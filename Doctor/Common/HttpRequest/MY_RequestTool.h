//
//  MY_RequestTool.h
//  Doctor
//
//  Created by 王翼天 on 2017/2/15.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
typedef void(^Success)(AFHTTPRequestSerializer *operation, NSDictionary *dic);
typedef void(^Failure)(AFHTTPRequestSerializer *operation, NSError *error);
@interface MY_RequestTool : NSObject

+ (void)getDataWithURL:(NSString*)url paramter:(NSDictionary*)paramter success:(Success)success failure:(Failure)failure;

+ (void)postDataWithURL:(NSString*)url paramter:(NSDictionary*)paramter success:(Success)success failure:(Failure)failure;
@end
