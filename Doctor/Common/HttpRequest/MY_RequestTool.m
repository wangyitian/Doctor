//
//  MY_RequestTool.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/15.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_RequestTool.h"
#define BaseURL @""
@interface MY_RequestTool ()

@end

@implementation MY_RequestTool

+ (void)getDataWithURL:(NSString*)url paramter:(NSDictionary*)paramter success:(Success)success failure:(Failure)failure {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BaseURL]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    manager.requestSerializer.timeoutInterval = 10;
    
    [manager GET:@"" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *dic = (NSDictionary*)responseObject;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

+ (void)postDataWithURL:(NSString*)url paramter:(NSDictionary*)paramter success:(Success)success failure:(Failure)failure {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BaseURL]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    manager.requestSerializer.timeoutInterval = 10;
    
    [manager GET:@"" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *dic = (NSDictionary*)responseObject;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
@end
