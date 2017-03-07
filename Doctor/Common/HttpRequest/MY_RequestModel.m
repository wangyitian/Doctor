//
//  MY_RequestModel.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/15.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_RequestModel.h"
#define BaseURL @""
@interface MY_RequestModel ()
@property (nonatomic, strong)AFHTTPSessionManager *manager;
@end

@implementation MY_RequestModel

- (instancetype)init {
    if (self = [super init]) {
        self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BaseURL]];
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
        self.manager.requestSerializer.timeoutInterval = 10;
    }
    return self;
}

- (void)getDataWithURL:(NSString*)url paramter:(NSDictionary*)paramter success:(Success)success {
    [self.manager GET:@"" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {        NSDictionary *responseDic = (NSDictionary*)responseObject;
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            success(task, responseDic);
        } else if ([responseObject[@"status"] isEqualToString:@"999"]) {
            if ([self.delegate respondsToSelector:@selector(requestFailedForSingleLoginWithPreVC:)]) {
                [self.delegate requestFailedForSingleLoginWithPreVC:(UIViewController*)self.delegate];
            }
        } else {
            if ([self.delegate respondsToSelector:@selector(requestErrorWithModel:responseDic:)]) {
                [self.delegate requestErrorWithModel:self responseDic:responseDic];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if ([self.delegate respondsToSelector:@selector(requestFailedWithModel:task:error:)]) {
            [self.delegate requestFailedWithModel:self task:task error:error];
        }
    }];
}

//- (void)getDataWithURL:(NSString*)url paramter:(NSDictionary*)paramter success:(Success)success failure:(Failure)failure {
//    [self.manager GET:@"" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {        NSDictionary *responseDic = (NSDictionary*)responseObject;
//        if ([responseObject[@"status"] isEqualToString:@"1"]) {
//            success(task, responseDic);
//        } else if ([responseObject[@"status"] isEqualToString:@"999"]) {
//            if ([self.delegate respondsToSelector:@selector(requestFailedForSingleLoginWithPreVC:)]) {
//                [self.delegate requestFailedForSingleLoginWithPreVC:(UIViewController*)self.delegate];
//            }
//        } else {
//            if ([self.delegate respondsToSelector:@selector(requestFailedWithModel:responseDic:)]) {
//                [self.delegate requestFailedWithModel:self responseDic:responseDic];
//            }
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        failure(task, error);
//    }];
//}

//- (void)postDataWithURL:(NSString*)url paramter:(NSDictionary*)paramter success:(Success)success failure:(Failure)failure {
//    [self.manager POST:@"" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *responseDic = (NSDictionary*)responseObject;
//        if ([responseObject[@"status"] isEqualToString:@"1"]) {
//            success(task, responseDic);
//        } else if ([responseObject[@"status"] isEqualToString:@"999"]) {
//            if ([self.delegate respondsToSelector:@selector(requestFailedForSingleLoginWithPreVC:)]) {
//                [self.delegate requestFailedForSingleLoginWithPreVC:(UIViewController*)self.delegate];
//            }
//        } else {
//            if ([self.delegate respondsToSelector:@selector(requestFailedWithModel:responseDic:)]) {
//                [self.delegate requestFailedWithModel:self responseDic:responseDic];
//            }
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//    }];
//}
@end
