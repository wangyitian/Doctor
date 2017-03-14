//
//  MY_BaseScrollController.h
//  Doctor
//
//  Created by 王翼天 on 2017/2/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_BaseController.h"
#import "TPKeyboardAvoidingScrollView.h"
@interface MY_BaseScrollController : MY_BaseController
@property (nonatomic, strong) TPKeyboardAvoidingScrollView* scrollView;

@end
