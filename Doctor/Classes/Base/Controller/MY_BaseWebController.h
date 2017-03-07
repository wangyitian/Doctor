//
//  MY_BaseWebController.h
//  Doctor
//
//  Created by 王翼天 on 2017/3/7.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_BaseController.h"

@interface MY_BaseWebController : MY_BaseController<UIWebViewDelegate>
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSURL *shareUrl;
@property (nonatomic, strong) UIWebView *webView;
@end
