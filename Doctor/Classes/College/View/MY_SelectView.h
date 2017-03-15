//
//  MY_SelectView.h
//  Doctor
//
//  Created by 王翼天 on 2017/3/14.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SelectedBlock)(NSString *option);
@interface MY_SelectView : UIView
@property (nonatomic, strong) NSArray *options;
@property (nonatomic, copy) SelectedBlock selectedBlock;
@end
