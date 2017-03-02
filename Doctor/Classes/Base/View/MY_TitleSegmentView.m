//
//  MY_TitleSegmentView.m
//  STBase
//
//  Created by stefan on 16/9/22.
//  Copyright © 2016年 qiyuan. All rights reserved.
//

#import "MY_TitleSegmentView.h"

@implementation MY_TitleSegmentItem
@synthesize title;

@end

@implementation MY_TitleSegmentView

@synthesize delegate=_delegate;
@synthesize dataArray=_dataArray;

-(instancetype)initWithFrame:(CGRect)frame
                   dataArray:(NSArray*)dataArray
                    delegate:(id<MY_TitleSegmentDelegate>)delegate
{
    self=[super initWithFrame:frame];
    if (self) {
        self.delegate=delegate;
        self.dataArray=[[NSMutableArray alloc] initWithArray:dataArray];
        CGFloat width=frame.size.width/[_dataArray count];
        
        UIImageView* endLine=[[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
        endLine.backgroundColor=[MY_Util setColorWithInt:0xdfdfdf];
        [self addSubview:endLine];
        
//        self.selectedLine=[[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-1, width, 1)];
//        self.selectedLine.backgroundColor=[self selectColor];
//        [self addSubview:self.selectedLine];
        
        for (MY_TitleSegmentItem* item in _dataArray) {
            int index=[[NSNumber numberWithInteger:[_dataArray indexOfObject:item]] intValue];
            UIView* view=[[UIView alloc] initWithFrame:CGRectMake(index*width, 0, width, frame.size.height)];
            view.backgroundColor=[UIColor clearColor];
            view.tag=100+index;
            [self addSubview:view];
            
            UILabel* titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, (view.frame.size.height-16)/2.0, width, 16)];
            titleLabel.backgroundColor=[UIColor clearColor];
            titleLabel.textColor=[UIColor blackColor];
            titleLabel.textAlignment=NSTextAlignmentCenter;
            titleLabel.numberOfLines=1;
            titleLabel.text=item.title;
            titleLabel.font=[UIFont systemFontOfSize:14];
            titleLabel.tag=300+index;
            [view addSubview:titleLabel];
            

            if (![item isEqual:[dataArray lastObject]]) {
//                UIImageView* verticalLine=[[UIImageView alloc] initWithFrame:CGRectMake(width, titleLabel.frame.origin.y, 1, frame.size.height)];
//                verticalLine.backgroundColor=[UIColor lightGrayColor];
//                [view addSubview:verticalLine];
//                
//                UIImageView* horizontalLine=[[UIImageView alloc] initWithFrame:CGRectMake(0, frame.size.height - 1, width, 1)];
//                horizontalLine.tag = 500 + index;
//                horizontalLine.backgroundColor=[UIColor lightGrayColor];
//                [view addSubview:horizontalLine];
//                
//                UIImageView* line=[[UIImageView alloc] initWithFrame:CGRectMake(width, 0, 1, self.frame.size.height - 1)];
//                line.backgroundColor= [MY_Util setColorWithInt:0xdfdfdf];
//                [view addSubview:line];
            }
            
            UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
            button.frame=view.bounds;
            button.tag=index;
            [button addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:button];
        }
    }
    return self;
}
-(void)reSetStatus {
    for (int i=0; i<[self.dataArray count]; i++) {
        UILabel* titleLabel=(UILabel*)[(UIView*)[self viewWithTag:100+i] viewWithTag:300+i];
        titleLabel.textColor=[self normalColor];
    }
}

-(UIColor*)normalColor {
    return [MY_Util setColorWithInt:0x666666];
}

-(UIColor*)selectColor {
    return [MY_Util setColorWithInt:0x68d6a7];
}


-(void)selectWithIndex:(NSInteger)index {
    [self reSetStatus];
//    CGFloat width=self.frame.size.width/[_dataArray count];
//    self.selectedLine.frame=CGRectMake(index*width, self.frame.size.height-1, width, 1);

    UILabel* titleLabel=(UILabel*)[(UIView*)[self viewWithTag:100+index] viewWithTag:300+index];
    titleLabel.textColor=[self selectColor];
//    UIImageView* horizontalLine = (UIImageView *)[self viewWithTag:500+index];
//    horizontalLine.backgroundColor = [self selectColor];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(didSelectWithIndex:)]) {
        MY_TitleSegmentItem* item=[self.dataArray objectAtIndex:index];
        [self.delegate didSelectWithIndex:item];
    }
}

-(void)selectWithOffset:(CGFloat)offset{
    
    NSUInteger page = (NSUInteger)offset % (NSUInteger)MY_ScreenWidth;
    NSInteger index = offset / MY_ScreenWidth;
    if (page == 0) {
        UILabel* titleLabel=(UILabel*)[(UIView*)[self viewWithTag:100+index] viewWithTag:300+index];
        titleLabel.textColor=[self selectColor];
//        UIImageView* horizontalLine = (UIImageView *)[self viewWithTag:500+index];
//        horizontalLine.backgroundColor = [self selectColor];
        if (self.delegate&&[self.delegate respondsToSelector:@selector(didSelectWithIndex:)]) {
            MY_TitleSegmentItem* item=[self.dataArray objectAtIndex:index];
            [self.delegate didSelectWithIndex:item];
        }

    }else{
        CGFloat width=self.frame.size.width/[_dataArray count];
        self.selectedLine.frame = CGRectMake(index + offset/[_dataArray count], self.frame.size.height - 1, width, 1);
        if (self.selectedLine.frame.origin.x == self.frame.size.width/2.0) {
            index ++;
        }
        
    }

}

-(void)selectAction:(UIButton*)sender {
    MY_TitleSegmentItem* item=[_dataArray objectAtIndex:((UIButton*)sender).tag];
    if (_delegate&&[_delegate respondsToSelector:@selector(didSelectWithIndex:)]) {
        [_delegate didSelectWithIndex:item];
    }
}

@end
