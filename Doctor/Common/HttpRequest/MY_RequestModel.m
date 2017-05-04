//
//  MY_RequestModel.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/15.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_RequestModel.h"
@interface MY_RequestModel ()
@property (nonatomic, strong)AFHTTPSessionManager *manager;
@end

@implementation MY_RequestModel

- (instancetype)initWithDelegate:(id<MY_RequestModelDelegate>)delegate {
    if (self = [super init]) {
        self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:MY_BASE_API_PATH]];
        self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
        self.manager.requestSerializer.timeoutInterval = 10;
        self.delegate = delegate;
    }
    return self;
}

- (void)getDataWithURL:(NSString*)url paramter:(NSDictionary*)paramter success:(Success)success {
    //loading
    [((MY_BaseController*)self.delegate) showLoading];
    NSURLSessionDataTask *task = [self.manager GET:url parameters:paramter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *receiveStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData * data = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        //隐藏loading 和 mj相关的header和footer
        if ([self.delegate respondsToSelector:@selector(hideLoadingAndMJ)]) {
            [self.delegate hideLoadingAndMJ];
        }
        MY_Log(@"RequestUrl:%@\nParamter:%@\nResponse:%@\n",url,paramter,responseDic);
        //请求成功处理
        if ([responseDic[@"status"] isEqualToString:@"1"]) {
            success(task, responseDic);
            //特殊情况处理，例如单点登录
        } else if ([responseDic[@"status"] isEqualToString:@"999"]) {
            if ([self.delegate respondsToSelector:@selector(requestFailedForSingleLoginWithPreVC:)]) {
                [self.delegate requestFailedForSingleLoginWithPreVC:(UIViewController*)self.delegate];
            }
        } else {
            //请求出错
            if ([self.delegate respondsToSelector:@selector(requestErrorWithModel:responseDic:)]) {
                [self.delegate requestErrorWithModel:self responseDic:responseDic];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MY_Log(@"RequestUrl:%@\nParamter:%@\nError:%@\n",url,paramter,error);
        //隐藏loading 和 mj相关的header和footer
        if ([self.delegate respondsToSelector:@selector(hideLoadingAndMJ)]) {
            [self.delegate hideLoadingAndMJ];
        }
        //请求出错，例如没有网络等
        if ([self.delegate respondsToSelector:@selector(requestFailedWithModel:task:error:)]) {
            [self.delegate requestFailedWithModel:self task:task error:error];
        }
    }];
    [((MY_BaseController*)self.delegate).requestArray addObject:task];
}

- (void)postDataWithURL:(NSString*)url paramter:(NSDictionary*)paramter success:(Success)success {
    //loading
    self.url = url;
    [((MY_BaseController*)self.delegate) showLoading];
    NSURLSessionDataTask *task = [self.manager POST:url parameters:paramter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *receiveStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData * data = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        //隐藏loading 和 mj相关的header和footer
        if ([self.delegate respondsToSelector:@selector(hideLoadingAndMJ)]) {
            [self.delegate hideLoadingAndMJ];
        }
        MY_Log(@"RequestUrl:%@\nParamter:%@\nResponse:%@\n",url,paramter,responseDic);
        //请求成功处理
        if ([responseDic[@"status"] isEqualToString:@"1"]) {
            success(task, responseDic);
            //特殊情况处理，例如单点登录
        } else if ([responseDic[@"status"] isEqualToString:@"999"]) {
            if ([self.delegate respondsToSelector:@selector(requestFailedForSingleLoginWithPreVC:)]) {
                [self.delegate requestFailedForSingleLoginWithPreVC:(UIViewController*)self.delegate];
            }
            //请求出错
        } else {
            if ([self.delegate respondsToSelector:@selector(requestErrorWithModel:responseDic:)]) {
                [self.delegate requestErrorWithModel:self responseDic:responseDic];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MY_Log(@"RequestUrl:%@\nParamter:%@\nError:%@\n",url,paramter,error);
        //隐藏loading 和 mj相关的header和footer
        if ([self.delegate respondsToSelector:@selector(hideLoadingAndMJ)]) {
            [self.delegate hideLoadingAndMJ];
        }
        //请求出错，例如没有网络等
        if ([self.delegate respondsToSelector:@selector(requestFailedWithModel:task:error:)]) {
            [self.delegate requestFailedWithModel:self task:task error:error];
        }
    }];
    [((MY_BaseController*)self.delegate).requestArray addObject:task];
}

@end
