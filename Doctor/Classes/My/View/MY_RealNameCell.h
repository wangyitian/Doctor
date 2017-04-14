//
//  MY_RealNameCell.h
//  Doctor
//
//  Created by 王翼天 on 2017/4/14.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_BaseCell.h"

@protocol RealNameCellProtocol <NSObject>

- (void)uploadPhotoWithIndex:(NSIndexPath*)indexPath;

@end

@interface MY_RealNameCell : MY_BaseCell

@end
