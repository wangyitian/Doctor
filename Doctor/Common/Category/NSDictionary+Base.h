//
//  NSDictionary+Base.h
//  YiMei
//
//  Created by 刘玉娇 on 15/10/26.
//  Copyright © 2015年 Xiaolinxiaoli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Base)

- (NSString*)stringWithKey:(NSString*)key;

- (NSArray*)arrayWithKey:(NSString*)key;

- (NSDictionary*)dicWithKey:(NSString*)key;

@end
