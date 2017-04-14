//
//  MY_HotSearchView.h
//  Doctor
//
//  Created by 王翼天 on 2017/3/20.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^HotSearchBlock)(NSString *search);
@interface MY_HotSearchView : MY_View
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, copy) HotSearchBlock hotSearchBlock;
@end
