//
//  MY_TitleSegmentView.h
//  STBase
//
//  Created by stefan on 16/9/22.
//  Copyright © 2016年 qiyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MY_BaseModel.h"
@interface MY_TitleSegmentItem : MY_BaseModel

@property(nonatomic,strong)NSString* title;
@property(nonatomic,assign)NSInteger index;
@property (nonatomic, strong) NSArray *typeArray;

@end

@protocol MY_TitleSegmentDelegate <NSObject>

-(void)didSelectWithIndex:(MY_TitleSegmentItem*)indexItem;

@end

@interface MY_TitleSegmentView : MY_View

@property(nonatomic,assign)id<MY_TitleSegmentDelegate> delegate;
@property(nonatomic,strong)NSMutableArray* dataArray;
@property(nonatomic,strong)UIImageView* selectedLine;

-(instancetype)initWithFrame:(CGRect)frame
                   dataArray:(NSArray*)dataArray
                    delegate:(id<MY_TitleSegmentDelegate>)delegate;

-(void)selectAction:(id)sender;

-(void)reSetStatus;

-(void)selectWithIndex:(NSInteger)index;

-(void)selectWithOffset:(CGFloat)offset;

-(UIColor*)normalColor;

-(UIColor*)selectColor;

@end
