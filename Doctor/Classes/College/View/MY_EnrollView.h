//
//  MY_EnrollView.h
//  Doctor
//
//  Created by 王翼天 on 2017/2/20.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SubmitBlock)(NSDictionary *paramter);
@interface MY_EnrollView : MY_View

@property (nonatomic, copy) SubmitBlock submitBlock;

@end
