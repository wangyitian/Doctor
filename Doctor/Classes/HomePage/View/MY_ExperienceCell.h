//
//  MY_ExperienceCell.h
//  Doctor
//
//  Created by 王翼天 on 2017/4/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_BaseCell.h"
typedef void(^ZanBlock)(void);


@protocol MY_ExperienceCellDelegate <NSObject>

- (void)zanActionWithIndexPath:(NSIndexPath*)indexPath isZan:(NSString*)isZan;
- (void)seeAllActionWithIndexPath:(NSIndexPath*)indexPath;

@end

@interface MY_ExperienceCell : MY_BaseCell
@property (nonatomic, copy) ZanBlock zanBlock;
@end
