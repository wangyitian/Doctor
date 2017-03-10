//
//  MY_RecommendView.h
//  Doctor
//
//  Created by 王翼天 on 2017/2/20.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RecommendBlock)(NSDictionary *paramter);
@interface MY_RecommendView : UIView
@property (nonatomic, copy) RecommendBlock recommendBlock;
@end
