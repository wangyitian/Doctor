//
//  MY_RequestModel.h
//  Doctor
//
//  Created by 王翼天 on 2017/2/15.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@class MY_RequestModel;
typedef void(^Success)(NSURLSessionDataTask *operation, NSDictionary *dic);
typedef void(^Failure)(NSURLSessionDataTask *operation, NSError *error);

@protocol MY_RequestModelDelegate <NSObject>

- (void)requestFailedForSingleLoginWithPreVC:(UIViewController*)preVC;

- (void)requestErrorWithModel:(MY_RequestModel*)requestModel responseDic:(NSDictionary*)responseDic;

- (void)requestFailedWithModel:(MY_RequestModel*)requestModel task:(NSURLSessionDataTask*)task error:(NSError*)error;

@end


@interface MY_RequestModel : NSObject
@property (nonatomic, assign) id<MY_RequestModelDelegate> delegate;

- (void)getDataWithURL:(NSString*)url paramter:(NSDictionary*)paramter success:(Success)success;
//
//- (void)getDataWithURL:(NSString*)url paramter:(NSDictionary*)paramter success:(Success)success failure:(Failure)failure;
//
//- (void)postDataWithURL:(NSString*)url paramter:(NSDictionary*)paramter success:(Success)success failure:(Failure)failure;
@end
