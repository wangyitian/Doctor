//
//  MY_SegmentController.h
//  Doctor
//
//  Created by 王翼天 on 2017/3/1.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_BaseController.h"
#import "MY_SegmentContentView.h"
typedef enum : NSUInteger {
    MY_SegmentLoadStyle_CurrentPage, // 加载当前页
    MY_SegmentLoadStyle_All, // 一次加载全部页面
} MY_SegmentLoadStyle;

@interface MY_SegmentController : MY_BaseController
@property (nonatomic, strong, readonly) NSArray *viewControllers;
@property (nonatomic, strong) UIView *segmentView;
@property (nonatomic, strong) MY_SegmentContentView *segmentContentView;
/**
 初始化segmentVC
 
 @param viewControllers 子viewController
 @param height          segment高度
 
 @return 返回segmentViewController对象
 */
- (id)initWithViewControllers:(NSArray *)viewControllers segmentViewHeight:(CGFloat)height;

/**
 初始化segmentVC
 
 @param viewControllers 子viewController
 @param height          segment高度
 @param loadstyle       加载类型(全部加载/分步加载)
 @return 返回segmentViewController对象
 */
- (id)initWithViewControllers:(NSArray *)viewControllers segmentViewHeight:(CGFloat)height loadStyle:(MY_SegmentLoadStyle)loadstyle;

/**
 隐藏segmentView
 */
- (void)hideSegmentView;

/**
 显示segmentViewController
 */
- (void)showSegmentView;

/**
 选中某个segmentController
 
 @param index 下标
 */
- (void)setSelectedAt:(NSInteger)index;
/**
 选中某个segmentview
 
 @param index 下标
 */
-(void)setSegmentViewIndex:(NSInteger)index;

-(void)setSegmentViewOffsetX:(NSUInteger)offsetX;
@end
