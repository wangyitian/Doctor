//
//  MY_SegmentContentView.h
//  STBase
//
//  Created by stefan on 16/9/18.
//  Copyright © 2016年 qiyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MY_SegmentContentView;
@protocol MY_SegmentContentViewDelegate <NSObject>


- (void)segmentContentView:(MY_SegmentContentView *)segmentContentView
                selectPage:(NSUInteger)page;

- (void)segmentContentView:(MY_SegmentContentView *)segmentContentView selectOffsetX:(NSUInteger)offsetX;

@end


@interface MY_SegmentContentView : MY_View
@property (nonatomic, assign) NSUInteger pageCount;
@property (nonatomic, strong) NSArray *views;
@property (nonatomic, assign) id <MY_SegmentContentViewDelegate> delegate;
@property (nonatomic, assign) NSUInteger selectPage;
@property (nonatomic, strong) UIScrollView *scrollView;

/**
 *	@brief	添加一个视图到某一页
 *
 *	@param 	view 	单个视图
 *	@param 	page 	指定要插入的页码
 */
- (void)addView:(UIView *)view
         atPage:(NSUInteger)page;
@end
