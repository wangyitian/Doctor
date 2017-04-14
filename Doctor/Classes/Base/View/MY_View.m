//
//  MY_View.m
//  Doctor
//
//  Created by 王翼天 on 2017/4/13.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_View.h"

@implementation MY_View

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (MY_BaseController *)findController {
    id target = self;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[MY_BaseController class]]) {
            break;
        }
    }
    return target;
}

- (void)alertWithMessage:(NSString*)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
    [[self findController] presentViewController:alert animated:YES completion:nil];
}

@end
